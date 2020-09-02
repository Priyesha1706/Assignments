# -*- coding: utf-8 -*-
"""
Created on Thu Aug 27 17:51:29 2020

@author: nitin
"""

import pandas as pd
import numpy as np
import seaborn as sns
import matplotlib.pyplot as plt
import os

#os.chdir("C:\\Priyesha Data Science\\Project\\P28_balance\\data.csv")
df=pd.read_csv("C:\\Priyesha Data Science\\Project\\P28_balance\\data.csv", encoding ='latin-1')

#Check for duplicate values
df[df.duplicated()]

#Check for Null values
df.isnull().sum()
#member_id                           0
#loan_amnt                           0
#terms                               0
#batch_ID                       130748
#Rate_of_intrst                      0
#grade                               0
#sub_grade                           0
#Emp_designation                 51462
#Experience                      44825
#home_ownership                      0
#annual_inc                          4
#verification_status                 0
#purpose                             0
#State                               0
#debt_income_ratio                   0
#delinq_2yrs                        29
#inq_last_6mths                     29
#mths_since_last_delinq         454312
#mths_since_last_record         750326
#numb_credit                        29
#pub_rec                            29
#total revol_bal                     0
#total_credits                      29
#initial_list_status                 0
#total_rec_int                       0
#total_rec_late_fee                  0
#recoveries                          0
#collection_recovery_fee             0
#collections_12_mths_ex_med        145
#mths_since_last_major_derog    665676
#application_type                    0
#verification_status_joint      886868
#last_week_pay                       0
#acc_now_delinq                     29
#tot_colle_amt                   70276
#tot_curr_bal                    70276

#mths_since_last_record,mths_since_last_major_derog,verification_status_joint are having more null values so dropping those columns
#member id and batch id is holding personal information so dropping that columns

df.drop(['member_id ','batch_ID ','mths_since_last_delinq','mths_since_last_record','mths_since_last_major_derog','verification_status_joint'],axis=1,inplace=True)

#Annual income has only 4 null values, so we can drop that
t=df[df['annual_inc'].isnull()]
a=list(df[df['annual_inc'].isnull()].index)
df.drop(a,inplace=True)

#delinq_2yrs,inq_last_6mths,numb_credit,pub_rec,total_credits all have 25 NaN values
t=df.loc[df['delinq_2yrs'].isnull()]
#We came to know all NaN values in delinq_2yrs,inq_last_6mths,numb_credit,pub_rec,total_credits are equal, So dropping all of them
a=list(df.loc[df['delinq_2yrs'].isnull()].index)
df.drop(a,inplace=True)
df=df.reset_index(drop=True)

#Imputing NaN values in collections_12_mths_ex_med      #116 values
df['collections_12_mths_ex_med'].value_counts()
t=df[df.collections_12_mths_ex_med.isnull()]        
#we can see all the NaN values in collections_12_mths_ex_med is equal to NaN values in tot_colle_amt and tot_curr_bal
df['collections_12_mths_ex_med'].fillna(0,inplace=True)

#imputing NaN values in tot_curr_bal
df['tot_curr_bal'].value_counts()       #126 values are 0
t=df[['tot_curr_bal','annual_inc']]
df['tot_curr_bal'].loc[df['tot_curr_bal'].isnull()]
df['annual_inc'].max()

df.loc[(df['annual_inc']<=50000),'tot_curr_bal'].median()                               #31991
df.loc[(df['annual_inc']>50000) & (df['annual_inc']<75000),'tot_curr_bal'].median()     #81943
df.loc[(df['annual_inc']>75000) & (df['annual_inc']<150000),'tot_curr_bal'].median()    #182478
df.loc[(df['annual_inc']>150000),'tot_curr_bal'].median()                               #349118

a=list(df[df['tot_curr_bal'].isnull()].index)

for i in a:
    if df['annual_inc'][i]<=50000:
        df['tot_curr_bal'][i]=31991
    elif ((df['annual_inc'][i]>50000) & (df['annual_inc'][i]<=75000)):
        df['tot_curr_bal'][i]=81943
    elif ((df['annual_inc'][i]>75000) & (df['annual_inc'][i]<=150000)):
        df['tot_curr_bal'][i]=182478
    else:
        df['tot_curr_bal'][i]=349118

