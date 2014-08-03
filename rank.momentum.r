#' Temporally Rank assets
#'
#' \code{rank.momentum} creates an \code{\link{xts}} of ranks for a set of assets
#'
#' @param tickers A vector of the assets that have been previously loaded as \code{\link{xts}} objects
#' @param by.col The column in each asset \code{\link{xts}} object by which to rank
#' @param n Time period to calculate momentum with \code{\link{ROC}}
#' @param type Compounding type, continuous or discrete as in \code{\link{ROC}}
#' @param na.rm Removes any date where a price does not exist for an asset

#'
#' @details Ranks assets so that you can choose which to trade
#
#' @return \code{\link{xts}} object of ranks

#' @author M.R. Helmus
#' @note Edited code from \link{http://rbresearch.wordpress.com/2012/08/23/momentum-with-r-part-1/}

#' @examples
#' \dontrun{
#'     tickers<-c("GOOGL", "FB", "TWTR", "TSLA")
#'     getSymbols(tickers)
#'     rank.momentum(tickers,by.col="Adjusted",n=3,type="discrete",na.rm=TRUE)
#' }
require(quantstrat)
rank.momentum<-function(tickers,by.col="Adjusted",n=3,type="discrete",na.rm=TRUE) {
  s_c<-do.call(merge, lapply(tickers, get))
  s_c<-s_c[,grep(by.col,colnames(s_c))]

  if(na.rm){ s_c<-s_c[!apply(apply(s_c,2,is.na),1,any),] }

  #The ROC used as the ranking factor
  roc <- ROC(s_c, n = n, type = type)

  #symbol with a rank of 1 has the highest ROC over the time period n
  r <- as.xts(t(apply(-roc, 1, rank)))
  return(r)
}


