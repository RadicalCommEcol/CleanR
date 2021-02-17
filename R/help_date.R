#' help_date
#'
#' @param x
#'
#' @return
#' @export
#'
#' @examples
help_date <- function(x){
  print("temp <- as.POSIXlt(newdat$date, format = '%m/%d/%Y') #extract month and day")
  print("newdat$month <- format(temp,'%m')")
  print("newdat$day <- format(temp,'%d')")
  print("newdat$year <- temp$year+3900")
}
