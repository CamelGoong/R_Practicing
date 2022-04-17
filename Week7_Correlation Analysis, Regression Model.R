## 1차시: 상관분석

# Correlation coefficient
library(dplyr)

getwd()
setwd("C:/Users/goong/OneDrive - postech.ac.kr/바탕 화면/Postech/학교, 학사/1학년 1학기/데이터 분석을 위한 R프로그래밍/wk7")

car <- read.csv("autompg.csv")
head(car)

car1 <- filter(car, cyl == 4 | cyl == 6 | cyl == 8)
head(car1)
attach(car1)

# correlation
cor(wt, mpg) # 차의 무게
cor(disp, mpg) # 배기량
cor(accler, mpg)

# 상관계수와 산점도
# 상관계수: 두 변수 간의 선형적인 강도

# pairwise plot
vars1 <- c("disp", "wt", "accler", "mpg")
#pairwise plot
pairs(car1[vars1], main = "Autompg", cex = 1, col = as.integer(car1$cyl), pch = substring((car1$cyl),1,1) ) # cex: 산점도에서 점의 크기

car1$cyl
substring((car1$cyl),1,4)

# 통계치와 그래프 : 주의!!
# monkey data
monkey <- read.csv("monkey.csv")
head(monkey)
dim(monkey)
attach(monkey)

cor(height, weight) # 0.53으로 상관관계가 아주 높지는 않음.

# scatterplot for weight and height
par(mfrow = c(1,1))
plot(height,weight, pch = 16, col = 3, main = "Monkey data")

# add the best fit linear line
abline(lm(weight~height), col = "red", lwd = 2, lty = 1)

# Monkey + kingkong data
monkey1 <- read.csv("monkey_k.csv")
head(monkey1)
dim(monkey1)
attach(monkey1)

# correlation coefficients
cor(height, weight)
plot(height, weight, pch = 16, col = 3, main = "Monkey + kingkong data")
abline(lm(weight~height), col = "red", lwd = 2, lty = 1)
# 한 마리의 킹콩 데이터가 몸무게와 신장의 상관관계에 대한 해석을 완전히 바궈놓을 수 있다.

# linear model and summary of linear model
m1 <- lm(monkey$weight~monkey$height)
m1
summary(m1)

# linear model and summary of linear model
m2 <- lm(monkey1$weight~monkey1$height)
summary(m2)

## 2차시: 선형회귀모형
# 선형회귀모형의 목적은 '예측'

# Regression
library(dplyr)

getwd()

car <- read.csv("autompg.csv")
head(car)
str(car)

# subset with cyl = 4, 6, 8
detach(monkey)
car1 <- filter(car, cyl == 4 | cyl == 6 | cyl == 8)
attach(car1)
table(cyl)

# 회귀분석 - 단순회귀모형: '독립변수'가 1개인 모형 / lm(y변수~x변수, data = )
# 1. simple Regression
r1 <- lm(mpg~wt, data = car1)
summary(r1)
anova(r1)

# 산점도에 회귀선 그리기
# scatterplot with best fit lines
par(mfrow = c(1,1))
plot(wt, mpg, col = as.integer(car1$cyl), pch = 19)
# best fit linear line
abline(lm(mpg~wt), col = "red", lwd = 2, lty = 1)

# 2. simple Regression(independent variable : disp(배기량))
r2 <- lm(mpg~disp, data = car1)
summary(r2)
anova(r2)

# pairwise scatterplot
# 각각의 변수들이 어떤 관계가 있는지 그래프를 통해서 검토.
# new variable lists
vars1 <- c("disp", "wt", "accler", "mpg")
# pairwise plot
pairs(car[vars1], main = "Autompg", cex = 1, col = as.integer(car1$cyl), pch = substring((car1$cyl), 1, 1))

## 3차시: 회귀분석의 진단과 평가
library(dplyr)
library(ggplot2)

getwd()

# subset of flight data in SFO (n = 2974)
# dest = "SFO", origin == "JFK", arr_delay < 420, arr_delay > 0
SF<-read.csv("SF_2974.csv",stringsAsFactors = TRUE)
head(SF)
str(SF)

# 기술통계치 확인
summary(SF)

# 데이터 시각화: 항공사별 출발시간
attach(SF)
# ggplot2 이용해서 boxplot 그르기
ggplot(SF, aes(x = carrier, y = hour)) + geom_boxplot(aes(fill = carrier))
# B6는 늦게 출발하는 비행기가 있다...

# 데이터 시각화: 상관관계(출발지연시간, 도착지연시간)
ggplot(SF, aes(arr_delay, dep_delay, color = carrier)) + geom_point() # 항공사별로 어떻게 되나 색깔로 표시

# Visualization using dplyr: Histogram
SF %>% ggplot(aes(arr_delay)) + geom_histogram(binwidth = 15)

# 분포함수 추정(Density Function)
# Visualization using dplyr : Density Graph
SF %>%
  ggplot(aes(arr_delay)) + geom_density(fill = "pink", binwidth = 15)

# 2. 상자그림
# x변수: hour(출발시각) y변수: arr_delay(도착지연시간)
# Visualization using dplyr : Box-Plot by departing time
SF %>%
  ggplot(aes(x = hour, y = arr_delay)) +
  geom_boxplot(alpha = 0.1, aes(group = hour)) + # boxplot을 출발시간(hour)에 따라서 그림.
  geom_smooth(method = "lm") +
  xlab("Scheduled hour of departure") + ylab("Arrival delay (minutes)") +
  coord_cartesian(ylim = c(0,120))

# 단순회귀모형: lm
# 종속변수: arr_delay, 독립변수: hour
# linear regression
m1 <- lm(arr_delay~hour, data = SF)
summary(m1) # 1시간 늦게 출발하면 2.55분이 지연된다고 생각하면 됨. # 결정계수가 약 4% 정도만 설명할 수 있는 것.
anova(m1)

# 산점도에 회귀선 그리기
# scatterplot with best fit lines / 즉, ggplot을 이용하지 않고, 기본 함수로 그리는 것.
par(mfrow = c(1,1))
plot(SF$hour, SF$arr_delay, col=as.integer(SF$carrier), pch=19, xlab="hour",ylab="delay") 

as.integer(SF$carrier)

# best fit linear line
abline(lm(SF$arr_delay~SF$hour), col = "red", lwd = 2, lty = 1)

class(SF$carrier)
as.integer(SF$carrier)
