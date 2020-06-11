install.packages("neuralnet")
install.packages("nnet")
install.packages("NeuralNetTools")
install.packages(plyr)
library(neuralnet)  # regression
library(nnet) # classification 
library(NeuralNetTools)
library(plyr)
startups <- read.csv("C:\\Users\\nitin\\Desktop\\priyesha assignment\\NN\\50_Startups.csv")
View(startups)
class(startups)
startups$State <- as.numeric(revalue(startups$State,c("New York" ="0","California"="1","Florida"="2")))
str(startups)
startups <- as.data.frame(startups)
attach(startups)
# Exploratory data Analysis :

plot(R.D.Spend, Profit)
plot(Administration, Profit)
plot(Marketing.Spend, Profit)
plot(Marketing.Spend, Profit)
windows()
# Find the correlation between Output (Profit) & inputs (R.D Spend, Administration, Marketing, State) - SCATTER DIAGRAwindows()
# Find the correlation between Output (Profit) & inputs (R.D Spend, Administration, Marketing, State) - SCATTER DIAGRAM
pairs(startups)
# Correlation coefficient - Strength & Direction of correlation
cor(startups)
summary(startups) # Confirms on the different scale and demands normalizing the data.
# Apply Normalization technique to the whole dataset :
normalize <- function(x){return((x-min(x))/(max(x)-min(x)))}
Startups_norm <- as.data.frame(lapply(startups,FUN = normalize))
summary(Startups_norm$Profit) # Normalized form of profit
summary(startups$profit) # Orginal profit value
# Data Partition 
set.seed(123)
ind <- sample(2,nrow(Startups_norm),replace = TRUE,prob = c(0.7,0.3))
startups_train <- Startups_norm[ind==1,]
startups_test <- Startups_norm[ind==2,]
# Creating a neural network model on training data
Startupsmodel <- neuralnet(Profit~.,data = startups_train)
str(Startupsmodel)
plot(Startupsmodel,rep="best")
summary(Startupsmodel)
par(mar = numeric(4),family="serif")
plotnet(Startupsmodel,alpha =0.6)
# Evaluating model performance

set.seed(12323)
model_result <- compute(Startupsmodel,startups_test)
predicted_profit <- model_result$net.result
# Predicted profit Vs Actual profit of test data.
cor(predicted_profit,startups_test$Profit)
# since the prediction is in Normalized form, we need to de-normalize it 
# to get the actual prediction on profit
str_max <- max(startups$Profit)
str_min <- min(startups$Profit)
unnormalize <- function(x, min, max) { 
  return( (max - min)*x + min )
}

ActualProfit_pred <- unnormalize(predicted_profit,str_min,str_max)
head(ActualProfit_pred)
# Improve the model performance :
set.seed(12345)
Startups_model2 <- neuralnet(Profit~R.D.Spend+Administration
                             +Marketing.Spend+State,data = startups_train)
plot(Startups_model2 ,rep = "best")
summary(Startups_model2)
model_results2<-compute(Startups_model2,startups_test)
predicted_Profit2<-model_results2$net.result
cor(predicted_Profit2,startups_test$Profit)
plot(predicted_Profit2,startups_test$Profit)
par(mar = numeric(4), family = 'serif')
plotnet(Startups_model2, alpha = 0.6)
# SSE(Error) has reduced and training steps had been increased as the number of neurons  under hidden layer are increased