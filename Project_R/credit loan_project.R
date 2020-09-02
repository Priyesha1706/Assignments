library(gmodels)
library(lubridate)
library(dplyr)
library(ggplot2)
library(caTools)
library(e1071)
library(ROCR)
library(caret)
#Loading files into R data frame
#Loading data into R data frame
credit_data <- read.csv("C:\\Priyesha Data Science\\Project\\P28_balance\\data.csv")
attach(credit_data)
head(credit_data)
str(credit_data)
tble <- tbl_df(credit_data)
glimpse(tble)
#We first remove the columns that more than 50% of values are NaNs.
df <- tble[, colSums(is.na(tble)) < length(tble)/2]
head(df)
# As you can see from the table above, we have 24 columns remaining. Lets focus on these columns over the course of our EDA.
#Now, I have divided the entire dataset into 2 seperate ones, one for numeric columns and one for factor columns. The tables above show a head of each of these 2 newly created dataframes.
factor_vars <- df[, sapply(df, is.factor)]
head(factor_vars)
numeric_vars <- df[, sapply(df, is.numeric)]
head(numeric_vars)
#we can do the distribution of Loan Amount using 2 different plots.
p1 <- ggplot(data = df,aes(loan_amnt))+ geom_histogram(binwidth = 1000)
p2 <- ggplot(data = df,aes(loan_amnt))+geom_density(fill = "grey")
grid.arrange(p1,p2, ncol = 2)
summary(df$loan_amnt)
#As we can see from the table above, the loan amount varies between minimum 500 up to maximum of 35000. The mean of the loan amount is 14755 and as the boxplot suggests, the majority of the loans are somewhere between 8000 - 20000. There are a large number of loans of 35000 as well.
loan_stats_df <-subset(df, !is.na(df$initial_list_status)) %>% group_by(initial_list_status) %>% summarise(Number = n())
loan_stats_df


#2nd WAY

no_missing_values <- !is.na(credit_data$annual_inc) & !is.na(credit_data$delinq_2yrs) & !is.na(credit_data$inq_last_6mths) & !is.na(credit_data$mths_since_last_delinq) & !is.na(credit_data$mths_since_last_record) & !is.na(credit_data$numb_credit)& !is.na(credit_data$pub_rec)& !is.na(credit_data$total_credits)& !is.na(credit_data$collections_12_mths_ex_med)& !is.na(credit_data$mths_since_last_major_derog)& !is.na(credit_data$acc_now_delinq)& !is.na(credit_data$tot_colle_amt)& !is.na(credit_data$tot_curr_bal)

loans_no_missing_values <- subset(credit_data, no_missing_values)
loans_missing_values <- subset(credit_data, no_missing_values == FALSE)

paste('Number of loans with no missing values :', nrow(loans_no_missing_values))

paste('Number of loans with a missing values :', nrow(loans_missing_values))


# imputing na values
class(credit_data$annual_inc) #It is factor, should be numeric
credit_data$annual_inc<- as.numeric(sub("%","",credit_data$annual_inc)) #Taking out % sign and converting into numeric
credit_data$annual_inc <- credit_data$annual_inc / 100
is.numeric(credit_data$annual_inc) # TRUE
anyNA(credit_data$annual_inc) #There are missing values

index.NA <- which(is.na(credit_data$annual_inc))
credit_data$annual_inc[index.NA] <- median(credit_data$annual_inc, na.rm = TRUE) #All missing values replaced by median 
anyNA(credit_data$annual_inc) #No missing value

class(credit_data$delinq_2yrs)  #should be numeric
credit_data$delinq_2yrs<- as.character(sub("%","",credit_data$delinq_2yrs)) #Taking out % sign and converting into integer
credit_data$delinq_2yrs<- as.numeric(sub("%","",credit_data$delinq_2yrs))
credit_data$delinq_2yrs <- credit_data$delinq_2yrs / 100
is.numeric(credit_data$delinq_2yrs) # TRUE
anyNA(credit_data$delinq_2yrs) #There are missing values



