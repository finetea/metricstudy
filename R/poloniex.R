library(jsonlite)
library(curl)
library(data.table)
library(sqldf)

getUrl<-function(to) {
  sixmonths<-60*60*24*30*6

  from<-as.character(as.numeric(to)-sixmonths)
  to<-as.character(to)

  url<-sprintf("https://poloniex.com/public?command=returnTradeHistory&currencyPair=BTC_NXT&start=%s&end=%s", from, to)
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
to<-as.character('1480726800') #20161203-01:00:00

#repeat count
repeat_count <- 100

#result holder
trade<-data.table()

for (i in 1:repeat_count) {
  print(to)
  #get trade history
  tr<-getTrades(to)
  trade<-unique(rbind(tr, trade))
  
  #pick up the next date
  to<-as.numeric(as.POSIXct(tr[1,]$date, tz="GMT"))
}

trade<-subset(trade, select=-c(globalTradeID, tradeID))

write.csv(trade, "btc_eth_trade.csv")

save.image()

getwd()

sqldf("select count(distinct globalTradeID) from trade")
vol<-sqldf("select substr(`date`,1,10) as dat, count(1) as cnt from trade group by substr(`date`,1,10)")
vol$dat<-as.factor(vol$dat)
plot(vol)



