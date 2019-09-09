#' @title Load Bing Data
#' @description load_bing_data queries the Bing Ads API and loads the data.
#' Note: There is a function timeout after ten seconds if the data download url is not available.
#' @param bing_auth auth object generated with authenticate()
#' @param account_id account id
#' @param report report type
#' @param columns columns, attributes and metrics
#' @param start start date
#' @param end end date
#' @param time_out function time out in seconds
#' @examples
#' \dontrun{
#' data <- load_bing_data(bing_auth = bing_auth,
#'                        account_id = "*******",
#'                        report = "CampaignPerformanceReport",
#'                        columns = c("AccountName", "CampaignName",
#'                                    "TimePeriod", "Impressions",
#'                                    "Clicks", "Spend", "Conversions"),
#'                        start = "2019-01-01",
#'                        end = "2019-01-31")
#' }
#'
#' @return data
#' @export
load_bing_data <- function(bing_auth,
                           account_id,
                           report,
                           columns,
                           start,
                           end,
                           time_out = 5) {
  if (as.numeric(Sys.time()) - bing_auth$access$expires_in >= bing_auth$access$time_stamp) {
    bing_auth$access <-
      .refresh_token(
        credentials = bing_auth$credentials,
        refresh_token = bing_auth$access$refresh_token
      )
  }

  report_id <- get_report_id(
    bing_auth = bing_auth,
    account_id = account_id,
    report = report,
    columns = columns,
    start = start,
    end = end
  )

  download_url <- get_download_url(bing_auth = bing_auth,
                                   report_id = report_id)

  start_time <- as.numeric(Sys.time())

  while (class(download_url) == "XMLAttributes" &
         as.numeric(Sys.time()) - start_time < time_out) {
    download_url <- get_download_url(bing_auth = bing_auth,
                                     report_id = report_id)
  }

  if (grepl("https", download_url)) {
    data <- download_data(download_url = download_url)
    data

  } else {
    NULL

  }

}
