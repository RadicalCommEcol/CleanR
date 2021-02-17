#' Title
#'
#' @param template
#' @param newdat
#'
#' @return
#' @export
#'
#' @examples
drop_variables <- function(template, newdat){
  dat <- newdat[template[["variables"]]]
  dat
}
