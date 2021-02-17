#' define_template
#'
#' @param example: a model data.frame
#' @param species_tesaurus a speices checklist (vector)
#'
#' @return a list
#' @export
#'
#' @examples
define_template <- function(example, species_tesaurus){
  i <- sapply(example, is.factor)
  example[i] <- lapply(example[i], as.character)
  variables <- colnames(example)
  classes <- sapply(example, class)
  i <- sapply(example, is.numeric)
  min_ <- rep(NA, ncol(example))
  max_ <- rep(NA, ncol(example))
  min_[i] <- lapply(example[i], min)
  max_[i] <- lapply(example[i], max)
  dat <- data.frame(variables, classes, min_ = unlist(min_), max_ = unlist(max_), stringsAsFactors = FALSE)
  #maybe add allowed factors? how?
  species_tesaurus <- unique(as.character(species_tesaurus))
  template <- list(variables = variables, dat = dat, tesaurus = species_tesaurus)
  template
}
