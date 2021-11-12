#' check_sp
#'
#' @param template
#' @param Genus
#' @param Species
#' @param k: number of changes allowed by the fuzzy matching function.
#'
#' @return
#' @export
#'
#' @examples
check_sp <- function(template, Genus, Species, k = 2){ #if Gen_sp, we can add an if.
  Gen_sp <- paste(trimws(Genus),
                  trimws(Species))
  species_tesaurus <- template$tesaurus
  species_tesaurus$Gen_sp <- paste(trimws(species_tesaurus$Genus),
                                   trimws(species_tesaurus$Species))
  matching <- Gen_sp[which(Gen_sp %in% species_tesaurus$Gen_sp)]
  unmatching <- Gen_sp[which(!Gen_sp %in% species_tesaurus$Gen_sp)]
  mismatches <- unique(unmatching) #speed up the process
  print(paste("the following species do not match:", mismatches))
  fixed <- c()
  #agrep is too lax, and I can't make it to work, adist is better
  #agrep(c("Coleoxys"), genus, value = TRUE, max = list(all = 2))
  #agrep(c("Lasius"), genus, value = TRUE, max = list(ins = 3, del = 3, sub = 2))
  for(i in 1:length(mismatches)){
    temp2 <- species_tesaurus$Gen_sp[as.logical(adist(mismatches[i],
                                                      species_tesaurus$Gen_sp) <= k)]
    if(length(temp2) == 1){
      fixed[i] <- temp2
    } else {
      fixed[i] <- NA
    }
  }
  to_recover <- data.frame(mismatches, fixed, stringsAsFactors = FALSE)
  to_recover
}
