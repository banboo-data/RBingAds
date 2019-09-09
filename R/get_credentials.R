#' @title Authentication of R app
#' @description get_credentials authenticates the R app at the
#' Bing authentication server and receives the client token.
#' Usually you need not to run get_credentials() explicitly
#' since the whole authentication process is managed by \code{\link{authenticate}}.
#' @importFrom utils browseURL
#' @return Client token from Bing authentication server.
.get_credentials <- function() {
  if (!exists("credentials")) {
    # Authenticate user to get code
    c_id <-
      readline(prompt = "Authentication process needs your Bing Client ID. Enter Bing Client ID: ")
    if (c_id == "") {
      stop("You have to provide a Client ID.")
    } else {
      credentials <- data.frame(c_id, stringsAsFactors = F)

      credentials$c_secret <-
        readline("Paste the Client Secret: ")

      credentials$auth_developer_token <-
        readline("Paste the Developer Token: ")

    }
  }

  if (exists("credentials")) {
    url <-
      sprintf(
        "https://login.live.com/oauth20_authorize.srf?client_id=%s&scope=bingads.manage&response_type=code&redirect_uri=%s&state=ClientStateGoesHere",
        credentials$c_id,
        "http://localhost"
      )
    browseURL(url)
    credentials$auth_code <-
      readline("Please enter the code from the URL: ")
  }

  credentials
}
