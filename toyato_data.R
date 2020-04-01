View(ToyotaCorolla)
Corolla<-ToyotaCorolla[c("Price","Age_08_04","KM","HP","cc","Doors","Gears","Quarterly_Tax","Weight")]
attach(Corolla)
summary(Corolla)
colnames(Corolla)
sd(Price)
sd(Age_08_04)
sd(KM)
sd(cc)
sd(Doors)
sd(Gears)
sd(Cylinders)
sd(Weight)
sd(Quarterly_Tax)
var(Price)
var(Age_08_04)
var(KM)
var(cc)
var(Doors)
var(Gears)
var(Cylinders)
var(Weight)
var(Quarterly_Tax)
library(e1071) 
skewness(Price)
skewness(Age_08_04)
skewness(KM)
skewness(cc)
skewness(Doors)
skewness(Gears)
skewness(Cylinders)
skewness(Weight)
skewness(Quarterly_Tax)
kurtosis(Price)
kurtosis(Age_08_04)
kurtosis(KM)
kurtosis(cc)
kurtosis(Doors)
kurtosis(Gears)
kurtosis(Cylinders)
kurtosis(Weight)
kurtosis(Quarterly_Tax)
plot(Age_08_04, Price) ## Newr the Car more expensive it is.
plot(KM, Price) ## The more miles a car has the cheaper it is.
plot(HP, Price) ## More horsepower the more expensive.
plot(cc, Price) 
plot(Doors, Price)
plot(Gears, Price)
plot(Quarterly_Tax, Price)
plot(Weight, Price)
# Cars of Fuels types 
summary(Corolla$Fuel_Type)
summary(Corolla$Color)
summary(Corolla$Model)
library(car)
# Find Correlation between input and output
plot(Corolla)
# Correlation Coefficient matrix - Strength & Direction of Correlation
cor(Corolla)
##Pure Correlation  b/n the varibles
library(corpcor)
cor2pcor(cor(Corolla))
## Building linear regression model
model_corolla <- lm(Price~.,data = Corolla)
summary(model_corolla)
# cc and Doors are influence to each other, predict the model based on individual records
model.carcc <- lm(Price ~ cc)
summary(model.carcc) # Its significat to output
model.cardoor <- lm(Price ~ Doors)
summary(model.cardoor) # It's also significatnt
## Build model with cc and Doors
model.car <- lm(Price~cc+Doors)
summary(model.car)
# Find out the influencial record
influence.measures(model.car)
# ploting influential measures
library(car)
influenceIndexPlot(model.car)
influencePlot(model.car)
# Delete influentails records and build the model
model1 <- lm(Price ~ ., data = Corolla[-c(81),])
summary(model1)
vif(model1)
avPlots(model1)
finalmodel <- lm(Price ~ Age_08_04 + KM + HP + cc + Gears + Quarterly_Tax + Weight, data = Corolla[-c(81),])
summary(finalmodel)
plot(finalmodel)
#Residual plots,QQplot,std-Residuals Vs Fitted,Cook's Distance 
qqPlot(model_corolla)
