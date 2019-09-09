#' @title Loading the Access Token
#' @description load_token loads the access token using credentials provided by another internal function (dot-get_credentials). Execution of function is possible only once per authentication process.
#' Usually you need not to run load_token() explicitly since the whole authentication process is managed by \code{\link{authenticate}}.
#' @param credentials list of credentials
#' @importFrom httr POST add_headers
#' @importFrom jsonlite fromJSON
#' @return Access token with corresponding time stamp.
.load_token <- function(credentials) {
  request_body <- list(
    client_id = credentials$c_id,
    client_secret = credentials$c_secret,
    grant_type = "authorization_code",
    redirect_uri = "http://localhost",
    code = credentials$auth_code
  )

  request_header <-
    c("Content-Type" =  "application/x-www-form-urlencoded",
      "Accept" = "application/json",
      "Host" = "login.live.com")

  response <- POST(
    "https://login.live.com/oauth20_token.srf",
    body = request_body,
    encode = "form",
    add_headers(.headers = request_header)
  )

  contents = fromJSON(rawToChar(response$content))

  if (length(contents) == 1) {
    message("You need to update the token - run authenticate()")
  } else {
    contents$time_stamp <- as.numeric(Sys.time())
  }

  contents

}
