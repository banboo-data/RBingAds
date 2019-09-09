#' @title Invoke the Authentication Process with Bing
#' @description This function starts the authentication process with
#' Bing. Note that this interactive function needs user interaction.
#' @param save logical, should the authentication information should be saved on disk? Defaults to FALSE.
#' @param path path to auth file directory
#' @param gitignore logical, adds/creates the authentication information to .gitignore. Defaults to FALSE
#' @examples
#' \dontrun{
#' bing_auth <- authenticate(save = T,
#'                           path = ".bingauth",
#'                           gitignore = T)
#' }
#' @return data.frame containing credentials, optionally saved as .RData in the current working directory
#' @export
authenticate <- function(save = F,
                         path = ".bingauth",
                         gitignore = F) {
  if (exists("bing_auth")) {
    bing_auth$access <-
      .refresh_token(
        credentials = bing_auth$credentials,
        refresh_token = bing_auth$access$refresh_token
      )
  }
  else if (file.exists(file.path(path, ".bing.auth.RData"))) {
    load(file.path(path, ".bing.auth.RData"))
    bing_auth$access <-
      .refresh_token(
        credentials = bing_auth$credentials,
        refresh_token = bing_auth$access$refresh_token
      )
  } else {
    credentials <- .get_credentials()
    access_token <- .load_token(credentials)
    bing_auth <- list()
    bing_auth$credentials <- credentials
    bing_auth$access <- access_token
  }

  if (save) {
    if (!dir.exists(paths = path)) {
      dir.create(path = path)
    }
    save("bing_auth", file = file.path(path, ".bing.auth.RData"))
  }

  if (gitignore) {
    # make sure your credentials are
    # ignored by svn and git
    if (!file.exists(".gitignore")) {
      cat(file.path(path, ".bing.auth.RData"),
          file = ".gitignore",
          sep = "\n")
    }
    if (file.exists(".gitignore")) {
      gitignore <- readLines(".gitignore")
      if (!is.element(file.path(path, ".bing.auth.RData"), gitignore)) {
        cat(
          file.path(path, ".bing.auth.RData"),
          file = ".gitignore",
          append = TRUE,
          fill = TRUE
        )
      }
    }
  }

  bing_auth
}
