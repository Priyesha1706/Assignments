View(my_movies)
attach(my_movies)
library(arules)
library(arulesViz)
rules <- apriori(as.matrix(my_movies[,6:15],parameter = list(support=0.2,confidence =0.5,minlen =50)))
# Provided the rules with 2% Support, 50 % Confidence and watched a minimum of 2 movies
rules
inspect(head(sort(rules,by = "lift")))
head(quality(rules))
plot(rules,method = "scatterplot")
plot(rules, method = "grouped")
# It looks ike most of them has wateched Lord of the rings movies along with Gladiator and Greenville
# Also most of them has watched Gladiator, Sixth sense along with Patrioit
# Patriot ,Braveheart and other three items along with Gladiator. 
plot(rules,method = "graph")
