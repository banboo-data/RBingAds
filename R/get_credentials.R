#' @title Authentication of R app
#' @description get_credentials authenticates the R app at the
#' Bing authentication server and receives the client token.
#' Usually you need not to run get_credentials() explicitly
#' since the whole authentication process is managed by \code{\link{authenticate}}.
#' @importFrom utils browseURL
#' @return Client token from Bing authentication server.
.get_credentials <- function(){

  if(!exists("credentials")){

    # Authenticate user to get code
    cat("Authentication process needs your Bing Client ID.")
    c_id <- readline(as.character(cat(
      "\n\nPaste the Client ID here",
      ":=>"
    )))
    if (c_id == "") {
      return(print("You have to provide a Client ID."))
    } else {
      credentials <- data.frame(c_id, stringsAsFactors = F)
      }

    cat("Authentication process needs your Client Secret.")
    credentials$c_secret <-
      readline(as.character(cat(
        "\n\nPaste the Client secret here",
        ":=>"
      )))

    cat("Authentication process needs your Developer Token.")
    credentials$auth_developer_token <-
      readline(as.character(cat(
        "\n\nPaste the Developer Token here",
        ":=>"
      )))
  }

  if (exists("credentials")){
    url <- sprintf("https://login.live.com/oauth20_authorize.srf?client_id=%s&scope=bingads.manage&response_type=code&redirect_uri=%s&state=ClientStateGoesHere",
                   credentials$c_id,
                   "http://localhost")
    browseURL(url)
    credentials$auth_code <- readline("Please enter the code from the URL: ")
  }

  credentials
}
