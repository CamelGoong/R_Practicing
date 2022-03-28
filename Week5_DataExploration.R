## 데이터 다루기(결합, 분할)
install.packages("dplyr")
library("dplyr")

getwd()
setwd("C:/Users/goong/OneDrive - postech.ac.kr/바탕 화면/Postech/학교, 학사/1학년 1학기/데이터 분석을 위한 R프로그래밍/wk5")
getwd()

## 데이터 결합방법 1) merge(data1, data2, by = "ID")
## 데이터 결합방법 2) inner_join(data1, data2, by = "ID")
data1 <- read.csv(file = "data1.csv")
data2 <- read.csv(file = "data2.csv")

# data merging
data12 = inner_join(data1, data2, by = "ID")
head(data12)

# 데이터 결합방법 3) rbind(data3, data4) ,columns은 똑같은데 관측치를 여러개 합하는 것.
data3 <- read.csv(file = "data3.csv")
data123 <- rbind(data12, data3)
head(data123)

# 데이터 정렬: arrange(데이터이름. 변수1, 변수2) / 변수는 자신의 의향에 따라서 다수를 지정 가능.
dats1 <- arrange(data12, age)
dats1
dats2 <- arrange(data12, gender, age) # 먼저 gender로 정렬을 한 다음에, 그 안에서 age 정렬
dats2

# 데이터 추출: filter(데이터이름, 조건1 & 조건2): 어떤 데이터에 조건을 걸어서, 조건에 맞는 데이터만 추출.

newsdat <- filter(data12, data12$gender == "F" & data12$age > 15)
newsdat

newsdat <- subset(data12, data12$gender == "F" & data12$age > 15) # 동일한 결과를 subset을 통해서 얻고 싶을 때.
newsdat

# 데이터에서 일부 변수 제거하기: select[데이터이름, -c("변수1", "변수2")]
exdat <- select(data12, -c("age", "gender"))
exdat

## 데이터탐색과 기술통계치
library(dplyr)
stud <- read.csv("stud_math.csv")
head(stud)
dim(stud) # 관측치 395개 변수 33개
str(stud)

# 데이터 기술통계치 요약
# character variable to factor : 데이터를 읽을 때, stringAsFactors = TRUE로 불러오면, string 변수들을 factor(범주형 변수)
# 로 읽어올 수 있어서, 후에 summary를 통해서 볼 때, 더 많은 정보를 얻을 수 있음.
stud <- read.csv("stud_math.csv", stringsAsFactors = TRUE)
str(stud) # string -> factor 번수로 바뀐 것을 확인할 수 있음.

# summary(데이터 이름): 각 변수별로 요약통계량을 제공
summary(stud) # 범주형 변수에 대해서도 빈도를 얻을 수 있게 됨.

attach(stud)

mean(G3)
sd(G3)
sqrt(var(G3))

# 요약통계량을 얻고 싶은 특정 변수들을 선택
a1 <- select(stud, c("G1", "G2", "G3")) %>% summarize_all(mean)
a2 <- select(stud, c("G1", "G2", "G3")) %>% summarize_all(sd)
a3 <- select(stud, c("G1", "G2", "G3")) %>% summarize_all(min)                                                          
a4 <- select(stud, c("G1", "G2", "G3")) %>% summarize_all(max)

table1 <- rbind(a1, a2, a3, a4)
rownames(table1) <- c("mean", "sd", "min", "max") # 각 요약통계량들을 한군데에 합치기
table1

# 범주형 변수의 요약 : table(변수이름)
table(health) # 범주형 변수의 빈도 구하기
health_freq <- table(health)
health_freq
names(health_freq) <- c("very bad", "bad", "average", "good", "very good") # 열이름 바꾸기
barplot(health_freq, col = 3)
