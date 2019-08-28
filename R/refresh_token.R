#' @title  Refresh the Access Token
#'
#' @description refresh_token returns a new valid access token. The access token deprecates after one hour and has to updated with the refresh token.
#' Usually you need not to run refresh_token() explicitly since the whole authentication process is managed by \code{\link{authenticate}}.
#'
#' @param credentials list of credentials
#' @param refresh_token refresh token from previous authentication
#'
#' @importFrom httr POST add_headers
#' @importFrom jsonlite fromJSON
#'
#' @return Access token with corresponding time stamp.
.refresh_token <- function(credentials, refresh_token){

  request_body <- list(client_id=credentials$c_id,
                       client_secret=credentials$c_secret,
                       grant_type="refresh_token",
                       redirect_uri="http://localhost",
                       refresh_token=refresh_token)

  request_header <- c("Content-Type" =  "application/x-www-form-urlencoded",
                      "Accept" = "application/json",
                      "Host" = "login.live.com")

  response <- POST("https://login.live.com/oauth20_token.srf",
                   body = request_body,
                   encode = "form",
                   add_headers(.headers = request_header))

  contents = fromJSON(rawToChar(response$content))

  if (length(contents) == 1) {
    message("You need to update the token - run authenticate()")
  } else {
    contents$time_stamp <- as.numeric(Sys.time())
  }

  contents
}
