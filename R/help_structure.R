#' help_structure
#'
#' @return
#' @export
#'
#' @examples
help_structure <- function(){
  print("Note: use control-alt in Rstudio to edit all lines in bulk")
  print("check <- define_template(template, species_tesaurus)")
  print("newdat <- read.csv(file = 'rawdata/csvs/test.csv')")
  print("compare_variables(check, newdat)")
  print("#colnames(newdat)[which(colnames(newdat) == 'badname')] <- 'goodname' #Rename variables if needed")
  print("newdat <- add_missing_variables(check, newdat)")
  print("#extract_pieces()")
  print("#help_geo()")
  print("#help_species()")
  print("#help_date()")
  print("newdat <- drop_variables(check, newdat) #reorder and drop variables")
  print("summary(newdat)")
  print("newdat <- add_uid(newdat = newdat, 'test')")
  print("write.table(x = newdat, file = 'data/data.csv', quote = TRUE, sep = ',', col.names = FALSE, row.names = FALSE, append = TRUE)")
  print("size <- size + nrow(newdat) #keep track of expected length in case of processing several datasets")
}
