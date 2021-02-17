#' add_uid
#'
#' @param newdat
#' @param name
#'
#' @return
#' @export
#'
#' @examples
add_uid <- function(newdat, name = "id"){
  #if(all(is.na(newdat$uid))){
  uid <- paste0(name, 1:nrow(newdat))
  #}
  newdat$uid <- uid
  newdat
}
