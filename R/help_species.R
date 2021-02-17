#' help_species
#'
#' @return
#' @export
#'
#' @examples
help_species <- function(){
  print(paste("Remove whitespace:", "trimws()"))
  print(paste("Split in two: strsplit()"))
  print("e.g. temp <- strsplit(x = var_to_split, split = ' ') for (i in 1:length(var_to_split)){
        newvar[i] <- temp[[i]][2] #for second split}")
  print(paste("Select rows with pattern x:", "grep(pattern = 'sp_', x = variable, fixed = TRUE)"))
  print(paste("Substitute characters:", "gsub('-type', '', variable)"))
}
