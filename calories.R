View(calories_consumed)
attach(calories_consumed)
summary(calories_consumed)
plot(calories_consumed$Weight.gained..grams.,calories_consumed$Calories.Consumed)
cor(Weight.gained..grams.,Calories.Consumed)
Weight_gain_model <- lm(Calories.Consumed~Weight.gained..grams.)
summary(Weight_gain_model)
#Hence the P-value is less than 0.05. So X varibale is significance and also Multiple R-Square value is 0.8968. That's mean this model will predict the output 89.68% time correct
confint(Weight_gain_model,level = 0.95)
predict(Weight_gain_model,interval = "predict")
# transform the variables to check whether the predicted values are better
Weight_gain_model_sqrt<-lm(Weight.gained..grams.~sqrt(Calories.Consumed))
summary(Weight_gain_model_sqrt)
confint(Weight_gain_model_sqrt,level=0.95)
predict(Weight_gain_model_sqrt,interval = "predict")
# transform the variables to check whether the predicted values are better
Weight_gain_model_log <- lm(Weight.gained..grams.~log(Calories.Consumed))
summary(Weight_gain_model_log)
confint(Weight_gain_model_log,level = 0.95)
predict(Weight_gain_model_log,interval = "predict")
# transform the variables to check whether the predicted values are better
Weight_gain_model_exp1<- lm(log(Weight.gained..grams.)~Calories.Consumed)
summary(Weight_gain_model_exp1)
confint(Weight_gain_model_exp1,level = 0.95)
predict(Weight_gain_model_exp1,interval = "predict")
# Result
## Applying transformation is decreasing Multiple R Squared Value. So model doesnot need further transformation, Multiple R-squared:  0.8968