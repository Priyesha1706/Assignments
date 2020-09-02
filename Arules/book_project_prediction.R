library(arules)
summary(book)
inspect(book[1:10])
rules <- apriori(as.matrix(book),parameter=list(support=0.02, confidence = 0.5,minlen=5))
# Provided the rules with 2 % Support, 50 % Confidence and Minimum to purchase 
# 5 books 
rules
inspect(head(sort(rules, by = "lift"))) 
head(quality(rules))
plot(rules,method = "scatterplot")
## To reduce overplotting, jitter is added! Use jitter = 0 to prevent jitter.
plot(rules,method = "grouped")
# The Art books are being sold at a larger extent along with other Cook, art, geo, child books
# Cook books are also being sold at a larger extent along with other chld, art, geo, Doit books)

plot(rules,method = "graph")
## Warning: plot: Too many rules supplied. Only plotting the best 100 rules
## using 'support' (change control parameter max if needed)