#' @title Get Report ID
#'
#' @description get_report_id queries the Bing API and request a report id.
#'
#' @param bing_auth auth object generated with authenticate()
#' @param customer_id customer / manager id
#' @param account_id account id
#' @param report report type
#' @param columns columns, attributes and metrics
#' @param start start date
#' @param end end date
#'
#' @importFrom XML xmlToList
#' @importFrom RCurl curlPerform basicTextGatherer
#'
#' @examples
#' \dontrun{
#' report_id <- get_report_id(bing_auth = bing_auth,
#'                          customer_id = "******",
#'                          account_id = "*******",
#'                          report = "CampaignPerformanceReport",
#'                          columns = c("AccountName", "CampaignName",
#'                                      "TimePeriod", "Impressions",
#'                                      "Clicks", "Spend", "Conversions"),
#'                          start = "2019-01-01",
#'                          end = "2019-01-31")
#' }
#'
#' @export
get_report_id <- function(bing_auth,
                          customer_id,
                          account_id,
                          report,
                          columns,
                          start,
                          end){

  start_date <- .date_splitter(start)
  end_date <- .date_splitter(end)
  url <- "https://reporting.api.bingads.microsoft.com/Api/Advertiser/Reporting/v13/ReportingService.svc"
  soap_action <- "SubmitGenerateReport"
  header <- paste(readLines(paste0(system.file(package = "RBingAds"), "/xml/reporting.header.xml")), collapse = "")
  body_xml <- paste(readLines(paste0(system.file(package = "RBingAds"), "/xml/reporting.submitGenerateReportRequest.xml")), collapse = "")
  columns_xml <- .get_columns_xml(report, columns)

  body_xml <- sprintf(body_xml,
                     report,
                     columns_xml,
                     account_id,
                     end_date$day,
                     end_date$month,
                     end_date$year,
                     start_date$day,
                     start_date$month,
                     start_date$year)

  body <- sprintf(header,
                  soap_action,
                  bing_auth$credentials$c_id,
                  bing_auth$access$access_token,
                  customer_id,
                  account_id,
                  bing_auth$credentials$auth_developer_token,
                  body_xml)

  headerFields =  c(Accept = "text/xml", Accept = "multipart/*", 'Content-Type' = "text/xml;charset=utf-8", SOAPAction = soap_action)
  h = basicTextGatherer()
  curlPerform(url = url, httpheader = headerFields, postfields = body, writefunction = h$update)
  reportId <- xmlToList(h$value())$Body$SubmitGenerateReportResponse$ReportRequestId
  return(reportId)
}
