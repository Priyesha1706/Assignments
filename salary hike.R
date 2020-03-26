View(Salary_Data)
attach(Salary_Data)
Salary_Data_model <- lm(Salary~YearsExperience)
summary((Salary_Data_model))
plot(Salary_Data_model)
#Hence the P-value is less than 0.05. So X varibale is significance and also Multiple R-Square value is 0.957 That's mean this model will predict the output 95.7% time correct