class(credit_data$inq_last_6mths)  #should be numeric
credit_data$inq_last_6mths<- as.numeric(sub("%","",credit_data$inq_last_6mths)) #Taking out % sign and converting into integer
credit_data$inq_last_6mths <- credit_data$inq_last_6mths / 100
is.numeric(credit_data$inq_last_6mths) # TRUE
anyNA(credit_data$inq_last_6mths) #There are missing values

index.NA <- which(is.na(credit_data$inq_last_6mths))
credit_data$inq_last_6mths[index.NA] <- median(credit_data$inq_last_6mths, na.rm = TRUE) #All missing values replaced by median 
anyNA(credit_data$inq_last_6mths) #No missing value


class(credit_data$mths_since_last_delinq)  #should be numeric
credit_data$inq_last_6mths<- as.numeric(sub("%","",credit_data$mths_since_last_delinq)) #Taking out % sign and converting into integer
credit_data$inq_last_6mths <- credit_data$inq_last_6mths / 100
is.numeric(credit_data$mths_since_last_delinq) # TRUE
anyNA(credit_data$mths_since_last_delinq) #There are missing values

index.NA <- which(is.na(credit_data$mths_since_last_delinq))
credit_data$mths_since_last_delinq[index.NA] <- median(credit_data$mths_since_last_delinq, na.rm = TRUE) #All missing values replaced by median 
anyNA(credit_data$mths_since_last_delinq) #No missing value


class(credit_data$mths_since_last_record)  #should be numeric
credit_data$mths_since_last_record<- as.numeric(sub("%","",credit_data$mths_since_last_record)) #Taking out % sign and converting into integer
credit_data$mths_since_last_record <- credit_data$mths_since_last_record / 100
is.numeric(credit_data$mths_since_last_record) # TRUE
anyNA(credit_data$mths_since_last_record) #There are missing values

index.NA <- which(is.na(credit_data$mths_since_last_record))
credit_data$mths_since_last_record[index.NA] <- median(credit_data$mths_since_last_record, na.rm = TRUE) #All missing values replaced by median 
anyNA(credit_data$mths_since_last_record) #No missing value


class(credit_data$numb_credit)  #should be numeric
credit_data$numb_credit<- as.integer(sub("%","",credit_data$numb_credit)) #Taking out % sign and converting into integer
credit_data$numb_credit <- credit_data$numb_credit / 100
is.numeric(credit_data$numb_credit) # TRUE
anyNA(credit_data$numb_credit) #There are missing values

index.NA <- which(is.na(credit_data$numb_credit))
credit_data$numb_credit[index.NA] <- median(credit_data$numb_credit, na.rm = TRUE) #All missing values replaced by median 
anyNA(credit_data$numb_credit) #No missing value


class(credit_data$pub_rec)  #should be numeric
credit_data$pub_rec<- as.integer(sub("%","",credit_data$pub_rec)) #Taking out % sign and converting into integer
credit_data$pub_rec <- credit_data$pub_rec / 100
is.numeric(credit_data$pub_rec) # TRUE
anyNA(credit_data$pub_rec) #There are missing values

index.NA <- which(is.na(credit_data$pub_rec))
credit_data$pub_rec[index.NA] <- median(credit_data$pub_rec, na.rm = TRUE) #All missing values replaced by median 
anyNA(credit_data$pub_rec) #No missing value

class(credit_data$total_credits)  #should be numeric
credit_data$total_credits<- as.integer(sub("%","",credit_data$total_credits)) #Taking out % sign and converting into integer
credit_data$total_credits <- credit_data$total_credits / 100
is.numeric(credit_data$total_credits) # TRUE
anyNA(credit_data$total_credits) #There are missing values

