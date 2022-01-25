# 05-1 dplyr 패키지

## dyplyr 패키지 설치 및 로드하기

library("dplyr") # 패키지 로드
data(mtcars) # 데이터 로드드
nrow(mtcars) # 32개의 행 관측치
str(mtcars) # 데이터 구조 확인

## 데이터 추출 및 정렬하기
mtcars
### 행 추출하기: filter(데이터, 조건문)함수
filter(mtcars, cyl == 4) # 실린더 갯수가 4기통인 자동차만 추출
filter(mtcars, cyl >=6 & mpg > 20) # 6기통 이상, 연비 20초과 추출

### 열 추출하기: select(데이터, 변수명1, 변수명2 ...)함수
select(mtcars, am, gear) # 구분과 기어 데이터열만 추출

###  오름차순 정렬하기: arrange(데이터, 변수명1, 변수명2 ...)
arrange(mtcars, wt) # mtcars 데이터에서 wt를 기준으로 오름차순 정렬
head(arrange(mtcars, wt)) # head 확인

head(arrange(mtcars, mpg, desc(wt))) # 기준1: mpg, 기준2: wt 내림차순

## 데이터 추가 및 중복 데이터 제거하기
### 열 추가하기: mutate(데이터, 추가할 변수 이름 = 조건1, ...)함수
mutate(mtcars, years = "1974") # mtcars라는 데이터 세트에 생산일자 열(year)을 추가 / 일괄적으로 모두 1974 입력
head(mutate(mtcars, mpg_rank = rank(mpg))) # 새로운 열인 mpg_rank에 mpg열의 rank를 구하여 추가

### 중복값 제거하기: distinct(데이터, 변수명)함수
distinct(mtcars, cyl) # mtcars 데이터 세트에서 cyl 열에서 중복값 제거
distinct(mtcars, gear) # gear 열에서 중복값 제거
distinct(mtcars, cyl, gear) # 두 열을 동시에 지정 / 이때는 각 열에서 중복값이 제거되는 것이 아니라, 지정한 두 열의 모든 값이 동일할 때만 제거

## 데이터 요약 및 샘플 추출하기
### 데이터 전체 요약하기: summarise(데이터, 요약할 변수명 = 기술통계 함수)함수
summarise(mtcars, cyl_mean = mean(cyl), cyl_min = min(cyl), cyl_max = max(cyl))

### 그룹별로 요약하기: groupby(데이터, 변수명)함수
gr_cyl <- group_by(mtcars, cyl) # cyl을 기준으로 groupby
View(gr_cyl) 
summarise(gr_cyl, n()) # 위의 cyl 기준으로 groupby했던 것을 기술통계함수인 n()을 가지고 요약

summarise(gr_cyl, n_distinct(gear)) # gear열의 중복값을 제외하고 개수를 파악

### 샘플 추출하기: sample_n(데이터, 샘플 추출할 개수), sample_frac(데이터, 샘플 추출할 비율)
sample_n(mtcars, 10)
sample_frac(mtcars, 0.2)


## 파이프 연산자: %>% / 데이터 세트 %>% 조건 또는 계산 %>% 데이터 세트 / 앞의 groupby를 적용할 때, 변수에 저장하는 과정을 생략가능
group_by(mtcars, cyl) %>% summarise(n())

mp_rank <- mutate(mtcars, mpg_rank = rank(mpg)) # 파이프 연산자없이 순위 기준으로 정렬하기
arrange(mp_rank, mpg_rank) # 이렇게 변수 할당 과정을 포함해서, 두번의 연속된 과정을 거쳐야 함

mutate(mtcars, mpg_rank = rank(mpg)) %>% arrange(mpg_rank)

# 05-2 데이터 가공하기
## 필요한 데이터 추출하기
library(readxl)
exdata1 <- read_xlsx("C:/Users/goong/Desktop/R_practicing/Data_Analysis_practicing/data/Sample1.xlsx")
exdata1

### 추출방법 1) 선택한 변수만 추출
exdata1 %>% select(ID) # exdata1에서 ID열만 추출
exdata1 %>% select(ID, AREA, Y21_CNT)
exdata1 %>% select(-AREA) # -AREA: AREA열만 제외하고 추출
exdata1 %>% select(-AREA, -Y21_CNT) # 두 열만 제외하고 추출

### 추출방법 2) 필요한 데이터만 추출
exdata1 %>% filter(AREA == "서울")
exdata1 %>% filter(AREA == "서울" & Y21_CNT >= 10)

## 데이터 정렬하기
exdata1 %>% arrange(AGE) # arrange()의 기본값은 오름차순
exdata1 %>% arrange(desc(Y21_AMT)) # 내림차순 정렬
exdata1 %>% arrange(AGE, desc(Y21_AMT)) # 중첩 정렬

## 데이터 요약하기
exdata1 %>% summarise(TOT_Y21_AMT = sum(Y21_AMT)) # 21년이용금액인 Y21_AMT 변수값을 모두 합산

### 그룹별 합계 도출하기
exdata1 %>% group_by(AREA) %>% summarise(SUM_Y21_AMT = sum(Y21_AMT))

## 데이터 결합하기
### 1) 세로 결합: bind_rows(테이블명, 테이블명)
library('readxl')
m_history <- read_excel("C:/Users/goong/Desktop/R_practicing/Data_Analysis_practicing/data/Sample2_m_history.xlsx")
f_history <- read_excel("C:/Users/goong/Desktop/R_practicing/Data_Analysis_practicing/data/Sample3_f_history.xlsx")
View(m_history)
View(f_history)

exdata_bindjoin <- bind_rows(m_history, f_history)
exdata_bindjoin

## 2) 가로 결합: left_join(테이블1, 테이블2, by ="변수명"), inner_join(테이블1, 테이블2, by ="변수명"), full_join(테이블1, 테이블2, by ="변수명")
library(readxl)
jeju_y21_history <- read_excel("C:/Users/goong/Desktop/R_practicing/Data_Analysis_practicing/data/Sample4_y21_history.xlsx")
jeju_y20_history <- read_excel("C:/Users/goong/Desktop/R_practicing/Data_Analysis_practicing/data/Sample5_y20_history.xlsx")
View(jeju_y21_history)
View(jeju_y20_history)

### left_join: 왼쪽 테이블과 키 변수를 기준으로 두 번째 테이블에 있는 나머지 변수들을 결합
left_join_col <- left_join(jeju_y21_history, jeju_y20_history, by = "ID")
left_join_col

### inner_join: 두 테이블의 키 변수가 동일한 것만 결합(교집합)
inner_join_col <- inner_join(jeju_y21_history, jeju_y20_history, by = "ID")
inner_join_col

### full_join: ID 기준으로 모든 데이터가 결합(합집합)
full_join_col <- full_join(jeju_y21_history, jeju_y20_history, by = "ID")
full_join_col


# 05-3 데이터 구조 변형하기
## 넓은 모양 데이터를 긴 모양으로 바꾸기: melt(데이터, id.var = "기준 열", measure.vars = "변환 열")
## 넓은 모양 데이터는 행 < 열이 많아 가로로 긴 모양의 행렬. 이를 아이스크림이 녹듯이 열 -> 행으로 바꾸어 세로로 길게 바꿀때 사용.
install.packages("reshape2") # 패키지 다운로드
library("reshape2")
head(airquality)
names(airquality) <- tolower(names(airquality))
head(airquality)

melt_test <- melt(airquality) # melt() 테스트 해보기
head(melt_test)
tail(melt_test)
View(melt_test)

melt(airquality, id.vars = c("month", "wind"), measure.vars = c("ozone"))
