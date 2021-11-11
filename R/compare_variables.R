#' compare_variables
#'
#' @param template
#' @param newdat
#' @param threshold : theshold to detect outlyers. Not implemented
#' @param k: number of changes allowed by the fuzzy matching function.
#'
#' @return
#' @export
#'
#' @examples
compare_variables <- function(template = check, newdat = dirty_data, threshold = 1.5, k = 2){
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
  j <- sapply(newdat, is.numeric)
  newmin_ <- rep(NA, ncol(newdat))
  newmax_ <- rep(NA, ncol(newdat))
  newmin_[j] <- lapply(newdat[j], min)
  newmax_[j] <- lapply(newdat[j], max)
  newtemp <- data.frame(variables = names(newclasses), newclasses = newclasses,
                        newmin_ = unlist(newmin_),
                        newmax_ = unlist(newmax_), stringsAsFactors = FALSE)
  merged <- merge(template[["dat"]], newtemp, all = FALSE)
  print("Variables with unmatching classes:")
  print(merged[which(merged$classes != merged$newclasses),c(1,2,5)])
  #variables above 1.5x max. TO BE DONE
  print("Numeric variables out of range")
  print(merged[which(merged$newmin_ < merged$min_ | merged$newmax_ > merged$max_),
               c(1,3:4,6:7)])
  #categorical variables with wrong categories
  if(length(newdat[i]) > 0){
    cats <- list()
    for(m in 1:length(newdat[i])){
      temp <- unique(newdat[,which(i)][m])
      cats <- append(cats, temp)
    }
    cat_out <- list()
    for(h in names(cats)){
      sel_new <- cats[[h]]
      sel_tem <- template$categorical[[h]]
      to_fix <- sel_new[which(!sel_new %in% sel_tem)]
      if(length(to_fix) > 0){
        fixed <- c()
        for(l in 1:length(to_fix)){
          temp2 <- sel_tem[as.logical(adist(to_fix[l], sel_tem) <= k)]
          if(length(temp2) == 1){
            fixed[l] <- temp2
          } else {
            fixed[l] <- NA
          }
        }
        out <-  data.frame(to_fix, fixed)
        cat_out[[h]] <- out
      }#else{
      #cat_out[[h]] <- NA
      #}
    }
    cat_out
  }
}