index.NA <- which(is.na(credit_data$total_credits))
credit_data$total_credits[index.NA] <- median(credit_data$total_credits, na.rm = TRUE) #All missing values replaced by median 
anyNA(credit_data$total_credits) #No missing value

class(credit_data$collections_12_mths_ex_med)  #should be numeric
credit_data$collections_12_mths_ex_med<- as.integer(sub("%","",credit_data$collections_12_mths_ex_med)) #Taking out % sign and converting into integer
credit_data$collections_12_mths_ex_med <- credit_data$collections_12_mths_ex_med / 100
is.numeric(credit_data$collections_12_mths_ex_med) # TRUE
anyNA(credit_data$collections_12_mths_ex_med) #There are missing values

index.NA <- which(is.na(credit_data$collections_12_mths_ex_med))
credit_data$collections_12_mths_ex_med[index.NA] <- median(credit_data$collections_12_mths_ex_med, na.rm = TRUE) #All missing values replaced by median 
anyNA(credit_data$collections_12_mths_ex_med) #No missing value

class(credit_data$mths_since_last_major_derog)  #should be numeric
credit_data$mths_since_last_major_derog<- as.integer(sub("%","",credit_data$mths_since_last_major_derog)) #Taking out % sign and converting into integer
credit_data$mths_since_last_major_derog <- credit_data$mths_since_last_major_derog / 100
is.numeric(credit_data$mths_since_last_major_derog) # TRUE
anyNA(credit_data$mths_since_last_major_derog) #There are missing values

index.NA <- which(is.na(credit_data$mths_since_last_major_derog))
credit_data$mths_since_last_major_derog[index.NA] <- median(credit_data$mths_since_last_major_derog, na.rm = TRUE) #All missing values replaced by median 
anyNA(credit_data$mths_since_last_major_derog) #No missing value


class(credit_data$acc_now_delinq)  #should be numeric
credit_data$acc_now_delinq<- as.integer(sub("%","",credit_data$acc_now_delinq)) #Taking out % sign and converting into integer
credit_data$acc_now_delinq <- credit_data$acc_now_delinq / 100
is.numeric(credit_data$acc_now_delinq) # TRUE
anyNA(credit_data$acc_now_delinq) #There are missing values

index.NA <- which(is.na(credit_data$acc_now_delinq))
credit_data$acc_now_delinq[index.NA] <- median(credit_data$acc_now_delinq, na.rm = TRUE) #All missing values replaced by median 
anyNA(credit_data$acc_now_delinq) #No missing value


class(credit_data$tot_colle_amt)  #should be numeric
credit_data$tot_colle_amt<- as.integer(sub("%","",credit_data$tot_colle_amt)) #Taking out % sign and converting into integer
credit_data$tot_colle_amt <- credit_data$tot_colle_amt / 100
is.numeric(credit_data$tot_colle_amt) # TRUE
anyNA(credit_data$tot_colle_amt) #There are missing values

index.NA <- which(is.na(credit_data$tot_colle_amt))
credit_data$tot_colle_amt[index.NA] <- median(credit_data$tot_colle_amt, na.rm = TRUE) #All missing values replaced by median 
anyNA(credit_data$tot_colle_amt) #No missing value

class(credit_data$tot_curr_bal)  #should be numeric
credit_data$tot_curr_bal<- as.integer(sub("%","",credit_data$tot_curr_bal)) #Taking out % sign and converting into integer
credit_data$tot_curr_bal <- credit_data$tot_curr_bal / 100
is.numeric(credit_data$tot_curr_bal) # TRUE
anyNA(credit_data$tot_curr_bal) #There are missing values

index.NA <- which(is.na(credit_data$tot_curr_bal))
credit_data$tot_curr_bal[index.NA] <- median(credit_data$tot_curr_bal, na.rm = TRUE) #All missing values replaced by median 
anyNA(credit_data$tot_curr_bal) #No missing value

summary(credit_data)