View(delivery_time)
attach(delivery_time)
cor(Delivery.Time,Sorting.Time)
Delivery_model <- lm(Sorting.Time~Delivery.Time)
View(Delivery_model)
summary(Delivery_model)
plot(Delivery_model)
# Hence the P-value is less than 0.05. So X varibale is significance and also Multiple R-Square value is 0.6823. That's mean this model will predict the output 68.23% time correct
#For Increasing R squared value
#Using mvinfluence in Linear Model to find the point which are creating problems
library(mvinfluence)
install.packages('mvinfluence')
influenceIndexPlot(Delivery_model)
Delivery_model1 <- lm(Delivery.Time~Sorting.Time,data = delivery_time[c(-5,-9,-21),])
summary(Delivery_model1)
plot(Delivery_model1)
#After removing 3 points Multiple R-Square value is increased to 0.8332. That's mean this model will predict the output 83.32% time correct


