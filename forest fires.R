library(kernlab)
library(caret)
library(plyr)
# Read the data
forestfires <- read.csv("C:\\Users\\nitin\\Desktop\\priyesha assignment\\SVM\\forestfires.csv")
View(forestfires)
class(forestfires)
str(forestfires)
# The area value has lots of zeros
hist(forestfires$area)
rug(forestfires$area)
# Transform the Area value to Y 
forestfires1 <- mutate(forestfires, y = log(area + 1))  # default is to the base e, y is lower case
hist(forestfires1$y)
summary(forestfires) # Confirms on the different scale and demands normalizing the data.
# Prediction of Forest fires requires only prediction from 
# temperature, rain, relative humidity and wind speed

# Apply Normalization technique to the whole dataset :
normalize <- function(x){return((x-min(x))/(max(x)-min(x)))}
forestfires$temp = normalize(forestfires$temp)  
forestfires$RH = normalize(forestfires$RH)
forestfires$wind = normalize(forestfires$wind)
forestfires$rain = normalize(forestfires$rain)
#  need to tweak this as a classification problem.lets base out the Size using this criteria :
attach(forestfires)
#Data Partition 
set.seed(123)
ind <- sample(2,nrow(forestfires),replace = TRUE,prob = c(0.7,0.3))
forestfires_train <- forestfires[ind ==1,]
forestfires_test <- forestfires[ind ==2,]
# to train model
# e1071 package from LIBSVM library
# SVMlight algorithm klar package 

# kvsm() function uses gaussian RBF kernel 

# Building model 
model_ksvm <- ksvm(size_category~temp+rain+wind+RH,data = forestfires_train,kernel ="vanilladot")
model_ksvm

Pred_area <- predict(model_ksvm, forestfires_test)
table(Pred_area,forestfires_test$size_category)

agreement <- Pred_area == forestfires_test$size_category
table(agreement)
prop.table(table(agreement))

# kernel = rbfdot 
model1_rbfdot <- ksvm(size_category~temp+rain+wind+RH,data = forestfires_train,kernel ="rbfdot")
model1_rbfdot

pred1_area <- predict(model1_rbfdot,forestfires_test)
table(pred1_area,forestfires_test$size_category)

agreement1 <- pred1_area == forestfires_test$size_category
table(agreement1)
prop.table(table(agreement1))
