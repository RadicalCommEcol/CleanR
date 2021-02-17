#' extract_pieces
#'
#' @param to_split
#' @param pattern_
#' @param i
#' @param f
#' @param k
#' @param subgenus
#' @param species
#' @param single
#'
#' @return
#' @export
#'
#' @examples
extract_pieces <- function(to_split, pattern_ = "_", i = 1, f = 0, k = 1,
                           subgenus = FALSE, species = FALSE, single = TRUE){
  to_split <- as.character(to_split)
  if(subgenus){
    pattern_ <- "_("
    i <- 2
    f <- 1
    k <- 1
  }
  if(species){
    pattern_ <- " "
    i <- 1
    f <- 0
    k <- 1
  }
  if(single) temp <- unlist(regexpr(pattern = pattern_, fixed = TRUE, text = to_split))
  if(!single) temp <- unlist(gregexpr(pattern = pattern_, fixed = TRUE, text = to_split))
  piece1 <- rep(NA, length(to_split))
  piece2 <- rep(NA, length(to_split))
  out <- data.frame(to_split, piece2, piece1)
  for(j in which(temp > 0)){
    out$piece1[j] <- substr(to_split[j], start = temp[j]+i,
                            stop = nchar(to_split[j])-f)
    out$piece2[j] <- substr(to_split[j], start = 1,
                            stop = temp[j]-k)
  }
  out
}
