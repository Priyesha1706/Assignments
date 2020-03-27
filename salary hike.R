View(Salary_Data)
attach(Salary_Data)
# 1st Moment Business Decision Model
summary(Salary_Data)
# 2nd Moment Business Decision Model
sd(Salary_Data$YearsExperience)
var(Salary_Data$YearsExperience)
sd(Salary_Data$Salary)
var(Salary_Data$Salary)
# 3rd Moment Business Decision Model
skewness(Salary_Data$YearsExperience)
skewness(Salary_Data$Salary)
# 4th Moment Business Decision Model
kurtosis(Salary_Data$YearsExperience)
kurtosis(Salary_Data$Salary)
plot(Salary_Data)
boxplot(Salary_Data)
hist(Salary_Data$YearsExperience)
hist(Salary_Data$Salary)
# Checking the Normality or Linearity of distribution
qqnorm(Salary)
# Plotting a scatter plot of Emp Dataset
plot(Salary_Data)
# Correlation coefficient value for Years of Experience and Employee Salary Hike
cor(YearsExperience,Salary)
# If |r| is greater than  0.85 then Co-relation is Strong(Correlation Co-efficient = 0.9782416). 
# This has a strong Positive Correlation 
# Simple model without using any transformation
Salary_Data_model <- lm(Salary~YearsExperience)
summary((Salary_Data_model))
# Probability value should be less than 0.05(5.51e-12)
# The multiple-R-Squared Value is 0.957 which is greater than 0.8(In General)
# Adjusted R-Squared Value is 0.9554 
# The Probability Value for F-Statistic is 2.2e-16(Overall Probability Model is also less than 0.05)
confint(Salary_Data_model,level = 0.95)
# The above code will get you 2 equations 
# 1 to caliculate the lower range and other for upper range
# Function to Predict the above model 
predict(Salary_Data_model,interval = "predict")
# Adjusted R-squared value for the above model is 0.9554 

# we may have to do transformation of variables for better R-squared value
# Applying transformations

# Logarthmic transformation
Salary_Data_model_log <- lm(Salary~log(YearsExperience))
summary(Salary_Data_model_log)
confint(Salary_Data_model_log,level = 0.95)
predict(Salary_Data_model_log,interval = "predict")
# Multiple R-squared value for the above model is 0.8539
# Adjusted R-squared:  0.8487 

# we may have to do different transformation for a better R-squared value
# Applying different transformations

# Exponential model 
Salary_Data_model_exp <- lm(log(Salary)~YearsExperience)
summary(Salary_Data_model_exp)
confint(Salary_Data_model_exp,level=0.95)
predict(Salary_Data_model_exp,interval = "predict")
#sqrt
Salary_Data_model_sqrt <- lm(YearsExperience~sqrt(Salary))
summary(Salary_Data_model_sqrt)
plot(Salary_Data_model_exp)
plot(Salary_Data_model_log)
plot(Salary_Data_model_sqrt)

