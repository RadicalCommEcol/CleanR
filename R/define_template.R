#' define_template
#'
#' @param example: a model data.frame with all possible categories and min and max numeric values allowed.
#' @param species_tesaurus a speices checklist (data frame with columns Genus and Species)
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
  j <- sapply(example, is.numeric)
  min_ <- rep(NA, ncol(example))
  max_ <- rep(NA, ncol(example))
  min_[j] <- lapply(example[j], min)
  max_[j] <- lapply(example[j], max)
  dat <- data.frame(variables, classes, min_ = unlist(min_), max_ = unlist(max_), stringsAsFactors = FALSE)
  #maybe add allowed factors? how?
  cats <- list()
  if(any(i)){
    for(k in 1:length(example[i])){
      temp <- unique(example[i][k])
      cats <- append(cats, temp)
    }
  } else {
    cats <- NA
  }
  #species_tesaurus <- unique(as.character(species_tesaurus))
  template <- list(variables = variables, dat = dat, categorical = cats, tesaurus = species_tesaurus)
  template
}
