library(caret)
library(sqldf)


summary(stock)
attributes(stock)

stock$name
stock$name <- iconv(stock$name, "UTF8", "CP949")
head(stock$name)
head(stock)

?plot(x = stock[,1], y=stock[,2])

sqldf("select min(date), max(date) from stock")

#2014년 7월 데이터 평균 종가
#2014년 8월 데이터 최고가를 뽑아서 차이가 몇 퍼센트인지. 

s1 <- sqldf("select code, name, avg(Close) as month7 from stock where date like '2014-07-%' group by code, name")
s2 <- sqldf("select code, name, max(High) as month8 from stock where date like '2014-08-%' group by code, name")

result <- merge(s1, s2, by.x = c('code','name'), by.y = c('code','name'))
head(result)

result$rate <- round((result$month8 / result$month7), 1)
ind <- which(result$rate>1.1)
ind
length(ind)
result$class <- "no"
result[ind, "class"]
result[ind,]$class<-"yes"
result$class
result2<-result
result2$class<-as.factor(result2$class)
prop.table(table(result2$class))
result2$class<-as.numeric(result2$class)
prop.table(table(result2$class))




