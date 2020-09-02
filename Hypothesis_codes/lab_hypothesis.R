
#Inputs are 4 lab reports. So Input is Discrete in more than 2 categories.
#Output is continuous as we are trying to see the difference in average TAT.
#we proceed with ANOVA one-way test
#############Anova (LabTAT Data )##########
View(LabTAT)
attach(LabTAT)
Stacked_Data1 <- stack(LabTAT)
View(Stacked_Data1)
attach(Stacked_Data1)
#############Normality test###############
shapiro.test(LabTAT$Laboratory.1)
#P-value is 0.550 >0.05. P High Ho Fly
shapiro.test(LabTAT$Laboratory.2)
#P-value is 0.863 >0.05. P High Ho Fly
shapiro.test(LabTAT$Laboratory.3)
#P-value is 0.420 >0.05. P High Ho Fly
summary(LabTAT)
# Data is normally distributed
install.packages("car")
library(car)
levene.Test(values~ ind, data = Stacked_Data1)
Anova_results <- aov(values~ind,data = Stacked_Data1)
summary(Anova_results)
#Df Sum Sq Mean Sq F value Pr(>F)    
#ind           3  79979   26660   118.7 <2e-16 ***
 # Residuals   476 106905     225                   
---
 # Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
help("anova")
# All Proportions all equal 
#SImilarly by doing for different lab combinations we can see that P -value is > 0.05. P High and Ho Fly.
#Hence there is no significant difference in the average TAT for all the labs.
boxplot(Laboratory.1,Laboratory.2)
plot(Laboratory.1,Laboratory.2)
