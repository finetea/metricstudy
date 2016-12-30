library(caret)
library(rpart)
library(partykit)

colnames(titanic.raw)

data(titanic.raw)

idx <- sample(2, nrow(titanic.raw), replace=T, prob=c(0.7, 0.3))

train <- titanic.raw[idx==1,]
test  <- titanic.raw[idx==2,]


rf1 <- train(Survived~., data=train, method='rf')
confusionMatrix(predict(rf1, test), test$Survived)
plot(rf1)

rf2 <- randomForest(Survived~., data=train, ntree=100, proximity=TRUE)
confusionMatrix(predict(rf2, test), test$Survived)
plot(rf2)
importance(rf2)
varImpPlot(rf2)

t1 <- rpart(Survived~.,data=train)
plot(as.party(t1))
res1 <- predict(t1, newdata=test, type="class")
colnames(res1)

confusionMatrix(res1, test$Survived)


vi1 <- varImp(rf1)
vi2 <- varImp(t1)
