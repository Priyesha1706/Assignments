install.packages("rmarkdown",repos = "http://cran.us.r-project.org")
install.packages("C50",repos = "http://cran.us.r-project.org")
install.packages("tree",repos = "http://cran.us.r-project.org")
install.packages("caret",repos = "http://cran.us.r-project.org")
install.packages("party",repos = "http://cran.us.r-project.org")
install.packages("knitr",repos = "http://cran.us.r-project.org")
install.packages("png",repos = "http://cran.us.r-project.org")
library(party)
library(C50)
library(tree)
library(caret)
library(gmodels)
library(knitr)
library(png)
Fraudcheck <- read.csv("C:\\Users\\nitin\\Desktop\\priyesha assignment\\Decision tree\\Fraud_check.csv")
View(Fraudcheck)
# Splitting data into training and testing.
hist(Fraudcheck$Taxable.Income)
Risky_Good <- ifelse(Fraudcheck$Taxable.Income<= 30000  ,"Risky","Good")
Fraud_check <- data.frame(Fraudcheck,Risky_Good)
plot(Fraud_check)
Fraud_check_train <- Fraud_check[1:300,]
Fraud_check_test <- Fraud_check[301:600,]
View(Fraud_check_train)
View(Fraud_check_test)
###Using Party Function 

png(file = "decision_tree.png")
model_tree <- ctree(Risky_Good ~ Undergrad + Marital.Status  + City.Population + Work.Experience + Urban, data = Fraud_check)
summary(model_tree)
plot(model_tree)
# From the above tree, It looks like the data has 20 % of Risky patients and 80 % good patients


# using the training Data 
png(file = "decision_tree.png")
attach(Fraud_check)
model1_tree <- ctree(Risky_Good ~ Undergrad + Marital.Status + Urban + City.Population + Work.Experience, data = Fraud_check_train)
summary(model1_tree)
plot(model1_tree)


pred_tree <-  as.data.frame(predict(model1_tree, newdata= Fraud_check_test))
pred_tree["final"] <- NULL
pred_tree_df <- predict(model1_tree,newdata = Fraud_check_test)
mean(pred_tree_df==Fraud_check_test$Risky_Good)
CrossTable(Fraud_check_test$Risky_Good,pred_tree_df)
confusionMatrix(Fraud_check_test$Risky_Good,pred_tree_df)
