View(emp_data)
attach(emp_data)
# 1st Moment Business Decision Model
summary(emp_data)
# 2nd Moment Business Decision Model
var(Salary_hike)
sd(Salary_hike)
install.packages("e1071")
library(e1071)
# 3rd Moment Business Decision Model
skewness(Salary_hike)
# 4th Moment Business Decision Model
kurtosis(Salary_hike)
# Basics Plotting (BoxPlot & BarPlot)
boxplot(Salary_hike)
barplot(Salary_hike)
# Plotting a Histogram 
hist(Salary_hike)
# Checking the Normality or Linearity of distribution
qqnorm(Salary_hike)
# Plotting a scatter plot of Emp Dataset
plot(emp_data)
# Determining the Correlation of Emp Dataset
cor(emp_data)
# Preparing a Simple Linear Regression model 
emp_data_model <- lm(Churn_out_rate~Salary_hike)
summary(emp_data_model)
# Transformation of above model
emp_data_model_log <- lm(Churn_out_rate~log(Salary_hike))
summary(emp_data_model_log)
# Final predicted Simple Linear Regression model
FinalModel <- lm(log(Churn_out_rate) ~ log(Salary_hike))
summary(FinalModel)
plot(FinalModel)
#The Final Model is Predicted with an accuracy of 88.91 %.
