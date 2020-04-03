View(creditcard)
attach(creditcard)
library(caret)
dmy <- dummyVars("~ .", data = creditcard, fullRank = T)
credit_data <- data.frame(predict(dmy, newdata = creditcard))
str(credit_data)
attach(credit_data)
summary(credit_data)
sd(age)
sd(income)
sd(expenditure)
var(age)
var(income)
var(expenditure)
skewness(age)
skewness(income)
skewness(expenditure)
kurtosis(age)
kurtosis(income)
kurtosis(expenditure)
plot(credit_data)
hist(card,age)
hist(card,income)
hist(card,expenditure)
credit_model <- lm(card.yes ~.,data = creditcard)
summary(credit_model)
plot(credit_model)
install.packages("aod")
logit <- glm(card.yes ~ .,data = creditcard,family = "binomial")
summary(logit)
plot(logit)
library(lattice)

#odd ratio
exp(coef(logit))

# Confusion matrix table 
prob <- predict(logit,credit_data,type="response")

# We are going to use NULL and Residual Deviance to compare the between different models

# Confusion matrix and considering the threshold value as 0.5 
confusion<-table(prob>0.5,creditcard$card)
confusion
# Model Accuracy 
Accuracy<-sum(diag(confusion)/sum(confusion))
Accuracy 
#roc curve
library(pROC)
roccurve <-roc(credit_data$card.yes ~prob)
plot(roccurve)
