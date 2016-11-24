library(caret)
setwd("D:\\work\\metricstudy\\rstudy")
rm(list=ls())
load("stock.rdata")
ls()
colnames(stock)
head(stock)
stock$name <- iconv(stock$name,"UTF8","CP949")
str(stock)
head(stock)
min(stock$date);max(stock$date)
class(stock)
library(sqldf)
sqldf("select min(date),max(date) from stock")
sqldf("select code,name,avg(close) avg_close2013 from stock where date between '2013-01-01' and '2013-12-31' group by code,name having avg(close)>1000000")
# 종목코드,이름별로 
# 2014년 7월 평균종가와 2014년 8월 고가의 최고가를 구해서, 
# 두변수간의 가격변화율을 산출해라.
# code,name, month7, month8, rate
### 과제 1
###종목코드, 이름별로 2014년 7월 평균종가와 2014년 8월 고가의 최고가를 구해서, 두 변수간의 가격 변화율을 산출해라
month7_avg_close <- sqldf("select code, name, avg(close) month7 from stock where date between '2014-07-30' and '2014-07-31' group by code, name")
dim(month7_avg_close)
montt8_max_high <- sqldf("select code, name, max(High) month8 from stock where date between '2014-08-01' and '2014-08-31' group by code, name")
result <- sqldf("select month7_avg_close.code, month7_avg_close.name, month7, month8, (month8 / month7) rate from month7_avg_close join montt8_max_high on month7_avg_close.code = montt8_max_high.code and month7_avg_close.name = montt8_max_high.name")
head(result)
summary(result)
result$class <- 'no'
ind <- which(result$rate>1.1)
ind
length(ind)
result[ind,"class"] <- 'yes'
table(result$class)
prop.table(table(result$class))
str(result)
result$class <- factor(result$class)
str(result)
######
tmp1 <- sqldf("select code,name, avg(open) avg_open, avg(high) avg_high, avg(low) avg_low, avg(Close) avg_close, avg(volume) avg_volume,variance(open) var_open, variance(high) var_high, variance(low) var_low, variance(Close) var_close, variance(volume) var_volume from stock where date<'2014-08-01' group by code,name")
colnames(tmp1)
head(tmp1)
# tmp2 <- 
# tmp3 <-
# tmp4 <- sqldf()

colnames(result)
mart <- sqldf("select a.class, b.* from result a, tmp1 b where a.code=b.code and a.name=b.name")
colnames(mart)
ind <- sample(2,nrow(mart),replace=TRUE,prob=c(0.7,0.3))
tr <- mart[ind==1,]
ts <- mart[ind==2,]
library(rpart)
library(partykit)
rpp1 <- rpart(class~.,data=tr[,-c(2,3)],parms=list(prior=c(0.5,0.5)),cp=0.01)
plot(as.party(rpp1))
table(predict(rpp1,type="class"),tr$class)
367/(245+367) # 59
table(predict(rpp1,type="class",newdata=ts),ts$class)
117/(117+126) # 48
library(doParallel)
registerDoParallel(8)
library(caret)
system.time(rf1 <- train(class~.,data=tr[,-c(2,3)],method="rf",tuneLength=7))
plot(rf1) 
confusionMatrix(rf1)
vi <- varImp(rf1)
plot(vi)
table(predict(rf1,newdata=ts),ts$class)
95/(95+95)
system.time(svm1 <- train(class~.,data=tr[,-c(2,3)],method="svmRadial"))
plot(svm1) 
confusionMatrix(svm1)
vi <- varImp(svm1)
plot(vi)
table(predict(svm1,newdata=ts),ts$class)
41/(41+32) # 56
final <- cbind(ts,rpp1=predict(rpp1,type="class",newdata=ts),rpp1prob=predict(rpp1,newdata=ts),rf1=predict(rf1,type="raw",newdata=ts),rf1prob=predict(rf1,type="prob",newdata=ts),svm1=predict(svm1,type="raw",newdata=ts))
colnames(final)
head(final)
sqldf("select class, rpp1, count(*) cnt from (select name,class, rpp1,[rpp1prob.yes],rf1,[rf1prob.yes] from final where [rpp1prob.yes]>0.7 and [rf1prob.yes]>0.7 and svm1='yes') group by class,rpp1")
11/(11+6) # 64
5/5 # 100

library(doParallel)
registerDoParallel(7)
library(caret)
system.time(rf1 <- train(class~.,data=mart[,-c(2,3)],method="rf"))
plot(rf1) 
vi <- varImp(rf1)
plot(vi)
table(predict(rf1),mart$class)






data(stock)
colnames(stock)
NROW(stock)
stock_max<-aggregate(stock$Close, list(stock$code), FUN='max')
stock_mean<-aggregate(stock$Close, list(stock$code), FUN='mean')
head(stock_max)
head(stock_mean)
stock_m <- merge(stock_max, stock_mean, by = 'Group.1')
head(stock_m)
.














library(dplyr)

set.seed(1234)
dat <- data.frame(x = rnorm(10, 30, .2), 
                  y = runif(10, 3, 5),
                  z = runif(10, 10, 20))
dat

dat %>% mutate_each_(funs(scale),vars=c("y","z")) 