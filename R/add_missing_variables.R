#' Title
#'
#' @param template
#' @param newdat
#'
#' @return
#' @export
#'
#' @examples
add_missing_variables <- function(template, newdat){
  missing <- template[["variables"]][which(!template[["variables"]] %in%
                                             colnames(newdat))]
  for(i in missing){
    newdat <- cbind(newdat, assign(x = paste0(i), value = rep(NA,nrow(newdat))))
    colnames(newdat)[ncol(newdat)] <- paste0(i)
  }
  print(paste("the following variables were missing:", missing))
  newdat
}
