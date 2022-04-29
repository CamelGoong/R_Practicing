# 1차시: 다중회귀분석 -------------------------------------------------------------
getwd()
setwd("C:/Users/goong/OneDrive - postech.ac.kr/바탕 화면/Postech/학교, 학사/1학년 1학기/데이터 분석을 위한 R프로그래밍/wk8")
car <- read.csv("autompg.csv")
head(car)
str(car)
attach(car)

# 다중회귀분석
# method 1 ) 전체변수를 모두 포함한 회귀모형
r1 <- lm(mpg~disp+hp+wt+accler, data = car)
summary(r1)
# 결과를 보았을 때, p-value가 가장 낮은 것이 위 모형에서 가장 유의미한 변수라고 해석할 수 있음.
# 결정계수 70% / 이 4개의 변수들이 mpg(연비)를 70% 정도 설명을 한다.
# 마력(hp)이 높을수록 우리는 일반적으로 연비가 낮다고 알고있는데, 현재의 경우는 플러스가 나옴. 우리는 이를 통해서 어?? 다르게 봐야하는 것이 아닌가 하는 생각을 해봐야 함.
# 그래서 이를 살펴보기 위해서 우리는 pairwise scatterplot을 그려서 hp와 mpg의 관계를 볼 수 있음.
# 따라서, 이 데이터에 대해서 우리가 적합한 회귀모형을 만든다고 하면, hp를 50정도에서 나누어서
# 모형을 2개로 나누어서 만들거나, 여러 방법을 고려해볼 필요성이 잇음.

# 다중회귀분석 - 변수선택방법
# method 2 ) 단계별 방법(stepwise)

s1 <- step(r1, direction = "both")
summary(s1)

# final multiple regression
r2<-lm(mpg ~ disp+wt+accler, data=car)
summary(r2)

# 결과적으로 처음의 다중회귀모형에서 'hp'가 제3거된 것을 확인할 수 있음.
# 그러나, 결정계수(R^2)는 앞과 비슷하게 70%를 유지하고 있음.

# 다중회귀분석 - 탐색과 진단
# 다중공선성: 독릴변수들 사이에 상관관계가 높아서, 회귀계수가 굉장히 불안정해지는 문제점
# 독립변수들간의 상관계수
var2 <- c("disp", "hp", "wt", "accler")
car[var2]
cor(car[var2])
# wt와 disp가 조금 높게 나타나고, 나머지 변수들은 그런 관계를 보이지 않음.

# 분산팽창계수
# 분산을 inflation시키는 척도로 다중공선성의 척도로 사용함.
# 실제 데이터는 VIFj가 10보다 훨씬 커야 다중공선성이 나타나는 경우가 많음.
# 실제로 다중공선성이 있다면, ridge regression이라는 penalty를 주거나, 주성분회귀를 사용함.

# VIF는 car라는 library가 필요
install.packages("car")
library(car)
vif(lm(mpg~disp+hp+wt+accler, data = car)) # 회귀모형을 안에 입력
# 분산팽창계수(vif)의 결과를 보면 disp와 wt가 10에 가깝기는 하지만, 문제가 없다고 볼 수 있음.
# 따라서 여기서는 앞에서 stepwise method를 통해서, 선별한 변수들로 구성된 선형회귀식이 최종모형으로 생각하면 됨.
# 그리고 한번더, 잔차의 산점도에 대한 진단을 통해서 체크해보는 것을 추천.
layout(matrix(c(1,2,3,4), 2, 2))
plot(r2)



# 3차시: 학습데이터와 검증데이터 -------------------------------------------------------
iris <- read.csv(file = 'iris.csv')
head(iris)
str(iris)
attach(iris)

# training / test data : n = 150
set.seed(1000)
n <- nrow(iris)
tr.idx <- sample.int(n, size = n*2/3, replace = F)
# check # of training set
length(tr.idx)
tr.idx

# attributes in training and test
iris.train <- iris[tr.idx, -5]
iris.test <- iris[-tr.idx, -5]

# 타겟 변수 형성
trainLabels <- iris[tr.idx, 5]
testLabels <- iris[-tr.idx, 5]
