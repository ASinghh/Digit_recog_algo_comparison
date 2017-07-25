
train_rows = 50000
test_rows = 10000
train = read.csv("train.csv" , header = F , nrows = train_rows )
test = read.csv( "test.csv" , header = F , nrow= test_rows )
#last column is the label 
train$V785 = as.factor(train$V785 )
test$V785 = as.factor(test$V785 )
# remove predictors wth little variability

SD<20 # this parameter was set by tuning on the training set.

# ##
# ## 20 was s o r t o f a g u e s s !
# ##
cut_off = 20
bad_columns = which ( apply( train[ , - ncol( train ) ] , 2 , sd ) < cut_off )
length( bad_columns )
train = train[ ,-bad_columns ]
test = test[,-bad_columns]

# Train and test with SVM
library(e1071)
# tune
set.seed(110)
system.time ( {
  tune_svm = tune( svm , V785 ~ . , data = train , kernel = " polynomial " , degree =3 ,
                           
                           ranges = list ( cost = c(1,5,10,1000 ) , gamma = c(0.0001, 0.001,0.01,1)),
                           tunecontrol = tune.control(cross=5))
  
} )
tune_svm
# Create Final Model withh parameters
svm_final = svm( V785 ~ . , data = train , cost = tune_svm$best.parameters$cost , kernel = "polynomial " , degree =3 ,
                       
                       gamma = tune_svm$best.parameters$gamma)

svm_y_final = predict( svm_final , newdata = test )
confusion_matrix_final = table( predicted = svm_y_final , actual = test$V785 )
confusion_matrix_final
error_rate_final = 1 - (sum(diag(confusion_matrix_final ) ) / nrow(test) )
error_rate_final
