View(calories_consumed)
attach(calories_consumed)
summary(calories_consumed)
plot(calories_consumed$Weight.gained..grams.,calories_consumed$Calories.Consumed)
cor(Weight.gained..grams.,Calories.Consumed)
Weight_gain_model <- lm(Calories.Consumed~Weight.gained..grams.)
summary(Weight_gain_model)
#Hence the P-value is less than 0.05. So X varibale is significance and also Multiple R-Square value is 0.8968. That's mean this model will predict the output 89.68% time correct