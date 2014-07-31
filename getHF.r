require(IBrokers)
getHF<-function(contract,barSize,duration,useRTH=0,endDateTime=NULL){
  twsConnect()->tws
  contract. <- twsEquity(contract)
  if(is.null(endDateTime)){
    dat<-reqHistoricalData(tws,contract.,barSize=barSize,duration=duration,useRTH=useRTH,endDateTime=endDateTime)
  } else {
    dat<-reqHistoricalData(tws,contract.,barSize=barSize,duration=duration,useRTH=useRTH)
  }
  twsDisconnect(tws)
  return(dat)
}
ll<-getHF('XIV',"1 hour","1 M",endDateTime="20140327 19:00:00")
ll<-rbind(ll,getHF('XIV',"1 hour","1 M",endDateTime="20140427 19:00:00"))
ll<-rbind(ll,getHF('XIV',"1 hour","1 M",endDateTime="20140527 19:00:00"))
ll<-rbind(ll,getHF('XIV',"1 hour","1 M",endDateTime="20140627 19:00:00"))
ll<-rbind(ll,getHF('XIV',"1 hour","1 M"))

write.table(ll,"XIV.hr.txt")
