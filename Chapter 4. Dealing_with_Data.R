# 04-1 데이터 수집하기

## 직접 데이터 입력하기
ID <- c(1,2,3,4,5)
ID
SEX <- c("F", "M", "F", "M", "F")
SEX

DATA <- data.frame(ID = ID, SEX = SEX)
View(DATA) # 데이터 조회

## 외부 데이터 가져오기: TXT 파일
ex_data <- read.table("C:/Users/goong/Desktop/R_practicing/Data_Analysis_practicing/data/data_ex.txt",
                      encoding = "EUC-KR", fileEncoding = "UTF-8")
View(ex_data)

### header 옵션: 원 데이터의 첫행을 변수명으로 설정할 것인지의 여부
ex_data1 <- read.table("C:/Users/goong/Desktop/R_practicing/Data_Analysis_practicing/data/data_ex.txt",
                       encoding = "EUC-KR", fileEncoding = "UTF-8", header = TRUE)
View(ex_data1)

### col.names 옵션: column명 설정
varname <- c("ID", "SEX", "AGE", "AREA") # varname으로 col.names를 미리 정의.
ex1_data <- read.table("C:/Users/goong/Desktop/R_practicing/Data_Analysis_practicing/data/data_ex_col.txt",
                       encoding = "EUC-KR", fileEncoding = "UTF-8", col.names = varname)
View(ex1_data)

### skip 옵션: 몇행 이후로부터 가져올지
ex_data2 <- read.table("C:/Users/goong/Desktop/R_practicing/Data_Analysis_practicing/data/data_ex.txt",
                      encoding = "EUC-KR", fileEncoding = "UTF-8", header = TRUE, skip = 2)
View(ex_data2)

### nrows 옵션: 몇개의 행을 가져올지
ex_data3 <- read.table("C:/Users/goong/Desktop/R_practicing/Data_Analysis_practicing/data/data_ex.txt",
                       encoding = "EUC-KR", fileEncoding = "UTF-8", header = TRUE, nrows = 7)
View(ex_data3)

### sep 옵션
ex_data4 <- read.table("C:/Users/goong/Desktop/R_practicing/Data_Analysis_practicing/data/data_ex1.txt",
                       encoding = "EUC-KR", fileEncoding = "UTF-8",
                       header = TRUE, sep = ",")
View(ex_data4)

## 외부 데이터 가져오기: CSV 파일
ex_data <- read.csv("C:/Users/goong/Desktop/R_practicing/Data_Analysis_practicing/data/data_ex.csv")
View(ex_data) # csv파일은 옵션을 따로 설정하지 않아도 원시 데이터의 1행을 변수명으로 가져옴.

## 외부 데이터 가져오기: 엑셀 파일
install.packages('readxl') # readxl 패키지 설치 및 로드
library(readxl)

excel_data_ex <- read_excel("C:/Users/goong/Desktop/R_practicing/Data_Analysis_practicing/data/data_ex.xlsx")
View(excel_data_ex)

## 외부 데이터 가져오기: XML, JSON 파일
install.packages("XML") # XMP 패키지 설치 및 로드
library("XML")
xml_data <- xmlToDataFrame("C:/Users/goong/Desktop/R_practicing/Data_Analysis_practicing/data/data_ex.xml")
View(xml_data) # xml파일 같은 경우는 태그명이 변수명이 됨.

install.packages("jsonlite") # jsonlite 패키지 설치 및 로드
library("jsonlite") 
json_data <- fromJSON("C:/Users/goong/Desktop/R_practicing/Data_Analysis_practicing/data/data_ex.json")
str(json_data)

# 04-2 데이터 관측하기

## 데이터 전체 확인하기
data() # R에서 기본 제공하는 내장 데이터 세트
data("iris") # iris  데이터 세트 가져오기기
iris

## 데이터 요약 확인하기
str(iris)
ncol(iris) # 컬럼수
nrow(iris) # 행수
dim(iris) # 행열수

length(iris) # 열의 개수
length(iris$Sepal.Length) # Sepal.length열의 데이터 갯수수

ls(iris) # 데이터 세트 컬럼명

head(iris, n = 3) # n 기본값은 6개
tail(iris)


## 기술통계량 확인하기
mean(iris$Sepal.Length)
median(iris$Sepal.Length)
min(iris$Sepal.Length)
max(iris$Sepal.Length)
range(iris$Sepal.Length)

### 분위수
quantile(iris$Sepal.Length) # 사분위수 모두 출력
quantile(iris$Sepal.Length, probs = 0.25) # 제1사분위수
var(iris$Sepal.Length) # 분산
sd(iris$Sepal.Length) # 표준편차

### 첨도와 왜도
install.packages("psych") # psych 패키지 설치 및 로드
library("psych")

kurtosi(iris$Sepal.Length) # 첨도
skew(iris$Sepal.Length) # 왜도


## 데이터 빈도분석하기
install.packages("descr") # descr 패키지 설치 및 로드하기
library("descr")

freq_test <- freq(iris$Sepal.Length, plot = FALSE)
freq_test

# 04-3 데이터 탐색하기
exdata1 <- read_excel("C:/Users/goong/Desktop/R_practicing/Data_Analysis_practicing/data/Sample1.xlsx")
exdata1

## 1) 막대그래프
freq(exdata1$SEX, plot = T, main = '성별(barplot)') # main은 그래프 제목

## 2) barplot : 별도의 패키지를 설치하지 않아도 그릴 수 있으나,
##              빈도 분포를 구하는 기능이 없기 때문에 table()함수를 함께 사용.
dist_sex <- table(exdata1$SEX) # 먼저 빈도 분포를 구하고
barplot(dist_sex) # 이를 다시 대입해서, barplot을 구함.

barplot(dist_sex, ylim = c(0, 12), main = "BARPLOT",
        xlab = "SEX", ylab = "FREQUENCY",
        names = c("Female", "Male"),
        col = c("pink", "navy"))

## 3) boxplot: 데이터의 분포를 비교하거나 이상치를 판단할 때 사용.
boxplot(exdata1$Y21_CNT, exdata1$Y21O_CNT,
        ylim = c(0, 60),
        main = "BOXPLOT",
        names = c("21년 건수", "20년 건수"),
        col = c("green", "yellow"))

## 4) 히스토그램: 연속형 데이터를 일정하게 나눈 구간(계급)을 가로 축으로,
##    각 구간에 해당하는 데이터 수(도수)를 세로 축으로 그린 그래프
hist(exdata1$AGE,
     xlim = c(0,60),
     ylim = c(0, 7),
     main = "AGE 분포")

## 5) 파이차트 그리기
data(mtcars)
x <- table(mtcars$gear) # pie()함수는 빈도분석 기능이 없으므로, table()함수로 gear열에 대해서 빈도분석을 선행
x
pie(x)

## 6) 줄기 잎 그림 그리기
x <- c(1,2,3,4,7,8,8,5,9,6,9)
x
stem(x)
stem(x, scale = 2)
stem(x, scale = 0.5)

## 7) 산점도 그리기

### 산점도 그리기
data(iris)
iris
plot(iris$Sepal.Length, iris$Petal.Width)

### 산점도 행렬 그리기
pairs(iris)

### psych패키지로 산점도 행렬 그리기
install.packages("psych")
library("psych")
pairs.panels(iris)

# 확인문제
y1 <- c(10, 15, 20, 30, 40, 50, 55, 66, 77, 80, 90, 100, 200, 225)
boxplot(y1)

stem(y1)

plot(y1)
