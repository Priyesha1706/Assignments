install.packages("randomForest")
install.packages("Mass")
install.packages("caret")
library(randomForest)
library(Mass)
library(caret)
# USe the set.seed function so that we get same results each time 
set.seed(123)
companydata <- read.csv("C:\\Users\\nitin\\Desktop\\priyesha assignment\\Random forest\\Company_Data.csv")
View(companydata)
hist(companydata$Sales,main = "sales of companydata",xlim = c(0,20),breaks=c(seq(10,20,30)),col = c("blue","red","green","violet"))
# if greater than 8 then high sales else Low
highsales = ifelse(companydata$Sales<9,"No","Yes")
compdata <- data.frame(companydata[2:11],highsales)
str(compdata)
table(compdata$highsales)
# Data Partition
set.seed(123)
ind <- sample(2,nrow(compdata),replace = TRUE,prob = c(0.7,0.3))
train <- compdata[ind==1,]
test <- companydata[ind==2,]
set.seed(213)
rf <- randomForest(highsales~.,data = train)
rf## Description of the random forest with no of trees, mtry = no of variables for splitting
# each tree node.
# Out of bag estimate of error rate is 18.25 % in Random Forest Model.
attributes(rf)
# Prediction and Confusion Matrix - Training data 
pred1 <- predict(rf,train)
head(pred1)
head(train$highsales)
# looks like the first six predicted value and original value matches.
confusionMatrix(pred1,train$highsales)# 98.7 % accuracy on training data 
# more than 95% Confidence Interval. 
# Sensitivity for Yes and No is 98.7 % 

# Prediction with test data - Test Data 
pred2 <- predict(rf, test)
confusionMatrix(pred2, test$highsales) # 82.61 % accuracy on test data
# Error Rate in Random Forest Model :
plot(rf)
# Tune Random Forest Model mtry 
tune <- tuneRF(train[,-11],train[,11],stepFactor = 0.5,plot = TRUE,ntreeTry = 300, trace=TRUE,improve = 0.05)
rf1 <- randomForest(highsales~., data=train, ntree = 300, mtry = 3, importance = TRUE,
                    proximity = TRUE)
rf1
pred1 <- predict(rf1, train)
confusionMatrix(pred1, train$highsales)  # 100 % accuracy on training data 
# Around 98% Confidence Interval. 
# Sensitivity for Yes and No is 100 % 

# test data prediction using the Tuned RF1 model
pred2 <- predict(rf1, test)
confusionMatrix(pred2, test$highsales) # 84.35 % accuracy on test data 
# Confidence Interval is around 90 % 


# no of nodes of trees

hist(treesize(rf1), main = "No of Nodes for the trees", col = "green")
# Majority of the trees has an average number of 45 to 50 nodes. 

# Variable Importance :
varImpPlot(rf1)
# Mean Decrease Accuracy graph shows that how worst the model performs without each variable.
# say ShelveLoc is the most important variable for prediction.on looking at population,it has no value.

# MeanDecrease gini graph shows how much by average the gini decreases if one of those nodes were 
# removed. Price is very important and Urban is not that important.

varImpPlot(rf1 ,Sort = T, n.var = 5, main = "Top 5 -Variable Importance")
# Quantitative values 
importance(rf1)
varUsed(rf)   # which predictor variables are actually used in the random forest.
# Partial Dependence Plot 
partialPlot(rf1, train, Price, "Yes")
# On that graph, i see that if the price is 100 or greater, than they are not buying those computers.

# Extract single tree from the forest :

getTree(rf, 1, labelVar = TRUE)
# Multi Dimension scaling plot of proximity Matrix
MDSplot(rf1, compdata$highsales)