#Imputing NaN values in experience
len(df['Experience'].unique())          #12
t=df[df['Experience'].isnull()]
df.Experience.value_counts()
u=df[['annual_inc','Experience']]

#Checking for the relation of Experience with other variables
df.loc[df['Experience']=='< 1 year','annual_inc'].median()          #60000
df.loc[df['Experience']=='1 year','annual_inc'].median()            #60000
df.loc[df['Experience']=='2 years','annual_inc'].median()           #60000
df.loc[df['Experience']=='3 years','annual_inc'].median()           #60000
df.loc[df['Experience']=='4 years','annual_inc'].median()           #62000
df.loc[df['Experience']=='5 years','annual_inc'].median()           #62000
df.loc[df['Experience']=='6 years','annual_inc'].median()           #62500
df.loc[df['Experience']=='7 years','annual_inc'].median()           #63430
df.loc[df['Experience']=='8 years','annual_inc'].median()           #65000
df.loc[df['Experience']=='9 years','annual_inc'].median()           #65000
df.loc[df['Experience']=='10+ years','annual_inc'].median()         #70000    

#Removing unwanted space in loan_amnt
df.rename(columns={'loan_amnt ':'loan_amnt'},inplace=True)   
     
df.loc[df['Experience']=='< 1 year','loan_amnt'].median()          #12000
df.loc[df['Experience']=='1 year','loan_amnt'].median()            #12000
df.loc[df['Experience']=='2 years','loan_amnt'].median()           #12000
df.loc[df['Experience']=='3 years','loan_amnt'].median()           #12000
df.loc[df['Experience']=='4 years','loan_amnt'].median()           #12000
df.loc[df['Experience']=='5 years','loan_amnt'].median()           #12000
df.loc[df['Experience']=='6 years','loan_amnt'].median()           #12650
df.loc[df['Experience']=='7 years','loan_amnt'].median()           #13200
df.loc[df['Experience']=='8 years','loan_amnt'].median()           #13700
df.loc[df['Experience']=='9 years','loan_amnt'].median()           #14000
df.loc[df['Experience']=='10+ years','loan_amnt'].median()         #15000

df.loc[df['Experience']=='< 1 year','total revol_bal'].median()          #10682
df.loc[df['Experience']=='1 year','total revol_bal'].median()            #10387
df.loc[df['Experience']=='2 years','total revol_bal'].median()           #10556
df.loc[df['Experience']=='3 years','total revol_bal'].median()           #10658
df.loc[df['Experience']=='4 years','total revol_bal'].median()           #10798
df.loc[df['Experience']=='5 years','total revol_bal'].median()           #11061
df.loc[df['Experience']=='6 years','total revol_bal'].median()           #11425
df.loc[df['Experience']=='7 years','total revol_bal'].median()           #11756
df.loc[df['Experience']=='8 years','total revol_bal'].median()           #12061
df.loc[df['Experience']=='9 years','total revol_bal'].median()           #12513
df.loc[df['Experience']=='10+ years','total revol_bal'].median()         #14220

#We have checked relationof experience with following columns and found that annual_inc and loan_amnt has a linear relation
#We are using annual_inc for the imputation 
a=list(df.loc[df['Experience'].isnull()].index)

for i in a:
    if df['total revol_bal'][i]<=10387:
        df['Experience'][i]='1 years'
    elif df['total revol_bal'][i]<=10556:
        df['Experience'][i]='2 years'
    elif df['total revol_bal'][i]<=10658:
        df['Experience'][i]='3 years'
    elif df['total revol_bal'][i]<=10798:
        df['Experience'][i]='4 years'
    elif df['total revol_bal'][i]<=11061:
        df['Experience'][i]='5 years'
    elif df['total revol_bal'][i]<=11425:
        df['Experience'][i]='6 years'
    elif df['total revol_bal'][i]<=11756:
        df['Experience'][i]='7 years'
    elif df['total revol_bal'][i]<=12061:
        df['Experience'][i]='8 years'
    elif df['total revol_bal'][i]<=12513:
        df['Experience'][i]='9 years'
    else:
        df['Experience'][i]='10+ years'

