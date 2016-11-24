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
library(rpart)
library(partykit)
rpp1 <- rpart(class~.,data=mart[,-c(2,3)],parms=list(prior=c(0.5,0.5)),cp=0.01)
plot(as.party(rpp1))
table(predict(rpp1,type="class"),mart$class)
(503+583)/(503+583+181+512)# 61
583/(512+583) # 53 pre
583/(583+181) # 76 recall
53/42 # 1.26
final <- cbind(mart,rpp1=predict(rpp1,type="class"),rpp1prob=predict(rpp1))
colnames(final)
head(final)
sqldf("select name,rpp1,class,[rpp1prob.yes] from final where [rpp1prob.yes]>0.7")
sqldf("select class, rpp1, count(*) cnt from (select name,class,rpp1,[rpp1prob.yes] rpp1yes from final where [rpp1prob.yes]>0.7) group by class,rpp1")
43/(43+15)
74/42

library(doParallel)
registerDoParallel(7)
library(caret)
system.time(rf1 <- train(class~.,data=mart[,-c(2,3)],method="rf"))
plot(rf1) 
vi <- varImp(rf1)
plot(vi)
table(predict(rf1),mart$class)




library(dplyr)

set.seed(1234)
dat <- data.frame(x = rnorm(10, 30, .2), 
                  y = runif(10, 3, 5),
                  z = runif(10, 10, 20))
dat

dat %>% mutate_each_(funs(scale),vars=c("y","z")) 