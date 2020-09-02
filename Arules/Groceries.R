library(arules)
library(lattice)
View(groceries)
groceries <- read.transactions(file.choose(groceries),format = "basket")
summary(groceries)
inspect(groceries[1:5])# for 5 transaction
inspect(groceries[1:10])# for 10 transaction
itemFrequency(groceries[, 1:5])#examine the frequency of items
image(sample(groceries, 100))#visualization of a random sample of 100 transactions
apriori(groceries)#default settings result in zero rules learned
rules <- apriori(groceries,parameter = list(support = 0.002,confidence = 0.05,minlen=5))
groceryrules <- apriori(groceries, parameter = list(support = 0.006, confidence = 0.25, minlen = 2))#set better support and confidence levels to learn more rules
groceryrules
# summary of grocery association rules
summary(groceryrules)
inspect(groceryrules[1:3])
plot(groceryrules,method = "scatterplot")
plot(groceryrules,method = "grouped")
plot(groceryrules,method = "graph")
plot(groceryrules,method = "mosaic")
#Improving model performance
#sorting grocery rules by lift
inspect(sort(groceryrules, by = "lift")[1:5])