#Imputing NaN values in tot_colle_amt       #70247 NaN values
t=df.loc[df['tot_colle_amt'].isnull()]
df['tot_colle_amt'].value_counts()          #700946 values are 0
df['tot_colle_amt'].std()                   #10311.367195456096
u=df.loc[df['tot_colle_amt']!=0]            #186404 values are non 0
v=df.loc[df['tot_colle_amt']==0]


#checking relation of tot_colle_amt with other variables
df.loc[(df['loan_amnt']<=5000),'tot_colle_amt'].median()                                  #0               
df.loc[(df['loan_amnt']>5000) & (df['loan_amnt']<=10000),'tot_colle_amt'].median()        #0
df.loc[(df['loan_amnt']>10000) & (df['loan_amnt']<=20000),'tot_colle_amt'].median()       #0
df.loc[(df['loan_amnt']>20000),'tot_colle_amt'].median()                                  #0  

df.loc[(df['annual_inc']<=50000),'tot_colle_amt'].median()                                  #0               
df.loc[(df['annual_inc']>50000) & (df['loan_amnt']<=75000),'tot_colle_amt'].median()        #0
df.loc[(df['annual_inc']>75000) & (df['loan_amnt']<=150000),'tot_colle_amt'].median()       #0
df.loc[(df['annual_inc']>150000),'tot_colle_amt'].median()                                  #0 
#We cant find any relation with other variables and we are only getting 0 as the median, since it is mostly present in the column
#Imputing NaN with value 0
df['tot_colle_amt'].fillna(0,inplace=True)

#Imputing NaN values in Emp_designation         #51450 values
len(df['Emp_designation'].unique())     #289195 cat values
t=df.loc[df['Emp_designation'].isnull()]
df.loc[df['annual_inc']<20000,'Emp_designation'].drop_duplicates        #10201 Emp_designation are present
#since we are having  these much unique values it is hard to impute,So replacing NaN values with NotKnown
df['Emp_designation'].fillna('NotKnown',inplace=True)

df.isnull().sum()

#Checking the unique values
len(df['terms'].unique())                   #2
len(df['Rate_of_intrst'].unique())          #542
len(df['grade'].unique())                   #7
len(df['sub_grade'].unique())               #35
len(df['Emp_designation'].unique())         #289195
len(df['Experience'].unique())              #12
len(df['home_ownership'].unique())          #6
len(df['annual_inc'].unique())              #49384
len(df['verification_status'].unique())     #3
len(df['purpose'].unique())                 #14
len(df['State'].unique())                   #51
len(df['debt_income_ratio'].unique())       #4086
len(df['delinq_2yrs'].unique())             #29
len(df['inq_last_6mths'].unique())          #28
len(df['numb_credit'].unique())             #77
len(df['pub_rec'].unique())                 #32
len(df['total_credits'].unique())           #135
len(df['initial_list_status'].unique())     #2
len(df['total_rec_int'].unique())           #324632
len(df['total_rec_late_fee'].unique())      #6104
len(df['collection_recovery_fee'].unique()) #20547
len(df['collections_12_mths_ex_med'].unique())  #13
len(df['application_type'].unique())        #2
len(df['last_week_pay'].unique())           #98
len(df['acc_now_delinq'].unique())          #8
len(df['tot_colle_amt'].unique())           #10326
len(df['tot_curr_bal'].unique())            #327343

#Changing categorical data to numerical
from sklearn.preprocessing import LabelEncoder
le=LabelEncoder()
plt.rcParams.update({'figure.figsize':(10,6),'figure.dpi':120})

###Terms
df.terms.value_counts()  
sns.barplot(x='terms',y='total revol_bal',data=df)
#People with 60 months term are having more revolving balance than 30months term
df['terms']=df['terms'].map({'36 months':0,'60 months':1})
#Mapped 36 months to 0 and 60months to 1
     
