View(emp_data)
attach(emp_data)
cor(Salary_hike,Churn_out_rate)
emp_data_model <- lm(Churn_out_rate~Salary_hike)
summary(emp_data_model)
plot(emp_data_model)
#Hence the P-value is less than 0.05. So X varibale is significance and also Multiple R-Square value is 0.8312 That's mean this model will predict the output 83.12% time correct
