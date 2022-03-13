# 3-1 R 데이터 생성

# 1. Read csv file : brain weight data
brain <- read.csv("C:/Users/goong/OneDrive - postech.ac.kr/바탕 화면/Postech/학교, 학사/1학년 1학기/데이터 분석을 위한 R프로그래밍/wk3/brain2210.csv")
# 위의 파일이 불러들이는게 안될 때는 경로에서 \를 모두 /로 바꿔주면 됨.
head(brain)
dim(brain)

# 데이터 불러들이기에서 가장 오류가 많이 나는 것은 불러들이는 경로와 일치하지 않는것

# 현재 프로그램 작업폴더(setwd): 작업폴더를 지정하고
setwd("C:/Users/goong/OneDrive - postech.ac.kr/바탕 화면/Postech/학교, 학사/1학년 1학기/데이터 분석을 위한 R프로그래밍/wk3")

# 지금 current working dircetory 확인하기
getwd()

# 이렇게 setwd를 해준 상태에서 1. Read Csv file
brain <- read.csv('brain2210.csv')
head(brain)
dim(brain)

# 위같이 setwd를 먼저 해주면,처음에 했던 것처럼 긴 경로를 다 치지 않아도 불러들일 수가 있다!!

# 2. example for using 'attach' : 앞으로 brain라는 데이터에서 변수명들을 사용할 것이다라고 알려주는 것.
# 따라서 brain$sex라고 해야될 것을 그냥 sex라고 해도됨.
# table: 범주형 변수에서 frequency(빈도)를 구하는 것.

table(brain$sex)

attach(brain)

table(sex)

hist(wt)

# brain이라는 데이터를 다 사용했다라고 할 때는 attach의 반대인 detach를 해주면 됨.
detach(brain)

# 여러 형태의 데이터 불러들이기
# 통합 Excel 파일(여러 worksheet가 있을 때: readxl 패키지 설치)
install.packages("readxl")
library(readxl)

getwd()

mtcars1 <- read_excel('mtcarsb.xlsx',
                      sheet = 'mtcars')
# 이런 식으로 한 엑셀파일 내에서도 여러 sheet가 있을 때, 원하는 sheet를 가져올 수 있음
# 이 코드 실행시에 invalid multibyte string error가 떠서, Sys.setlocale(category = "LC_ALL", locale = "us") 를 Console창에 입력해서 해결

# sheet 옵션에 위처럼 이름을 써도 되고 sheet = 1, sheet = 2 이런식으로도 불러들일 수 있음.

# 3-2 R 데이터 활용 1 (subset, 내보내기)
# 원래 있는 데이터에 조건을 줘서 뽑아내는 것.

attach(brain)

# 예제1: brain 데이터에서 female만 있는 subset 데이터 생성
brainf <- subset(brain, sex == 'f') # 조건 쓸 때, 등호 == 2개임..!
head(brainf)
mean(brainf$wt) # 여자의 뇌의 무게 평균

# 예제2: brain 데이터에서 male만 있는 subset 데이터 생성
brainm <- subset(brain, sex == 'm')
head(brainm)
mean(brainm$wt)
sd(brainm$wt) # 표준편차는 std가 아니고 sd

# 추출한 데이터의 활용(그룹별 히스토그램)
# histogram with same scale
# 그냥 그려버리면, scale이 다르게 나옴.
hist(brainf$wt, breaks = 12, col = "green", cex = 0.7, main = "Histogram")
hist(brainm$wt, breaks = 12, col = "orange", main = "Histogram")

# ces: 점의크기 라고 나옴.
# breaks: 구간을 몇개로 나눌 것인지

# 예제3: brain 데이터에서 wt < 1300이하인 데이텉 생성
brain1300 <- subset(brain, wt<1300)
head(brain1300)
summary(brain1300) # 요약통계량 구하기

# 지금 summary 결과를 보면 sex는 character(문자) 유형이라서 전체 데이터의 갯수가 138개인 것만 확인할 수 있음.
# 그러나, 각각 f, m의 빈도를 알기 위해서는 범주형 데이터의 frequency를 알려주는 table()을 사용하면 됨.
table(brain1300$sex)