#Experience
df['Experience'].value_counts()     
#2values 1 year and 1 years, so erging them together by removing 's'
df['Experience']=df['Experience'].map(lambda x: x.replace("s",""))
df['Experience'].value_counts()   
#10+ years having the max count and 9 year is having the least count
df.groupby(['Experience'])['total revol_bal'].mean().sort_values()
sns.barplot(x='Experience',y='total revol_bal',data=df)
#3 years experience person is having lowest total revolving balance and 10+ years experience person is having highest total revolving balance 
#We can use Target Guided Ordinal Encoding
labels=df.groupby(['Experience'])['total revol_bal'].mean().sort_values().index
labels_dic={k:i for i,k in enumerate(labels,0)}
df['Experience']=df['Experience'].map(labels_dic)

#Saving to system
import pickle
pickle.dump(labels_dic,open('exp.pkl','wb'))

#Home Ownership     
df['home_ownership'].value_counts()     
#Most of the people are having home_ownership=>MORTAGE and least people are having home_ownership=>ANY
df.groupby(['home_ownership'])['total revol_bal'].mean().sort_values()
sns.barplot(x='home_ownership',y='total revol_bal',data=df)
#home_ownership=>ANY has least total revolving balance and home_ownership=>MORTAGE has having highest total revolving balance
#One hot encoding for changing Nominal cat values
dt=pd.get_dummies(df['home_ownership'],drop_first=True)
df=pd.concat([df,dt],axis=1)
df.drop(['home_ownership'],axis=1,inplace=True)

#Verification Status
df['verification_status'].value_counts()
df.groupby(['verification_status'])['total revol_bal'].mean().sort_values()
sns.barplot(x='verification_status',y='total revol_bal',data=df)
#Not Verified records are having least total revolving balance and verified records are having high total revolving balance
#One hot encoding for changing Nominal cat values
dt=pd.get_dummies(df['verification_status'],drop_first=True)
df=pd.concat([df,dt],axis=1)
df.drop(['verification_status'],axis=1,inplace=True)

#Purpose
df['purpose'].value_counts()
df.groupby(['purpose'])['total revol_bal'].mean().sort_values()
sns.barplot(x='purpose',y='total revol_bal',data=df)
#Loans for educational purpose are having least total revolving balance and loans for credit card purpose are having high total revolving balance
#Mean encoding for nominal caegories with more cat values
purp_mean=df.groupby(['purpose'])['total revol_bal'].mean().sort_values().to_dict()
df['purpose']=df['purpose'].map(purp_mean)

#Saving to system
pickle.dump(purp_mean,open('purp.pkl','wb'))

#State
df['State'].value_counts()
df.groupby(['State'])['total revol_bal'].mean().sort_values()
#State=> ID is having least total revolving balance and State=> CT is having high total revolving balance
#Mean encoding for nominal caegories with more cat values
st_mean=df.groupby(['State'])['total revol_bal'].mean().sort_values().to_dict()
df['State']=df['State'].map(st_mean)

#Initial list status
df['initial_list_status'].value_counts()
df.groupby(['initial_list_status'])['total revol_bal'].mean().sort_values()
sns.barplot(x='initial_list_status',y='total revol_bal',data=df)()
# initial_list_status=>f is having least total revolving balance and initial_list_status=>w is having high total revolving balance
#Doing mapping to change cat values
df['initial_list_status']=df['initial_list_status'].map({'f':0,'w':1})

#Application type
df['application_type'].value_counts()
df.groupby(['application_type'])['total revol_bal'].mean().sort_values()
sns.barplot(x='application_type',y='total revol_bal',data=df)()
# application_type=>Joint is having least total revolving balance and application_type=>Individual is having high total revolving balance
#Doing mapping to change cat values
df['application_type']=df['application_type'].map({'JOINT':0,'INDIVIDUAL':1})

#Emp_designation
df['Emp_designation'].value_counts()
df.groupby(['Emp_designation'])['total revol_bal'].mean().sort_values()
#Emp_designation plastic surgery is having high total revolving balance
#Mean encoding for nominal caegories with more cat values
emp_mean=df.groupby(['Emp_designation'])['total revol_bal'].mean().sort_values().to_dict()
df['Emp_designation']=df['Emp_designation'].map(emp_mean)

#Lst Week pay
df['last_week_pay'].value_counts()
df.groupby(['last_week_pay'])['total revol_bal'].mean().sort_values()
#last_week_pay=> 291 is having least total revolving balance and last_week_pay=> 283 is having high total revolving balance
#We can use Target Guided Ordinal Encoding
labels=df.groupby(['last_week_pay'])['total revol_bal'].mean().sort_values().index
labels={k:i for i,k in enumerate(labels,0)}
df['last_week_pay']=df['last_week_pay'].map(labels)

