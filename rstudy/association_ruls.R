library(arulesViz)

# http://rfriend.tistory.com/191

data('Groceries')
rules <- apriori(Groceries, parameter=list(support=0.001, confidence=0.5))
plot(rules, method='grouped')
summary(rules)

subrules2 <- head(sort(rules, by="lift"),10)
plot(subrules2, method='graph', control=list(type='items'))








##########
#install.packages("arules")
#install.packages("arulesViz")
library(arules)
library(arulesViz)
# read single format data
read.csv("arules sample single format data.csv")
txn = read.transactions(file="arules sample single format data.csv", rm.duplicates= FALSE, format="single",sep=",",cols =c(1,2))
txn
inspect(txn)
basket_rules <- apriori(txn,parameter = list(sup = 0.5, conf = 0.9,target="rules"))
inspect(basket_rules);
inspect(basket_rules[1]);
itemFrequencyPlot(txn);
inspect(txn);
data(Groceries)
inspect(head(Groceries))
length(Groceries)
G_arules<-apriori(Groceries, parameter=list(support=0.01, confidence=0.3))
G_arules
summary(G_arules)
inspect(head(G_arules))
(G_arules_yogurt <- subset(G_arules, subset = rhs %in% "yogurt" & lift > 2))
inspect(G_arules_yogurt)
(G_arules_root_vegetables <- subset(G_arules, subset = rhs %in% "root vegetables" & lift > 2))
inspect(G_arules_root_vegetables)
inspect(head(sort(G_arules_yogurt, by = "confidence"), n = 3))
inspect(head(sort(G_arules_yogurt, by = "support"), n = 3))
G_arulesViz<-apriori(Groceries, parameter=list(support=0.005, confidence=0.3))
G_arulesViz
plot(G_arulesViz)
G_arulesViz_sub1 <- G_arulesViz[quality(G_arulesViz)$confidence > 0.5]
G_arulesViz_sub1
plot(G_arulesViz_sub1, method="grouped")
G_arulesViz_sub2 <- head(sort(G_arulesViz, by="lift"),10)
plot(G_arulesViz_sub2, method="graph", control=list(type="items"))