from flask import Flask,request,render_template 
import numpy as np
import pickle

app=Flask(__name__)

model=pickle.load(open('model.pkl','rb'))
exp=pickle.load(open('exp.pkl','rb'))
purp=pickle.load(open('purp.pkl','rb'))

#response=['25000','18.5','80000','25.5','1','1','4','0','26','< 1 year','vacation','5008','0','0','31991','0']

@app.route('/predict',methods=['POST'])
def predict():
    response=[x for x in request.form.values()]
    a=exp.get(response[9])
    response[9]=a
    a=purp.get(response[10])
    response[10]=a
    
    response=np.array(response).reshape(1,-1)
    pred=model.predict(response)
    
    return render_template("predicted.html",predicted=pred)

@app.route('/')
def home():
    return render_template("first.html")


if __name__=="__main__":
    app.run(debug=True)
    
    
    
    
    
    
    
    
    
    
    