#Grade
df['grade'].value_counts()      
#B grade is given for most and G grade is only given for 5489 records
df[['grade','total revol_bal']].groupby(['grade']).mean().sort_values('total revol_bal')   
sns.barplot(x='grade',y='total revol_bal',data=df)
#A grade has highest and D grade has lowest total revolving balance  
df[['grade','Rate_of_intrst']].groupby(['grade']).mean().sort_values('Rate_of_intrst')   
#Graded based on the Rate_of_intrst, Using label encoder to change cat values
df['grade']=le.fit_transform(df['grade'])
# A=>0 , B=>1 , C=>2 , D=>3 , E=>4 , F=>5 , G=>6

#Sub Grade
df['sub_grade'].value_counts()  #B3 is give n for most and G5 is given for 576 records
df[['sub_grade','total revol_bal']].groupby(['sub_grade']).mean()  .sort_values('total revol_bal')
sns.barplot(x='sub_grade',y='total revol_bal',data=df) 
#D1&D3 subgrade has the lowest and G5 subgrade has the highest total revolving balance
df[['sub_grade','Rate_of_intrst']].groupby(['sub_grade']).mean().sort_values('Rate_of_intrst')   
#Graded based on the Rate of interest, we can map the values
sub_dic={'A1':0.1,'A2':0.2,'A3':0.3,'A4':0.4,'A5':0.5,
         'B1':1.1,'B2':1.2,'B3':1.3,'B4':1.4,'B5':1.5,
         'C1':2.1,'C2':2.2,'C3':2.3,'C4':2.4,'C5':2.5,
         'D1':3.1,'D2':3.2,'D3':3.3,'D4':3.4,'D5':3.5,
         'E1':4.1,'E2':4.2,'E3':4.3,'E4':4.4,'E5':4.5,
         'F1':5.1,'F2':5.2,'F3':5.3,'F4':5.4,'F5':5.5,
         'G1':6.1,'G2':6.2,'G3':6.3,'G4':6.4,'G5':6.5
         }
df['sub_grade']=df['sub_grade'].map(sub_dic)   

#Checking Relation of numerical vaariable with output variable
#Loan amount
df['loan_amnt'].max()   #35000
df['loan_amnt'].min()   #500

df.loc[df['loan_amnt']<8750,'total revol_bal'].median()     #6575
df.loc[(df['loan_amnt']>8750) & (df['loan_amnt']<=17500),'total revol_bal'].median()      #11166
df.loc[(df['loan_amnt']>17500) & (df['loan_amnt']<=26250),'total revol_bal'].median()     #18328
df.loc[(df['loan_amnt']>26250) & (df['loan_amnt']<=35000),'total revol_bal'].median()     #27269
#We can see a linear relation of loan amount with total revolving balance

#Rate of intrest
df['Rate_of_intrst'].min()
df['Rate_of_intrst'].max()

df.loc[(df['Rate_of_intrst']<10),'total revol_bal'].median()      #12625
df.loc[(df['Rate_of_intrst']>10) & (df['Rate_of_intrst']<=15),'total revol_bal'].median()     #11530
df.loc[(df['Rate_of_intrst']>15) & (df['Rate_of_intrst']<=20),'total revol_bal'].median()     #11607
df.loc[(df['Rate_of_intrst']>20) & (df['Rate_of_intrst']<=25),'total revol_bal'].median()     #12520
df.loc[(df['Rate_of_intrst']>25) & (df['Rate_of_intrst']<=30),'total revol_bal'].median()     #11019
#We cant find any relation with rate of intrest and total revolving balance

#Annual Income
df['annual_inc'].min()      #0
df['annual_inc'].max()      #9500000
plt.boxplot(df['annual_inc'])

