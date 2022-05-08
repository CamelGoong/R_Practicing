# 1차시: 서포트벡터머신1 -----------------------------------------------------------
install.packages("e1071")
library(e1071)
library(caret)
getwd()
setwd("C://Users/goong/OneDrive - postech.ac.kr/바탕 화면/Postech/학교, 학사/1학년 1학기/데이터 분석을 위한 R프로그래밍/wk10")
iris <- read.csv("iris.csv", stringsAsFactors = TRUE)
attach(iris)

# classification
m1 <- svm(Species ~., data = iris) # 나머지 모든 변수들을 독립변수로 쓰겠다다
summary(m1)

# m1은 지금 모든 데이터를 분류한 것의 결과
x <- iris[, -5] # 5번째 범주형 변수를 제외한 x 데이터
pred <- predict(m1, x) # m1이라는 데이터에 x라는 변수를 넣어서 예측을 해봐라

# check accuracy (compare predicted class)
y <- iris[,5]
confusionMatrix(pred,y) # 예측된 범주, 실제 범주
# 결과를 보면 실제 범주가 reference임.

# svd 시각화
plot(m1, iris,  Petal.Width~Petal.Length, slice=list(Sepal.Width=3, Sepal.Length=4))
# 우리는 iris 데이터에서 petal.width와 petal.length가 가장 중요한 변수임을 알고있음.

# 2차시: 서포트벡터머신2 -----------------------------------------------------------
# training data(100) & test set(50)
set.seed(1000)
N = nrow(iris)
tr.idx = sample(1:N, size = N*2/3)

# target variable
y = iris[, 5]

# split train data and test data
train = iris[tr.idx,]
test = iris[-tr.idx,]

# svm using kernel
library(e1071)
library(caret)
m1 <- svm(Species~., data = train) # kernel = radial
m2 <- svm(Species~., data = train, kernel = "polynomial")
m3 <- svm(Species~., data = train, kernel = "sigmoid")
m4<-svm(Species~., data = train,kernel="linear")
summary(m1)

# 정확도 측정
pred11 <- predict(m1,test)
confusionMatrix(pred11, test$Species)

pred12 <- predict(m2, test)
confusionMatrix(pred12, test$Species)

pred13 <- predict(m3, test)
confusionMatrix(pred13, test$Species)

pred14 <- predict(m4, test)
confusionMatrix(pred14, test$Species)
# kernel함수의 종류를 무엇을 사용하는지에 따라서, 오분류되는 범주 양상이 조금씩 달라짐.


# 3차시: 서포트벡터머신3 -----------------------------------------------------------
library(e1071)
library(caret)
getwd()
setwd("C:/Users/goong/OneDrive - postech.ac.kr/바탕 화면/Postech/학교, 학사/1학년 1학기/데이터 분석을 위한 R프로그래밍/wk10")
cancer<-read.csv("cancer.csv", stringsAsFactors = TRUE)
head(cancer, n =10)

# remove X1 wcolumn(ID number)
cancer <- cancer[, names(cancer) != "x1"] # x1 column만 제외
attach(cancer)

# training (455) & test set(228)
N = nrow(cancer)
set.seed(998)

# split train data and test data
tr.idx = sample(1:N, size = N*2/3, replace = FALSE)
train <- cancer[tr.idx,]
test <- cancer[-tr.idx,]

# svm using different kernel
m1 <- svm(Y~., data = train)
m2 <- svm(Y~., data = train, kernel = "polynomial")
m3 <- svm(Y~., data = train, kernel = "sigmoid")
m4 <- svm(Y~., data = train, kernel = "linear")
summary(m4)

# radial-basis function
pred11 <- predict(m1, test)
confusionMatrix(pred11, test$Y)

# polynomial
pred12 <- predict(m2, test)
confusionMatrix(pred12, test$Y)
# cancer가 악성인데, 정상으로 분류된 것이 13개나 나옴. False negative가 질병의 예측에서는 훨씬 위험도가 큼.

# sigmoid
pred13 <- predict(m3, test)
confusionMatrix(pred13, test$Y)

# linear
pred14 <- predict(m4, test)
confusionMatrix(pred14, test$Y)

# Quiz --------------------------------------------------------------------
# data 분리
set.seed(123)
N = nrow(iris)
tr.idx = sample(1:N, size = N*3/5)
train = iris[tr.idx,]
test = iris[-tr.idx,]

# svm 모델 만들기
m1 <- svm(Species~., data = train)
m2 <- svm(Species~., data = train, kernel = "polynomial")
m3 <- svm(Species~., data = train, kernel = "sigmoid")
m4 <- svm(Species~., data = train, kernel= "linear")

pred11 <- predict(m1, test)
confusionMatrix(pred11, test$Species) # accuracy = 0.95
pred12 <- predict(m2, test)
confusionMatrix(pred12, test$Species) # accuracy = 0.9333
pred13 <- predict(m3, test)
confusionMatrix(pred13, test$Species) # accuracy = 0.8833
pred14 <- predict(m4, test)
confusionMatrix(pred14, test$Species) # accuracy = 0.9667
