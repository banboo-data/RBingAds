.get_columns_xml <- function(report, columns){
  columns_xml <- ""
  for(column in columns){
    columns_xml <- paste0(columns_xml, "<", report, "Column>", column, "</", report, "Column>")
  }
  return(columns_xml)
}
