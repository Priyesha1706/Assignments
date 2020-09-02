library(kernlab)
library(caret)
library(dplyr)
library(ggplot2)
library(psych)
library(e1071)
# Data(Train)
train_sal <- read.csv("C:\\Users\\nitin\\Desktop\\priyesha assignment\\SVM\\SalaryData_Train(1).csv")
str(train_sal)
View(train_sal)
train_sal$educationno <-as.factor(train_sal$educationno)
class(train_sal)
# Data(Test)
test_sal <- read.csv("C:\\Users\\nitin\\Desktop\\priyesha assignment\\SVM\\SalaryData_Test(1).csv")
str(test_sal)
View(test_sal)
test_sal$educationno <- as.factor(test_sal$educationno)
class(test_sal)
#Visualization 
# Plot and ggplot 
ggplot(data = train_sal,aes(x = train_sal$Salary, y = train_sal$age, fill = train_sal$Salary)) +
  geom_boxplot() + ggtitle("Box Plot")
plot(train_sal$workclass,train_sal$Salary)
plot(train_sal$education,train_sal$salary)
plot(train_sal$educationno,train_sal$Salary)
plot(train_sal$maritalstatus,train_sal$Salary)
plot(train_sal$occupation,train_sal$Salary)
plot(train_sal$relationship,train_sal$Salary)
plot(train_sal$race,train_sal$Salary)
plot(train_sal$sex,train_sal$Salary)
ggplot(data=train_sal,aes(x=train_sal$Salary, y = train_sal$capitalgain, fill = train_sal$Salary)) +
  geom_boxplot() +ggtitle("Box Plot")
ggplot(data=train_sal,aes(x=train_sal$Salary, y = train_sal$capitalloss, fill = train_sal$Salary)) +
  geom_boxplot() +ggtitle("Box Plot")
ggplot(data=train_sal,aes(x=train_sal$Salary, y = train_sal$hoursperweek, fill = train_sal$Salary)) +
  geom_boxplot() +ggtitle("Box Plot")
plot(train_sal$native,train_sal$Salary)
#Density Plot 
ggplot(data=train_sal,aes(x = train_sal$age, fill = train_sal$Salary)) +
  geom_density(alpha = 0.9, color = 'Violet')
ggtitle("Age - Density Plot")
ggplot(data=train_sal,aes(x = train_sal$workclass, fill = train_sal$Salary)) +
  geom_density(alpha = 0.9, color = 'Violet')
ggtitle("Workclass Density Plot")
ggplot(data=train_sal,aes(x = train_sal$education, fill = train_sal$Salary)) +
  geom_density(alpha = 0.9, color = 'Violet')
ggtitle("education Density Plot")
ggplot(data=train_sal,aes(x = train_sal$educationno, fill = train_sal$Salary)) +
  geom_density(alpha = 0.9, color = 'Violet')
ggtitle("educationno Density Plot")
ggplot(data=train_sal,aes(x = train_sal$maritalstatus, fill = train_sal$Salary)) +
  geom_density(alpha = 0.9, color = 'Violet')
ggtitle("maritalstatus Density Plot")
ggplot(data=train_sal,aes(x = train_sal$occupation, fill = train_sal$Salary)) +
  geom_density(alpha = 0.9, color = 'Violet')
ggtitle("occupation Density Plot")
ggplot(data=train_sal,aes(x = train_sal$sex, fill = train_sal$Salary)) +
  geom_density(alpha = 0.9, color = 'Violet')
ggtitle("sex Density Plot")
ggplot(data=train_sal,aes(x = train_sal$relationship, fill = train_sal$Salary)) +
  geom_density(alpha = 0.9, color = 'Violet')
ggtitle("Relationship Density Plot")
ggplot(data=train_sal,aes(x = train_sal$race, fill = train_sal$Salary)) +
  geom_density(alpha = 0.9, color = 'Violet')
ggtitle("Race Density Plot")
ggplot(data=train_sal,aes(x = train_sal$capitalgain, fill = train_sal$Salary)) +
  geom_density(alpha = 0.9, color = 'Violet')
ggtitle("Capitalgain Density Plot")
ggplot(data=train_sal,aes(x = train_sal$capitalloss, fill = train_sal$Salary)) +
  geom_density(alpha = 0.9, color = 'Violet')
ggtitle("Capitalloss Density Plot")
ggplot(data=train_sal,aes(x = train_sal$hoursperweek, fill = train_sal$Salary)) +
  geom_density(alpha = 0.9, color = 'Violet')
ggtitle("Hoursperweek Density Plot")
ggplot(data=train_sal,aes(x = train_sal$native, fill = train_sal$Salary)) +
  geom_density(alpha = 0.9, color = 'Violet')
ggtitle("native Density Plot")

# Building model 

modelSVM <- ksvm(train_sal$Salary~.,data = train_sal,kernel= "vanilladot")
modelSVM
salary_prediction <- predict(modelSVM, test_sal)
table(salary_prediction,test_sal$Salary)
agreement <- salary_prediction == test_sal$Salary
table(agreement)
prop.table(table(agreement))

# kernel = rbfdot 

modelrbfdot <- ksvm(train_sal$Salary ~.,data = train_sal,kernel = "rbfdot")
modelrbfdot
rbfdot_pred <- predict(modelrbfdot,test_sal)
table(rbfdot_pred,test_sal$Salary)
agreement <- rbfdot_pred == test_sal$Salary
table(agreement)
prop.table(table(agreement))