hist(brain1300$wt, breaks = 12, col = 'lightblue', main = "Histogram")

# 데이터 내보내기 (csv로 내보내기) : write.table, write.csv

# 방법 1) write.csv
write.csv(brainf, file = "brainf.csv", row.names = FALSE)

# 방법 2) write.table
write.table(brainf, file = "brainf.csv", row.names = FALSE, sep = ",", na = " ")

# 방법 3) txt로 내보내기 : write.table
write.table(brainm, file = "brainm.txt", row.names = FALSE, na = " ")
# 이 경우는 따로 sep를 지정해주지 않아도 되는듯.

# 3-3 R 데이터 활용 2 (dplyr 활용)
# 데이터핸들링
# dplyr: 데이터 핸들링을 편리하게 하는 라이브러리
# select : 일부 변수를 선택
# filter: 필터링 기능(subset과 같은 기능)
# mutate: 새로운 변수 생성
# group_by
# summarize
# arrange: 행 정렬시 사용

install.packages('dplyr')
library('dplyr')

car <- read.csv(file = "autompg.csv")
attach(car)

# 1. mpg: mile per gallon (연비: 연속형 변수)
head(car)
dim(car)
str(car) # 데이터의 변수들이 어떻게 정의되어있는지를 보여줌

# 데이터 요약하기
summary(car)


# 데이터의 요약 통계치(빈도 구하기)
table(origin)
table(year)

# 평균, 표준편차 구하기
mean(mpg)
mean(hp)
mean(wt)

# select: 데이터 추출
set1 <- select(car, mpg, hp) # car이라는 data에서 mpg, hp의 변수만 select해오는 것.
head(set1)

# starts_with(): 특정 것으로 시작하는 변수 가져오기
set2 <- select(car, -starts_with("mpg")) # -를 붙였으니까, 변수들 중에서 mpg로 시작하는 것 제외하고 가져오기기
head(set2)

# filter: 조건식에 맞는 데이터 추출
set3 <- filter(car, mpg > 30) # mpg가 30보다 큰 데이터만 가져오기
head(set3)

# mutate: 기존 변수를 활용해서 새로운 변수를 생성 + %>%  (ctrl + shift + m)
set4 <- car %>%
  filter(!is.na(mpg)) %>% # 일단 mpg에서 na가 아닌 것들 필터링  
  mutate(mpg_km = mpg*1.609) # 새로운 변수 mpg_km을 만드는데, 기존의 mpg * 1.609

head(set4)

# 데이터 요약 통계치(평균 구하기): summarize(mean(변수))
car %>% 
  summarize(mean(mpg), mean(hp), mean(wt))

select(car, 1:6) %>% # 첫번째에서 여섯번째까지의 변수를 가져오고
  colMeans() # 그 변수들의 평균을 구하기(열로 재구성하여 평균값 구하기)

# 벡터화 요약치: summarize_all( )
a1 <- select(car, 1:6) %>% summarize_all(mean) # 모든 평균 요약
a2 <- select(car, 1:6) %>% summarize_all(sd)
a3 <- select(car, 1:6) %>% summarize_all(min)
a4 <- select(car, 1:6) %>% summarize_all(max)

# 위의 기술 통계치들을 모두 묶어서 하나의 테이블로 만들기
table1 <- rbind(a1, a2, a3, a4)
table1

# 행이름 설정
rownames(table1) <- c("mean", "sd", "min", "max")
table1

# 그룹별 기술통계치: group_by
car %>%
  group_by(cyl) %>% 
  summarize(mean_mpg = mean(mpg, na.rm = TRUE)) # 요약통계량으로 mpg의 mean을 구할 것이고, 계산하는 과정에서 결측치들은 포함하지 않음
# 위처럼 group_by와 summarize는 함께 사용하는 경우가 많음.
# 주의!! summary가 아니고, "summarize"임.