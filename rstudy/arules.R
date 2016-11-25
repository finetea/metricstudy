library(arules)
data(AdultUCI)
AdultUCI[["fnlwgt"]] <- NULL
AdultUCI[["education-num"]] <- NULL
AdultUCI[["age"]] <- ordered(cut(AdultUCI[["age"]], c(15,25, 45, 65, 100)), labels = c("Young", "Middle-aged","Senior", "Old"))
AdultUCI[["hours-per-week"]] <- ordered(cut(AdultUCI[["hours-per-week"]],c(0, 25, 40, 60, 168)), labels = c("Part-time", "Full-time","Over-time", "Workaholic"))
AdultUCI[["capital-gain"]] <- ordered(cut(AdultUCI[["capital-gain"]],c(-Inf, 0, median(AdultUCI[["capital-gain"]][AdultUCI[["capital-gain"]] > 0]), Inf)), labels = c("None", "Low", "High"))
AdultUCI[["capital-loss"]] <- ordered(cut(AdultUCI[["capital-loss"]],c(-Inf, 0, median(AdultUCI[["capital-loss"]][AdultUCI[["capital-loss"]] >0]), Inf)), labels = c("none", "low", "high"))
#Transactions matrix:
Adult <- as(AdultUCI, "transactions")
Adult
#Itemsets:
itemFrequencyPlot(Adult)
#Itemsets with support >=0.1
itemFrequencyPlot(Adult, support = 0.1, cex.names = 0.8)
#Association rules with support>=0.01 and confidence >=0.6
rules <- apriori(Adult, parameter = list(support = 0.01, confidence = 0.6))
summary(rules)
#Usually the set of rules is big, we can restrict the set of rules. Select the rules with specified rhs.
rulesIncomeSmall <- subset(rules, subset = rhs %in% "income=small" & lift > 1.2)
rulesIncomeLarge <- subset(rules, subset = rhs %in% "income=large" & lift > 1.2)
#Sort the results:
inspect(head(sort(rulesIncomeSmall, by = "confidence"), n = 3))







#my analysis

gc()

library(arules)
library(randomForest)
library(caret)
library(Amelia)
library(corrgram)

data(AdultUCI)

colnames(AdultUCI)
nrow(AdultUCI)

#eda
missmap(AdultUCI, col = c("yellow", "black"))
table(AdultUCI$`native-country`)
table(AdultUCI$occupation)
sum(is.na(AdultUCI$occupation))
head(subset(AdultUCI, is.na(AdultUCI$occupation)))

table(AdultUCI$education)
occ<-subset(AdultUCI, is.na(AdultUCI$occupation))
table(occ$education)
table(occ$workclass)
table(AdultUCI$workclass)




#data set

#remove columns containing na
f<-function(col) sum(is.na(col))
sapply(ts.train, f)
#workclass and occupation and native-country

data.raw <- subset(AdultUCI, select=-c(workclass, `native-country`, occupation))
newcolnames = c("age","fnlwgt","education","education_num","marital_status","relationship","race","sex","capital_gain","capital_loss","hours_per_week","income")
colnames(data.raw) <- newcolnames
colnames(data.raw)
  
vs  <- data.raw[is.na(data.raw$income),]
head(vs)

train <- data.raw[!is.na(data.raw$income),]
head(train)

idx <- sample(2, nrow(train), replace=T, prob=c(0.8, 0.2))
table(idx)

ts.train <- train[idx==1,]
ts.test  <- train[idx==2,]
NROW(ts.train)
NROW(ts.test)
NROW(vs)

train$income          <- as.numeric(train$income)
train$age             <- as.numeric(train$age)
train$fnlwgt          <- as.numeric(train$fnlwgt)
train$education       <- as.numeric(train$education)
train$education_num   <- as.numeric(train$education_num)
train$marital_status  <- as.numeric(train$marital_status)
train$relationship    <- as.numeric(train$relationship)
train$race            <- as.numeric(train$race)
train$sex             <- as.numeric(train$sex)
train$capital_gain    <- as.numeric(train$capital_gain)
train$capital_loss    <- as.numeric(train$capital_loss)
train$hours_per_week  <- as.numeric(train$hours_per_week)

corr.var = newcolnames
corrgram(train[,corr.var], order=FALSE, lower.panel=panel.conf, upper.panel=panel.pie, text.panel=panel.txt, main="coefficient")

summary(train)

#rf1 <- train(income~age+education+education_num+marital_status+relationship+sex+capital_gain+capital_loss+hours_per_week, data=ts.train, method="rf")
rf1 <- train(income~education_num+marital_status+relationship+sex+capital_gain+hours_per_week, data=ts.train, method="rf")












library(shiny)

runExample("01_hello")


#http://rattle.togaware.com/
#http://rattle.togaware.com/rattle-install-mswindows.html

install.packages("rattle", repos="http://rattle.togaware.com") 
install.packages("devtools") 
library(rattle)

install.packages("rattle")
library(rattle)
rattle() 