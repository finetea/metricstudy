library(arulesViz)

# http://rfriend.tistory.com/191

data('Groceries')
rules <- apriori(Groceries, parameter=list(support=0.001, confidence=0.5))
plot(rules, method='grouped')
summary(rules)
