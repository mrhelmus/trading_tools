require(IBrokers)
require(quantmod)
getHF<-function(contract,barSize,duration){
  twsConnect()->tws
  contract. <- twsEquity(contract)
  dat<-reqHistoricalData(tws,contract.,barSize=barSize,duration=duration)
  twsDisconnect(tws)
  return(dat)
}

getHF('XIV',"1 week","1 Y")