install.packages("naivebayes")
library(naivebayes)
library(ggplot2)
library(caret)
library(psych)
library(e1071)
#data train
sal_train <- read.csv("C:\\Users\\nitin\\Desktop\\priyesha assignment\\Naive bayes\\SalaryData_Train.csv")
str(sal_train)
View(sal_train)
sal_train$educationno <- as.factor(sal_train$educationno)
class(sal_train)
sal_test <- read.csv("C:\\Users\\nitin\\Desktop\\priyesha assignment\\Naive bayes\\SalaryData_Test.csv")
str(sal_test)
View(sal_test)
sal_test$educationno <- as.factor(sal_test$educationno)
class(sal_test)
#Visualization 
# Plot and ggplot 
ggplot(data = sal_train,aes(x=sal_train$Salary,y=sal_train$age,fill = sal_train$salary))+ geom_boxplot()+ggtitle("box plot")
plot(sal_train$workclass,sal_train$Salary)
plot(sal_train$education,sal_train$salary)
plot(sal_train$educationno,sal_train$salary)
plot(sal_train$maritalstatus,sal_train$Salary)
plot(sal_train$occupation,sal_train$Salary)
plot(sal_train$relationship,sal_train$Salary)
plot(sal_train$race,sal_train$Salary)
plot(sal_train$sex,sal_train$salary)
ggplot(data = sal_train,aes(x=sal_train$Salary,y= sal_train$capitalgain, fill =sal_train$Salary))+geom_boxplot()+ggtitle("box plot")
ggplot(data = sal_train,aes(x=sal_train$Salary,y= sal_train$hoursperweek,fill =sal_train$Salary))+ geom_boxplot()+ggtitle("box plot")
plot(sal_train$native,sal_train$Salary)
#Density Plot 

ggplot(data=sal_train,aes(x = sal_train$age, fill = sal_train$Salary)) +
  geom_density(alpha = 0.9, color = 'Violet')
ggtitle("Age - Density Plot")
ggplot(data=sal_train,aes(x = sal_train$workclass, fill = sal_train$Salary)) +
  geom_density(alpha = 0.9, color = 'Violet')
ggtitle("education Density Plot")
ggplot(data=sal_train,aes(x = sal_train$educationno, fill = sal_train$Salary)) +
  geom_density(alpha = 0.9, color = 'Violet')
ggtitle("educationno Density Plot")
ggplot(data=sal_train,aes(x = sal_train$maritalstatus, fill = sal_train$Salary)) +
  geom_density(alpha = 0.9, color = 'Violet')
ggtitle("maritalstatus Density Plot")
ggplot(data=sal_train,aes(x = sal_train$occupation, fill = sal_train$Salary)) +
  geom_density(alpha = 0.9, color = 'Violet')
ggtitle("occupation Density Plot")
ggplot(data=sal_train,aes(x = sal_train$sex, fill = sal_train$Salary)) +
  geom_density(alpha = 0.9, color = 'Violet')
ggtitle("sex Density Plot")
ggplot(data=sal_train,aes(x = sal_train$relationship, fill = sal_train$Salary)) +
  geom_density(alpha = 0.9, color = 'Violet')
ggtitle("Relationship Density Plot")
ggplot(data=sal_train,aes(x = sal_train$race, fill = sal_train$Salary)) +
  geom_density(alpha = 0.9, color = 'Violet')
ggtitle("Race Density Plot")
ggplot(data=sal_train,aes(x = sal_train$capitalgain, fill = sal_train$Salary)) +
  geom_density(alpha = 0.9, color = 'Violet')
ggtitle("Capitalgain Density Plot")
ggplot(data=sal_train,aes(x = sal_train$capitalloss, fill = sal_train$Salary)) +
  geom_density(alpha = 0.9, color = 'Violet')
ggtitle("Capitalloss Density Plot")
ggplot(data=sal_train,aes(x = sal_train$hoursperweek, fill = sal_train$Salary)) +
  geom_density(alpha = 0.9, color = 'Violet')
ggtitle("Hoursperweek Density Plot")
ggplot(data=sal_train,aes(x = sal_train$native, fill = sal_train$Salary)) +
  geom_density(alpha = 0.9, color = 'Violet')
ggtitle("native Density Plot")
# Naive Bayes Model 
Model_naive <- naiveBayes(sal_train$Salary ~ ., data = sal_train)
Model_naive
model_predi <- predict(Model_naive,sal_test)
mean(model_predi==sal_test$Salary)
confusionMatrix(model_predi,sal_test$Salary)
