.date_splitter <- function(x){
  x <- as.Date(x, origin = "1970-01-01")
  tmp <- list()
  tmp$year <- as.integer(format(x, "%Y"))
  tmp$month <- as.integer(format(x, "%m"))
  tmp$day <- as.integer(format(x, "%d"))
  return(tmp)
}
