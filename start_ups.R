View(`50_Startups`)
attach(`50_Startups`)
summary(`50_Startups`)#1st Moment Business Decision Model
sd(`50_Startups`$R.D.Spend)# 2nd Moment Business Decision Model
sd(`50_Startups`$Administration)
sd(`50_Startups`$Marketing.spend)
sd(`50_Startups`$profit)
var(`50_Startups`$Administration)
var(`50_Startups`$R.D.Spend)
var(`50_Startups`$Marketing.spend)
skewness(`50_Startups`$Administration)# 3rd Moment Business Decision Model
skewness(`50_Startups`$R.D.Spend)
kurtosis(`50_Startups`$R.D.Spend)
kurtosis(`50_Startups`$Administration)# 4th Moment Business Decision Model
plot(`50_Startups`)
boxplot(`50_Startups`)
pairs(`50_Startups`)
# 8. Correlation Coefficient matrix - Strength & Direction of Correlation
`50_Startups`[4]<- NULL
View(`50_Startups`)
cor(`50_Startups`)
### Partial Correlation matrix - Pure Correlation  b/n the varibles
install.packages("corpcor")
library(corpcor)
cor2pcor(cor(`50_Startups`))
# The Linear Model of interest
profit_model = lm(Profit~.,data = `50_Startups`)
summary(profit_model)
plot(profit_model)
# Muliple R2 Value - 0.95 which is acceptable
