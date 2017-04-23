library(jsonlite)
library(curl)
library(data.table)
library(sqldf)

setwd("D:\\Work\\notebook\\metricstudy\\R")

getUrl<-function(to) {
  sixmonths<-60*60*24*30*6

  from<-as.character(as.numeric(to)-sixmonths)
  to<-as.character(to)

  url<-sprintf("https://poloniex.com/public?command=returnTradeHistory&currencyPair=BTC_ETH&start=%s&end=%s", from, to)
  url
}

getTrades<-function(to) {
  url<-getUrl(to)
  tr<-fromJSON(url)
  tr<-as.data.table(tr)
  setkey(tr, 'globalTradeID')
  tr
}

#starting date
#to<-as.character('1480726800') #20161203-01:00:00
as.numeric(as.POSIXct("2017-04-22 1:1:1 KST"))
to<-as.character('1492790461') 

#repeat count
repeat_count <- 5000

#result holder
trade<-data.table()

prev_to <- 0

for (i in 1:repeat_count) {
  print(i)
  print(to)
  #get trade history
  tr<-getTrades(to)
  trade<-unique(rbind(tr, trade))
  
  #pick up the next date
  to<-as.numeric(as.POSIXct(tr[1,]$date, tz="GMT"))
  if(to == prev_to)
    break
  prev_to <- to
  
  print(NROW(trade))
  #################################################
  #매 10번마다 다른 파일에 저장하는 루틴을 만들자.
  #################################################
  ROW_CNT_SAVE <- 60000
  if(NROW(trade)>ROW_CNT_SAVE) {
    print("to save")
    print(NROW(trade)-ROW_CNT_SAVE)
    trade_to_save <- trade[NROW(trade)-ROW_CNT_SAVE:NROW(trade)]
    
    print("trade_to_save")
    print(NROW(trade_to_save))
    
    print("check items")
    print(trade_to_save[1,])
    print(trade_to_save[ROW_CNT_SAVE,])
    write.csv(trade_to_save, "btc_eth_trade.csv")
    trade <-trade[1:NROW(trade)-ROW_CNT_SAVE]
  }
  print(NROW(trade))
}


trade<-subset(trade, select=-c(globalTradeID, tradeID))

write.csv(trade, "btc_eth_trade.csv")

getwd()

#sqldf("select count(distinct globalTradeID) from trade")
#vol<-sqldf("select substr(`date`,1,10) as dat, count(1) as cnt from trade group by substr(`date`,1,10)")
#vol$dat<-as.factor(vol$dat)
#plot(vol)



