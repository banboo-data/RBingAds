#' @title Download Reporting Data
#' @description downloads data from download_url
#' @param download_url url created with get_report_url
#' @importFrom utils download.file read.csv unzip
#' @return data
download_data <- function(download_url) {
        temp_file <- file.path(tempdir(), "temp.zip")
        download.file(
                url = download_url,
                destfile = temp_file,
                mode = 'wb',
                method = 'auto'
        )
        file <- unzip(temp_file, list = TRUE)
        df <- read.csv(unz(temp_file, file$Name), stringsAsFactors = F)
        close(unz(temp_file, file$Name))
        unlink(temp_file)
        df
}
