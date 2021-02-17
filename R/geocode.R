#' geocode
#'
#' @param places
#'
#' @return
#' @export
#'
#' @examples
geocode <- function(places){
  require(tmaptools)
  long <- rep(NA, length(places))
  lat <- rep(NA, length(places))
  for(i in 1:length(places)){
    temp <- geocode_OSM(places [i])
    if(!is.null(temp)){
      long[i] <- temp$coords[2]
      lat[i] <- temp$coords[1]
    }
    print(paste(i, "palces done out of",  length(places)))
  }
  data.frame(places, lat, long)
}