df.loc[(df['annual_inc']<100000),'total revol_bal'].median()      #10634
df.loc[(df['annual_inc']>100000) & (df['annual_inc']<=250000),'total revol_bal'].median()     #21235
df.loc[(df['annual_inc']>250000) & (df['annual_inc']<=500000),'total revol_bal'].median()     #33569
df.loc[(df['annual_inc']>500000) & (df['annual_inc']<=1000000),'total revol_bal'].median()     #34386
df.loc[(df['annual_inc']>1000000) & (df['annual_inc']<=2000000),'total revol_bal'].median()       #22374
df.loc[(df['annual_inc']>2000000) & (df['annual_inc']<=3000000),'total revol_bal'].median()       #27775
df.loc[(df['annual_inc']>3000000),'total revol_bal'].median()       #15219
#We can see a linear relation in annual income with total revolving balance since annual income 1000000 
#after tha we can't find any relation

#Debt Income Ratio
df['debt_income_ratio'].min()        #0
df['debt_income_ratio'].max()       #9999

df.loc[(df['debt_income_ratio']<1000),'total revol_bal'].median()      #11875       887347value
df.loc[(df['debt_income_ratio']<250),'total revol_bal'].median()        #11875       887345value
df.loc[(df['debt_income_ratio']<50),'total revol_bal'].median()         #11875       887306value
df.loc[(df['debt_income_ratio']<5),'total revol_bal'].median()          #4808
df.loc[(df['debt_income_ratio']>5) & (df['debt_income_ratio']<=10),'total revol_bal'].median()          #8829   
df.loc[(df['debt_income_ratio']>10) & (df['debt_income_ratio']<=15),'total revol_bal'].median()         #11007
df.loc[(df['debt_income_ratio']>15) & (df['debt_income_ratio']<=20),'total revol_bal'].median()         #12554
df.loc[(df['debt_income_ratio']>20) & (df['debt_income_ratio']<=25),'total revol_bal'].median()         #13691       
df.loc[(df['debt_income_ratio']>25) & (df['debt_income_ratio']<=30),'total revol_bal'].median()         #14636
df.loc[(df['debt_income_ratio']>30) & (df['debt_income_ratio']<=35),'total revol_bal'].median()         #15507
df.loc[(df['debt_income_ratio']>40) & (df['debt_income_ratio']<=45),'total revol_bal'].median()         #16743
df.loc[(df['debt_income_ratio']>45) & (df['debt_income_ratio']<=50),'total revol_bal'].median()         #13550  
#most of the values are present in debt_income_ratio less than 50
#We can see a linear relation in debt_income_ratio with total revolving balance

#delinq_2yrs
df['delinq_2yrs'].value_counts()
df['delinq_2yrs'].min()
df['delinq_2yrs'].max()
#We can see most of the values at 0 and only one digit count from 19 to 39 and 2 digit count from 12 to 19
# Most of the values lies in 0 and 1

df.loc[df['delinq_2yrs']<1,'total revol_bal'].median()      #12170
df.loc[(df['delinq_2yrs']>=1),'total revol_bal'].median()   #10679
#We are not getting the relation since the most of the values is concentrated at 0 => 716961

#inq_last_6mths
df['inq_last_6mths'].value_counts()
df['inq_last_6mths'].min()
df['inq_last_6mths'].max()
#We can see most of the values at 0 and only one digit count from 15 to 33 and 2 digit count from 9 to 12
# Most of the values lies in 0 and 1 

df.loc[df['inq_last_6mths']<1,'total revol_bal'].median()      #12358
df.loc[(df['inq_last_6mths']>=1),'total revol_bal'].median()   #11273
#We are not getting the relation since the most of the values is concentrated at 0 => 497905

#numb_credit
df['numb_credit'].value_counts()
df['numb_credit'].min()
df['numb_credit'].max()

df.loc[df['numb_credit']<=15,'total revol_bal'].median()                                #10670
df.loc[(df['numb_credit']>15) & (df['numb_credit']<=30),'total revol_bal'].median()     #18273
df.loc[(df['numb_credit']>30) & (df['numb_credit']<=45),'total revol_bal'].median()     #22614
df.loc[(df['numb_credit']>45) & (df['numb_credit']<=60),'total revol_bal'].median()     #25758
df.loc[(df['numb_credit']>60) & (df['numb_credit']<=75),'total revol_bal'].median()     #25924
df.loc[(df['numb_credit']>75),'total revol_bal'].median()                               #35180
#We can see as the number of open credit line increases the total revolving balance is also increasing.
#Number of open credit line and total revolving balance is linearly related

