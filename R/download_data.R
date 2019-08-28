#' @title Download Reporting Data
#'
#' @description downloads data from download_url
#'
#' @param download_url url created with get_report_url
#'
#' @importFrom utils download.file read.csv unzip zip
#'
#' @examples
#' \dontrun{
#' data <- download_data(download_url = download_url)
#' }
#'
#' @return data
#'
#' @export
download_data <- function(download_url){
 download.file(url = download_url, destfile = "tmp.zip", mode = 'wb', method ='auto')
 unzip("tmp.zip")
 files <- unzip("tmp.zip", list = TRUE)
 df <- read.csv(files$Name[1])
 file.remove("tmp.zip")
 file.remove(files$Name[1])
 return(df)
}
