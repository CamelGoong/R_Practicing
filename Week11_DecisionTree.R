# 1차시: 의사결정나무1 ------------------------------------------------------------
library(tree)
library(caret)

setwd("C:/Users/goong/OneDrive - postech.ac.kr/바탕 화면/Postech/학교, 학사/1학년 1학기/데이터 분석을 위한 R프로그래밍/wk11")

iris <- read.csv("iris.csv", stringAsFactors = TRUE)
attach(iris)

set.seed(1000)
N <- nrow(iris)
tr.idx <- sample(1:N, size=N*2/3, replace = FALSE)

train <- iris[tr.idx,]
test <- iris[-tr.idx,]

# Method 1) tree
# step1: growing tree
treemod <- tree(Species~., data = train)
plot(treemod)
text(treemod, cex = 1.5)

# step2: pruning using cross-validation
# 가지치기를 어디서 해야하는지를 알아보는 함수인 cv.tree
cv.trees <- cv.tree(treemod, FUN = prune.misclass)
cv.trees
plot(cv.trees)

par(mfrow = c(1,2))
plot(cv.trees$size, cv.trees$dev, type = "b")
plot(cv.trees$k, cv.trees$dev, type = "b")

# 최종 트리모형
prune.trees <- prune.misclass(treemod, best = 3)
plot(prune.trees)
text(prune.trees, pretty = 0, cex = 1.5)

# step3: classify test data
treepred <- predict(prune.trees, test, type = "class" )
# classification accuracy
confusionMatrix(treepred, test$Species)

# 2차시: 의사결정나무2 ------------------------------------------------------------
install.packages("rpart")
install.packages("party")
library(rpart)
library(party)
library(caret)

# Method 2) rpart
cl1 <- rpart(Species~., data = train)
plot(cl1)
text(cl1,cex = 1)

# pruning (cross-validation) - rpart
printcp(cl1) # printcp(): cross validation error의 값이 최소가 되는 트리를 선택
plotcp(cl1)

pcl1 <- prune(cl1, cp = cl1$cptable[which.min(cl1$cptable[,"xerror"]), "CP"])
plot(pcl1)
text(pcl1)

# measure accuracy -rpart
pred2 <- predict(pcl1, test, type = "class")
confusionMatrix(pred2, test$Species)

# Method 3) party
partymod <- ctree(Species~., data = train)
plot(partymod)
partymod

# measuring accuracy(party)
partypred <- predict(partymod, test)
confusionMatrix(partypred, test$Species)


# 3차시: 랜덤포레스트 -------------------------------------------------------------
install.packages("randomForest")
library(randomForest)
library(caret)

setwd("C:/Users/goong/OneDrive - postech.ac.kr/바탕 화면/Postech/학교, 학사/1학년 1학기/데이터 분석을 위한 R프로그래밍/wk11")

iris <- read.csv("iris.csv", stringsAsFactors = TRUE)
attach(iris)

set.seed(1000)
N <- nrow(iris)
tr.idx <- sample(1:N, size = N*2/3, replace = F)

train <- iris[tr.idx,]
test <- iris[-tr.idx,]

# Random Forest : mtry = 2(default = sqrt(p))

rf_out1 <- randomForest(Species~.,data = train, importance = T)
rf_out1

# Random Forest : mtry = 4
rf_out2 <- randomForest(Species~., data = train, importance = T, mtry = 4)

# 앞선 mtry=2일 때와 비교해보면, 결과값이 동일하게 나오는 것을 알 수 있음.

# important variable for RF
round(importance(rf_out2),2)
# Gini index를 가장 많이 감소시킨 순으로 결과가 나온 것.
# petal.width가 가장 많이 감소시켰으니까, 가장 중요한 변수

# graph
randomForest::importance(rf_out2)
varImpPlot(rf_out2)

# measuring accuracy(rf)
rfpred <- predict(rf_out2, test)
confusionMatrix(rfpred, test$Species)