#pub_rec
df['pub_rec'].value_counts()
df['pub_rec'].min()
df['pub_rec'].max()
#We can see most of the values at 0 and only one digit count from 15 to 86 and 2 digit count from 9 to 13
# Most of the values lies in 0 and 1 

df.loc[df['pub_rec']<1,'total revol_bal'].median()      #13029
df.loc[(df['pub_rec']>=1),'total revol_bal'].median()   #7511
#We are not getting the relation since the most of the values is concentrated at 0 => 751572

#total_credits
df['total_credits'].value_counts()
df['total_credits'].min()
df['total_credits'].max()

df.loc[df['total_credits']<=30,'total revol_bal'].median()                                  #10636
df.loc[(df['total_credits']>30) & (df['total_credits']<=60),'total revol_bal'].median()     #15938
df.loc[(df['total_credits']>60) & (df['total_credits']<=90),'total revol_bal'].median()     #17817.5
df.loc[(df['total_credits']>90) & (df['total_credits']<=120),'total revol_bal'].median()    #14737
df.loc[(df['total_credits']>120) & (df['total_credits']<=150),'total revol_bal'].median()   #25497
df.loc[df['total_credits']>150,'total revol_bal'].median()                                  #17270
#We cant find any relation between these 2 variables

#total_rec_int
df['total_rec_int'].value_counts()
df['total_rec_int'].min()
df['total_rec_int'].max()
#0 values has more count compared to others =>18214

df.loc[df['total_rec_int']<=5000,'total revol_bal'].median()                                        #11389
df.loc[(df['total_rec_int']>5000) & (df['total_rec_int']<=10000),'total revol_bal'].median()        #20045
df.loc[(df['total_rec_int']>10000) & (df['total_rec_int']<=15000),'total revol_bal'].median()       #22733
df.loc[(df['total_rec_int']>15000) & (df['total_rec_int']<=20000),'total revol_bal'].median()       #25085
df.loc[df['total_rec_int']>20000,'total revol_bal'].median()                                        #25402.5
#As the total recieved interest increases, total revolving balance is also increasing
#We can see a linear relation for total_rec_int and total revolving balance

#total_rec_late_fee
df['total_rec_late_fee'].value_counts()
df['total_rec_late_fee'].min()
df['total_rec_late_fee'].max()
#We can see most of the values at 0

df.loc[df['total_rec_late_fee']<1,'total revol_bal'].median()       #11902
df.loc[(df['total_rec_late_fee']>=1),'total revol_bal'].median()    #10001
#We are not getting the relation since the most of the values is concentrated at 0 => 874837

#collection_recovery_fee
df['collection_recovery_fee'].value_counts()
df['collection_recovery_fee'].min()
df['collection_recovery_fee'].max()
#We can see most of the values at 0

df.loc[df['collection_recovery_fee']<1,'total revol_bal'].median()       #11897
df.loc[(df['collection_recovery_fee']>=1),'total revol_bal'].median()    #11148.5
#We are not getting the relation since the most of the values is concentrated at 0 => 863846

#collections_12_mths_ex_med
df['collections_12_mths_ex_med'].value_counts()
df['collections_12_mths_ex_med'].min()
df['collections_12_mths_ex_med'].max()
#We can see most of the values at 0 and only one digit count from 5 to 20

df.loc[df['collections_12_mths_ex_med']<1,'total revol_bal'].median()      #11930
df.loc[(df['collections_12_mths_ex_med']>=1),'total revol_bal'].median()   #8323
#We are not getting the relation since the most of the values is concentrated at 0 => 875669
sns.barplot('collections_12_mths_ex_med','total revol_bal',data=df)
#we can see from bar plot collections_12_mths_ex_med =>5 and 7 is having more total revolving balance
#collections_12_mths_ex_med => 16 is having the least total revolving balance

#acc_now_delinq
df['acc_now_delinq'].value_counts()
df['acc_now_delinq'].min()
df['acc_now_delinq'].max()
#We can see most of the values at 0

