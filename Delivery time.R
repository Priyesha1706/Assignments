View(delivery_time)
attach(delivery_time)
plot(delivery_time)
boxplot(delivery_time)
# Correlation coefficient value for Delivery Time and Sorting Time
cor(Delivery.Time,Sorting.Time)
# If |r| is greater than  0.85 then Co-relation is Strong(Correlation Co-efficient = 0.8259973). 
# This has a moderate Correlation 
# Simple model without using any transformation
Delivery_model <- lm(Sorting.Time~Delivery.Time)
View(Delivery_model)
summary(Delivery_model)
#Probability value should be less than 0.05(0.00115)
# The multiple-R-Squared Value is 0.6823 which is lesser than 0.8(In General)
# Adjusted R-Squared Value is 0.6655 
# The Probability Value for F-Statistic is 3.983e-06(Overall Probability Model is also less than 0.05)
confint(Delivery_model,level = 0.95)
predict(Delivery_model,interval = "predict")
# Adjusted R-squared value for the above model is 0.6655 

# we may have to do transformation of variables for better R-squared value
# Applying transformations

# Logarthmic transformation
Delivery_model_log <- lm(Delivery.Time~log(Sorting.Time))
summary(Delivery_model_log)
confint(Delivery_model_log,level = 0.95)
predict(Delivery_model_log,interval = "predict")
# Multiple R-squared value for the above model is 0.6954
# Adjusted R-squared:  0.6794 

# we may have to do different transformation for a better R-squared value
# Applying different transformations

# Exponential model 
Delivery_model_exp <-lm(log(Delivery.Time)~Sorting.Time)
summary(Delivery_model_exp)
confint(Delivery_model_exp,level = 0.95)
predict(Delivery_model_exp,interval = "predict")
# R-squared value - 0.7109
# Adjusted R SQuare Value - 0.6957 
# Higher the R-sqaured value - Better chances of getting good model 
# for Delivery Time and Sorting Time
#For Increasing R squared value
#Using mvinfluence in Linear Model to find the point which are creating problems
library(mvinfluence)
influenceIndexPlot(Delivery_model)
deliverTimeModel <- lm(Delivery.Time ~ Sorting.Time, data = delivery_time[c(-5,-9,-21),])
summary(deliverTimeModel)
plot(deliverTimeModel)
#After removing 3 points Multiple R-Square value is increased to 0.8332. That's mean this model will predict the output 83.32% time correct
