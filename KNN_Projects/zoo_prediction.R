install.packages("pROC")
install.packages("mlbench")

library(caret)
library(pROC)
library(mlbench)
library(lattice)
zoo <- read.csv("C:\\Users\\nitin\\Desktop\\priyesha assignment\\KNN\\Zoo.csv")
View(zoo)
str(zoo)
zoo1 <- zoo[,2:18]
str(zoo1)
# Data partition
set.seed(123)
ind <- sample(2,nrow(zoo1),replace = T, prob  = c(0.7,0.3))
train <- zoo1[ind==1,]
test <- zoo1[ind==2,]

# KNN Model 
trcontrol <- trainControl(method = "repeatedcv", number = 10,repeats = 3)
                          # classprobs are needed when u want to select ROC for optimal K Value
set.seed(222)
fit <- train(type ~., data = train, method = 'knn', tuneLength = 20,
             trControl = trcontrol, preProc = c("center","scale"))
# default metric is accuracy but if we want to use ROC, then mention the same
# Model Performance :
fit
# the optimum value for k should be 5
plot(fit)
varImp(fit)
pred <- predict(fit, newdata = test )
confusionMatrix(pred, test$type)