df.loc[df['acc_now_delinq']<1,'total revol_bal'].median()      #11879
df.loc[(df['acc_now_delinq']>=1),'total revol_bal'].median()   #10815
#We are not getting the relation since the most of the values is concentrated at 0 => 883236
sns.barplot('acc_now_delinq','total revol_bal',data=df)
#acc_now_delinq => 3 is having highest total revolving balance
#acc_now_delinq => 6 is having the least total revolving balance

#tot_colle_amt
df['tot_colle_amt'].value_counts()
df['tot_colle_amt'].min()
df['tot_colle_amt'].max()
#We can see most of the values at 0

df.loc[df['tot_colle_amt']<1,'total revol_bal'].median()      #12504
df.loc[(df['tot_colle_amt']>=1),'total revol_bal'].median()   #8505
#We are not getting the relation since the most of the values is concentrated at 0 => 771193

#tot_curr_bal
df['tot_curr_bal'].value_counts()
df['tot_curr_bal'].min()
df['tot_curr_bal'].max()

df.loc[df['tot_curr_bal']<=50000,'total revol_bal'].median()                                        #8613
df.loc[(df['tot_curr_bal']>50000) & (df['tot_curr_bal']<=150000),'total revol_bal'].median()        #12442
df.loc[(df['tot_curr_bal']>150000) & (df['tot_curr_bal']<=300000),'total revol_bal'].median()       #15283
df.loc[(df['tot_curr_bal']>300000) & (df['tot_curr_bal']<=500000),'total revol_bal'].median()       #21413
df.loc[df['tot_curr_bal']>500000,'total revol_bal'].median()                                        #32204
#We can observe as the total current balance is increasing, total revolving balance is also increasing
#We can see a linear relation for tot_curr_bal and total revolving balance

#Checking normality of the data
import scipy.stats as st
import pylab

def norm_plot(df,feature):
    plt.subplot(1,2,1)
    df[feature].hist()
    plt.subplot(1,2,2)
    st.probplot(df[feature],plot=pylab)
    
norm_plot(df,'loan_amnt')       #Not normal
norm_plot(df,'Rate_of_intrst')      #Some what normal
norm_plot(df,'annual_inc')      #Not Normal
norm_plot(df,'debt_income_ratio')   #Normal data with some outliers
norm_plot(df,'delinq_2yrs')     #Not normal
norm_plot(df,'inq_last_6mths')  #Not Normal
norm_plot(df,'numb_credit')     #Not Normal
norm_plot(df,'pub_rec')         #Not Normal
norm_plot(df,'total revol_bal') #Not Normal
norm_plot(df,'total_credits')   #Not Normal
norm_plot(df,'total_rec_int')   #Not Normal
norm_plot(df,'total_rec_late_fee')  #Not Normal
norm_plot(df,'recoveries')      #Not Normal
norm_plot(df,'collection_recovery_fee') #Not Normal
norm_plot(df,'tot_colle_amt')       #Some what normal
norm_plot(df,'tot_curr_bal')    #Not Normal


#Feature Selection
x=df.drop(['total revol_bal'],axis=1)
y=df['total revol_bal']
corr=x.corr()
top_corr=corr.index
sns.heatmap(df[top_corr].corr(),annot=True,cmap='RdYlGn')

threshold=0.9
#Find and remove correlated features
def correlation(df,threshold):
    col_corr=set()     #Set of all the names of correlated columns
    corr_matrix=df.corr()
    for i in range(len(corr_matrix.columns)):
        for j in range(i):
            if abs(corr_matrix.iloc[i,j])>threshold:
                colname=corr_matrix.columns[i]
                col_corr.add(colname)
    return col_corr            

correlation(x,threshold)        #Grade and SubGrade is higly correlated
#So we can remove one of the variable
df.drop(['grade'],axis=1,inplace=True)

#We need to remove SubGrade and State, which is not relevant (Got from domain expert)
df.drop(['sub_grade','State'],axis=1,inplace=True)

#sns.pairplot(df)

data_cleaned=df
data_cleaned.to_csv("data_cleaned.csv",encoding='utf-8')

#from sklearn.feature_selection import SelectKBest
#from sklearn.feature_selection import chi2
#from sklearn.ensemble import ExtraTreesClassifier
#model=ExtraTreesClassifier()
#model.fit(x,y)
