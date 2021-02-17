#' extract_date
#'
#' @param date_var
#' @param format_
#' @param offset
#'
#' @return
#' @export
#'
#' @examples
extract_date <- function(date_var, format_ = "%m/%d/%Y", offset = 1900){
  date_var <- as.character(date_var)
  temp <- as.POSIXlt(date_var, format = format_) #extract month and day
  month <- format(temp,'%m')
  day <- format(temp,'%d')
  year <- temp$year+offset #CHECK, specially with other formats.
  data.frame(date_var, month, day, year)
}
