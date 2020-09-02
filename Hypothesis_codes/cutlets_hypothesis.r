

View(Cutlets)
attach(Cutlets)
colnames(Cutlets) <- c("Unit.A","Unit.B")
#############Normality test###############
shapiro.test(Unit.A)
# p-value = 0.32 >0.05 so p high null fly => It follows normal distribution
shapiro.test(Unit.B)
# p-value = 0.52 >0.05 so p high null fly => It follows normal distribution
#############Variance test###############
var.test(Unit.A,Unit.B)
# p-value = 0.313 > 0.05 so p high null fly => Equal variances
############2 sample T Test ##################
help(t.test)
t.test(Unit.A,Unit.B,alternative = "two.sided",conf.level =0.95,correct = TRUE)
# alternative = "two.sided" means we are checking for equal and unequal
# means
# null Hypothesis -> Equal means
# Alternate Hypothesis -> Unequal Hypothesis
# p-value = 0.472 > 0.05 Reject alternate Hypothesis 
# unequal means
t.test(Unit.A,Unit.B,alternative = "greater",var.equal = TRUE)
# alternative = "greater means true difference is greater than 0
# Null Hypothesis -> (Unit.A-Unit.B) > 0
# Alternative Hypothesis -> (Unit.B -Unit.A ) < 0
# p-value = 0.236 > 0.05 => p high null fly => Reject alternate hypothesis
plot(Cutlets)
#Inference is that there is no significant difference in the diameters of Unit A and Unit B
boxplot(Unit.A,Unit.B)
