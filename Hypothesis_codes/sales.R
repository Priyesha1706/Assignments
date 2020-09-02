#Inputs are 4 discrete variables(east,west,north,south).
#Output is also discrete. We are trying to find out if proportions of male and female are similar or not across the regions
#We proceed with chi-square test
View(BuyerRatio)
attach(BuyerRatio)
stacked_data3 <- stack(BuyerRatio)
View(stacked_data3)
attach(stacked_data3)
table(values,ind)
chisq.test(table(values,ind))
help("chisq.test")
# p-value = 0.293 > 0.05  => Accept null hypothesis
