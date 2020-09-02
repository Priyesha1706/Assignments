import pandas as pd
import numpy as np
from sklearn.decomposition import PCA
from sklearn.preprocessing import StandardScaler
from sklearn.model_selection import train_test_split
import xgboost as xgb
from sklearn.ensemble import AdaBoostRegressor
from sklearn.tree import DecisionTreeRegressor
from sklearn.ensemble import RandomForestRegressor
from sklearn.metrics import explained_variance_score
from sklearn.metrics import mean_squared_error
from sklearn.metrics import r2_score as rsq
from sklearn.linear_model import LinearRegression
from sklearn.model_selection import RandomizedSearchCV
from sklearn.model_selection import cross_val_score
import os

#os.chdir('D:\\Data Science\Projects\Credit')
data=pd.read_csv('data_cleaned.csv')
data.drop(['Unnamed: 0'],axis=1,inplace=True)

x=data.drop(['total revol_bal'],axis=1)
y=data['total revol_bal']

x1=x[['loan_amnt', 'Rate_of_intrst','annual_inc', 'debt_income_ratio', 'delinq_2yrs',
       'inq_last_6mths', 'numb_credit', 'pub_rec', 'total_credits','Experience','purpose',
       'total_rec_int', 'total_rec_late_fee', 'tot_colle_amt','tot_curr_bal','collections_12_mths_ex_med']]
           
xtrain,xtest,ytrain,ytest=train_test_split(x1,y,test_size=0.20,random_state=2)

#Standardization
sc=StandardScaler()
xtrain=sc.fit_transform(xtrain)
xtest=sc.transform(xtest)

#Random Forest Regressor
rf_mod=RandomForestRegressor()
rf_mod.fit(xtrain,ytrain)
rf_pred_train=rf_mod.predict(xtrain)    
rf_train_r2=rsq(ytrain,rf_pred_train)                       #0.8664500477424131

rf_pred_test=rf_mod.predict(xtest)
rf_r2=rsq(ytest,rf_pred_test)                               #0.3238604527345351

#Hyper parameter tuning
params={
        'n_estimators':[10,20,30,40,50,60,70],
        'max_depth':[0,3,4,5,6,8,10,12,15,20,25,30,40,45,50],
        'max_features':['auto', 'sqrt', 'log2'],
        'min_samples_split':[0,2,4,6,8,10,20,30,40],
        'min_samples_leaf':[0.5,1,3,5,6,7,8]
        }
frst=RandomForestRegressor()

random_search=RandomizedSearchCV(frst,param_distributions=params,n_iter=5,n_jobs=-1,cv=5,verbose=3)
random_search.fit(xtrain,ytrain)
random_search.best_estimator_
random_search.best_params_

rf_mod=RandomForestRegressor(n_estimators= 70,min_samples_split= 4,min_samples_leaf= 5,max_features= 'auto',max_depth= 40)
rf_mod.fit(xtrain,ytrain)
rf_pred_train=rf_mod.predict(xtrain)    
rf_train_r2=rsq(ytrain,rf_pred_train)                       #0.6782062570694778

rf_pred_test=rf_mod.predict(xtest)
rf_r2=rsq(ytest,rf_pred_test)                               #0.4112456724302487

rf_test_mse = mean_squared_error(rf_pred_test, ytest)
rf_test_rmse=np.sqrt(rf_test_mse)                           #17057.69606935378

#Cross validation
score=cross_val_score(rf_mod,x1,y,cv=5)


#Linear Reression
lin=LinearRegression()
lin.fit(xtrain,ytrain)
pred_train_lin=lin.predict(xtrain)
lin_train_r2=rsq(ytrain,pred_train_lin)                     #0.26314501938529766

pred_test_lin=lin.predict(xtest)
lin_test_r2=rsq(ytest,pred_test_lin)                        #0.2710818267476741
lin_test_mse = mean_squared_error(pred_test_lin, ytest)
lin_test_rmse=np.sqrt(lin_test_mse)                         #18979.8468976574

#### XGB Regressor
xgb2=xgb.XGBRegressor()
xgb2.fit(xtrain,ytrain)
xgb_pred_train=xgb2.predict(xtrain)
xgb_train_r2=rsq(ytrain,xgb_pred_train)                     #0.5633437757796727
xgb_pred_test=xgb2.predict(xtest)
xgb_r2=rsq(ytest,xgb_pred_test)                             #0.3786597297166089
xgb_test_mse = mean_squared_error(xgb_pred_test, ytest)
xgb_test_rmse=np.sqrt(xgb_test_mse)                         #17590.675463549156

#Hyperparameter tuning
x=np.arange(0.1,0.6,0.02)
for i in x:
    model=xgb.XGBRegressor(n_jobs=-1,learning_rate=i)
    model.fit(xtrain,ytrain)
    print((i,model.score(xtest,ytest)))

model=xgb.XGBRegressor(n_jobs=-1,learning_rate=0.14)
model.fit(xtrain,ytrain)
model.score(xtrain,ytrain)          #0.5334138741755784
model.score(xtest,ytest)            #0.39228422033500165

for i in range(100,300,20):
    model=xgb.XGBRegressor(n_jobs=-1,learning_rate=0.14,n_estimators=i)
    model.fit(xtrain,ytrain)
    print((i,model.score(xtest,ytest)))

model=xgb.XGBRegressor(n_jobs=-1,learning_rate=0.14,n_estimators=120)
model.fit(xtrain,ytrain)
model.score(xtrain,ytrain)          #0.5417129406835408
model.score(xtest,ytest)            #0.3930225500091842

#Cross validation
score=cross_val_score(model,x1,y,cv=10)

#Finalizing Random forest model and training with whole data set
model=RandomForestRegressor(n_estimators= 70,min_samples_split= 4,min_samples_leaf= 5,max_features= 'auto',max_depth= 40)
model.fit(x1,y)

####  Saving model in system  ####
import pickle
pickle.dump(model,open('model.pkl','wb'))


