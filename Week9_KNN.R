# 1차시: k-인접기법 -------------------------------------------------------------
# KNN
install.packages("class") # for KNN
install.packages("caret") # for confusion matrix
install.packages("scales") # for graph
library(class)
library(caret)
library(scales)

getwd()
setwd("C:/Users/goong/OneDrive - postech.ac.kr/바탕 화면/Postech/학교, 학사/1학년 1학기/데이터 분석을 위한 R프로그래밍/wk9")
iris <- read.csv("iris.csv", stringAsFactors = T)

# training/ test data : n=150
set.seed(1000, sample.kind="Rounding")
n <- nrow(iris)
# train set 100, test set 50
tr.idx <- sample.int(n, size = round(2/3* n))

# attributes in training and test
iris.train<-iris[tr.idx,-5]
iris.test<-iris[-tr.idx,-5]

# target value in training and test
trainLabels<-iris[tr.idx,5]
testLabels<-iris[-tr.idx,5]

train<-iris[tr.idx,]
test<-iris[-tr.idx,]

# KNN(5-nearest neighbor)
md1 <- knn(train = iris.train, test = iris.test, cl = trainLabels, k = 5)
md1 # train 데이터로 훈련을 시키고, test 데이터를 input으로 예측한 결과가 담겨있음.

# KNN의 결과 - 정확도
# Confusion Matrix
confusionMatrix(md1, testLabels) # md1: 예측값, testLabels: 실제값

# KNN에서 최적 K 탐색
accuracy_k <- NULL

# try k=1 to nrow(train)/2, may use nrow(train) / 3(or 4, 5) depending on the size of data
nnum <- nrow(iris.train) / 2

for(kk in c(1:nnum)){
  set.seed(1234)
  knn_k <- knn(train = iris.train, test = iris.test, cl = trainLabels, k =kk) # k = kk만 계속 바뀜.
  accuracy_k <- c(accuracy_k, sum(knn_k==testLabels)/length(testLabels))
}
accuracy_k

# plot for k = (1 to m/2) and accuracy
test_k <- data.frame(k = c(1:nnum), accuracy = accuracy_k[c(1:nnum)])
head(test_k)
plot(formula = accuracy~k, data = test_k, type = "o", ylim = c(0.5,1), pch = 20, col = 3, main="validation-optimal k")
with(test_k,text(accuracy~k,labels = k,pos=1,cex=0.7))

# minimum k for the highest accuracy
min(test_k[test_k$accuracy %in% max(accuracy_k), "k"])
test_k[test_k$accuracy %in% max(accuracy_k), "k"]

# 최종 KNN모형 (k = 8)
md2 <- knn(train = iris.train, test = iris.test, cl = trainLabels, k = 7)
confusionMatrix(md2, testLabels)

# KNN(k=7)의 결과 - 그래픽
plot(formula=Petal.Length~Petal.Width,
     data=iris.train, col = alpha(c("purple", "blue", "green"), 0.7)[trainLabels],
     main = "KNN(k=7)")

points(formula=Petal.Length~Petal.Width,
       data=iris.test,
       pch = 17,
       cex = 1.2,
       col=alpha(c("purple", "blue", "green"),0.7)[md2]
       )
legend("bottomright",
       c(paste("train", levels(trainLabels)), paste("test", levels(testLabels))),
       pch = c(rep(1,3), rep(17,3)),
       col = c(rep(alpha(c("purple", "blue", "green"),0.7),2)),
       cex=0.9
       )


# 2차시: 판별분석1 - 선형판별분석 -----------------------------------------------------
# read csv file# read csv file
iris<-read.csv("iris.csv", stringsAsFactors = TRUE)
attach(iris)

# iris data n=150
set.seed(1000, sample.kind="Rounding")
n <- nrow(iris)
# train set 100, test set 50
tr.idx <- sample.int(n, size = round(2/3* n))

# attributes in training and test
iris.train<-iris[tr.idx,-5]
iris.test<-iris[-tr.idx,-5]

# target value in training and test
trainLabels<-iris[tr.idx,5]
testLabels<-iris[-tr.idx,5]

train<-iris[tr.idx,]
test<-iris[-tr.idx,]

# 선형판별분석(LDA) - MASS 패키지 설치
install.packages("MASS")
library(MASS)
# LDA 함수: lda(종속변수~독립변수, data = 학습 데이터 이름, prior = 사전확률)
iris.lda <- lda(Species ~., data = train, prior  = c(1/3, 1/3, 1/3))
iris.lda

# predict test data set n = 50
testpred <- predict(iris.lda, test)
testpred

write.csv(testpred,file="testpred.csv", row.names = FALSE)

# 정확도 산정: 오분류율(검증데이터)
library(caret)
confusionMatrix(testpred$class, testLabels)

# 3차시: 판별분석2 - 이차판별분석 -----------------------------------------------------
# 모집단 등분산 검정 -> 분산-공분산 행렬이 범주별로 다른 경우, QDA 실시
install.packages("biotools")
library(biotools)
boxM(iris[1:4], iris$Species) # boxM(독립변수, 종속변수)
# p-value를 보고, 귀무가설 기각 여부를 판단하면 됨.

# 이차판별분석(QDA)
iris.qda <- qda(Species~., data = train, prior = c(1/3, 1/3, 1/3))
iris.qda

testpredq <- predict(iris.qda, test)
testpredq

# accuracy of QDA
confusionMatrix(testpredq$class, testLabels)
