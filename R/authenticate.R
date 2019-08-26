#' @title  Invoke the Authentication Process with Bing
#'
#' @description This function starts the authentication process with
#' Bing. Note that this function needs user interaction.
#'
#' @param save logical, should the authentication information should be saved on disk? Defaults to TRUE.
#'
#' @return data.frame containing credentials, optionally saved as .RData in the current working directory
#'
#' @export
authenticate <- function(save = T){

  if(file.exists(".bing.auth.RData")){
    load(".bing.auth.RData")
    bing_auth$access <- .refresh_token(credentials = bing_auth$credentials,
                                       refresh_token = bing_auth$access$refresh_token)
  } else {
    credentials <- .get_credentials()
    access_token <- .load_token(credentials)
    bing_auth <- list()
    bing_auth$credentials <- credentials
    bing_auth$access <- access_token

    if (save) {
      save("bing_auth", file = ".bing.auth.RData")
      # make sure your credentials are
      # ignored by svn and git
      if (!file.exists(".gitignore")) {
        cat(".bing.auth.RData",
            file = ".gitignore",
            sep = "\n"
        )
      }
      if (file.exists(".gitignore")) {
        gitignore <- readLines(".gitignore")
        if (!is.element(".bing.auth.RData", gitignore)) {
          cat(".bing.auth.RData",
              file = ".gitignore",
              append = TRUE, fill = TRUE
          )
        }
      }
    }
  }

  if (exists("bing_auth")) {
    bing_auth
  } else {
    cat("an error occurred.")
  }
}
