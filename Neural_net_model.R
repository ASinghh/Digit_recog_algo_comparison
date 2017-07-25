##usng h2o package for running neural nets on R
library(h2o)
local_h2o <- h2o.init(ip = "localhost", nthreads=-1)
train = read.csv( "digtrain.csv", header = FALSE)#file name changed from train to digtrain, to avoid confusion
test = read.csv("digtest.csv", header = FALSE)#file name changed from test to digtest, to avoid confusion
train[,785] = as.factor(train[,785])#converting to factors
test[,785] = as.factor(test[,785])#converting to factors
train_Data<-as.h2o(train)#changing the data frame type
test_Data=as.h2o(test)#changing the data frame type
model <- h2o.deeplearning(x = 1:784, y = 785, train_Data, activation = "Rectifier", hidden=rep(160,5),epochs = 30)
prediction<-h2o.predict(object=model, newdata=test_Data[,-785])#prediction
summary(prediction)
test_y<-test[,785]
pred = as.data.frame(prediction)
p = as.factor(pred$predict)
t = sum(diag(table(p,test_y)))
error_rate = 1- t/10000
error_rate
write.csv(p,file="Ashutosh_Final_Submission.csv") ##Manually changed column names to "Id" and "y"

