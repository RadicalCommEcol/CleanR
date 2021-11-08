#' compare_variables
#'
#' @param template
#' @param newdat
#'
#' @return
#' @export
#'
#' @examples
compare_variables <- function(template, newdat, threshold = 1.5){
  i <- sapply(newdat, is.factor)
  newdat[i] <- lapply(newdat[i], as.character)
  missing <- template[["variables"]][which(!template[["variables"]] %in%
                                             colnames(newdat))]
  leftovers <- colnames(newdat)[which(!colnames(newdat) %in%
                                        template[["variables"]])]
  print(paste("the following variables were extra:", leftovers))
  print(paste("the following variables were missing:", missing))
  #variables with wrong class.
  newclasses <- sapply(newdat[,], class)
  #variables above min/max
  i <- sapply(newdat, is.numeric)
  newmin_ <- rep(NA, ncol(newdat))
  newmax_ <- rep(NA, ncol(newdat))
  newmin_[i] <- lapply(newdat[i], min)
  newmax_[i] <- lapply(newdat[i], max)
  newtemp <- data.frame(variables = names(newclasses), newclasses = newclasses,
                        newmin_ = unlist(newmin_),
             newmax_ = unlist(newmax_), stringsAsFactors = FALSE)
  merged <- merge(template[["dat"]], newtemp, all = FALSE)
  print("Variables with unmatching classes")
  print(merged[which(merged$classes != merged$newclasses),c(1,2,5)])
  #variables above 1.5x max.
  print("Numeric variables out of range")
  print(merged[which(merged$newmin_ < merged$min_ | merged$newmax_ > merged$max_),
               c(1,3:4,6:7)])
  #categorical variables with wrong categories
  #TO BE DONE using template$categorical
}
