View(creditcard)
attach(creditcard)
creditcard <- creditcard[,-1]
library(caret)
dmy <- dummyVars("~ .", data = creditcard, fullRank = T)
creditcard <- data.frame(predict(dmy, newdata = creditcard))
str(creditcard)
attach(creditcard)
summary(creditcard)
sd(age)
sd(income)
sd(expenditure)
var(age)
var(income)
var(expenditure)
library(e1071)
skewness(age)
skewness(income)
skewness(expenditure)
kurtosis(age)
kurtosis(income)
kurtosis(expenditure)
plot(creditcard)
credit_model <- lm(card.yes ~.,data = creditcard)
summary(credit_model)
plot(credit_model)
install.packages("aod")
logit <- glm(card.yes ~ reports + age + income + share + expenditure + factor(owner.yes)+ factor(selfemp.yes)+ dependents + months + majorcards + active ,data = creditcard,family = "binomial")
summary(logit)
plot(logit)
library(lattice)
#odd ratio
exp(coef(logit))

# Confusion matrix table 
prob <- predict(logit,credit_data,type="response")

# We are going to use NULL and Residual Deviance to compare the between different models

# Confusion matrix and considering the threshold value as 0.5 
confusion<-table(prob>0.5,creditcard$card.yes)
confusion
# Model Accuracy 
Accuracy<-sum(diag(confusion)/sum(confusion))
Accuracy 
#roc curve
library(pROC)
roccurve <-roc(creditcard$card.yes ~prob)
plot(roccurve)
