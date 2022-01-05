
# Basic -------------------------------------------------------------------

install.packages("tidyverse")
install.packages("mosaicData")
install.packages("gcookbook")

library(tidyverse)
library(mosaicData)
library(gcookbook)

1+2
1-2
2*2
2/2

2^2
2**2

5/2
5 %% 2
5 %/% 2


5 < 2
5 > 2
5 == 4
5 != 2

TRUE & FALSE
TRUE | FALSE


#값 할당하기

x <- 1
x
print(x)


#기본 데이터 타입: 문자, 숫자, 정수, 논리값 (+complex)

x <- "kim"
x
x <- 1.2
x



#data type coercing

as.integer
as.numeric
as.character



#기본 데이터 스트럭쳐: vector, list, matrix, factor, data frame (+tibble)

#vector
x <- 1:10
x <- c(1,2,3,4,100) # 벡터를 생성하는 명령
x
x+1
a <- 5:1
x+a

#list / 유형이 다른 데이터들도 같이 묶어줄 수 있음
x <- list(1, "A", TRUE, 1+4i)
x

#matrix 행렬렬
m <- matrix(1:6, nrow=2, ncol=3)
m

#factor: 정수 벡터에 라벨 붙은 것 / 불연속 값을 나타낼 때 주로 사용
x <- factor(c("yes", "no", "yes"), levels=c("yes","no"))
x

#data.frame / table 형태의 데이터 (row: case, column: variable)
x <- data.frame(foo=1:4, bar=c(T,T,F,F))
x

#tibble: data.frame의 개량판 / r 생태계에서 
x<- tibble(foo=1:4, bar=c(T,T,F,F))
view(x)




#subsetting / 인덱싱해서 요소 가져오는 것

a
a[1]
a[2]
a[1:2]
a[2:1]
a[c(2,4)]

Galton #내장되어 있는 데이터 (Mosaicdata 라이브러리 덕분에)
Galton[1] # 1열
Galton[2] # 2열
Galton[3,5] # 앞에꺼가 행, 뒤에꺼가 열 / 3행 5열열
Galton[1,]
Galton[,1]
Galton$family # $는 data.frame의 변수들을 부르는 것
Galton$height


#분포 지표

mean(Galton$height)
median(Galton$height)
var(Galton$height)
sd(Galton$height)

mean(x=Galton$height) # 이런식으로 쓰는 것이 정석적으로 코딩하는 방법




# simple plot -------------------------------------------------------------
# 재시작: ctrl + shift + F10
library(tidyverse)
library(mosaicData)
library(gcookbook)

BJsales
iris
Galton
data() # 지금 내가 부를 수 있는 dataset이 나옴

Galton <- Galton # global enviornment에 할당

summary(Galton) # 각 변수마다 요약
str(Galton)



#ggplot -> visualization tool / 공짜로 그림 그리는 라이브러리 중에 짱!!



##google search
##? / help



#histogram
?ggplot
ggplot(data = Galton, mapping = aes(x=height)) + geom_histogram() # data는 Galton, 그 안에서 x=height라는 변수를 불러와서 historam으로 표현할 거야
ggplot(Galton, aes(height)) + geom_histogram() # aes는 aesthetic, 미적으로 어떤 변수를 사용할 것인가
ggplot(Galton, aes(height)) + geom_histogram(bins = 20) # geom(기하학적인 구조로는) histogram을 사용할 것. bins 20개씩 끊자자
ggplot(Galton, aes(height)) + geom_histogram(bins = 20, color = "white") # color는 막대 경계선
ggplot(Galton, aes(height)) + geom_histogram(bins = 20, color = "white", fill = "steelblue")
ggplot(Galton, aes(height, fill = sex)) + geom_histogram(bins = 20, color = "red", alpha = .5) # 성별로 색깔을 다르게 한 것
ggplot(Galton, aes(height, fill = sex)) + geom_histogram(bins = 20, color = "red", alpha = .3, position = "identity") # position = "identity"는 겹쳐서 그리는 것 



#색깔? -> 구글에서 ggplot color 검색해서 보면 됨
#density plot -> histogram을 smoothing 한 것 (참조: https://darkpgmr.tistory.com/147)

ggplot(Galton, aes(height)) + geom_density()
ggplot(Galton, aes(height)) + geom_density(color = "blue")
ggplot(Galton, aes(height)) + geom_density(color = "grey", fill = "lightpink")
ggplot(Galton, aes(height)) + geom_density(color = "grey", fill = "lightpink", alpha = .5) # alpha는 투명도를 의미
ggplot(Galton, aes(height, fill = sex)) + geom_density(color = "grey", alpha = .3)


#mix / +에서 알 수 있듯이, 히스토그램이랑 density plot을 같이 쓸 수 있음.

ggplot(Galton, aes(x=height, y=..density..)) + geom_histogram(alpha = .3) + geom_density(alpha = .3)
ggplot(Galton, aes(x=height, y=..density.., fill=sex)) + geom_histogram(alpha = .3, position = "identity") + geom_density(alpha = .3)


#boxplot -> 분포를 시각화하는 대표적인 방법
?geom_boxplot
ggplot(Galton, aes(sex, height))+geom_boxplot()
ggplot(Galton, aes(sex, height))+geom_boxplot(width = .5)
ggplot(Galton, aes(sex, height))+geom_boxplot(width = .5, color = "purple")
ggplot(Galton, aes(1, height))+geom_boxplot(width = .5, color = "purple")
ggplot(Galton, aes(sex, height))+geom_boxplot(width = .5, color = "purple", notch = TRUE)



# other plot --------------------------------------------------------------

#bar plot

str(BOD) # BOD라는 내장 데이터

ggplot(BOD, aes(Time, demand)) + geom_col() # geom_col는 기둥 그래프프
ggplot(BOD, aes(as.factor(Time), demand)) + geom_col() # factor는 불연속적인 변수
ggplot(BOD, aes(as.factor(Time), demand)) + geom_col() + xlab("Time")
ggplot(BOD, aes(as.factor(Time), demand)) + geom_col() + xlab("Time") + ggtitle("uhahahaha")
ggplot(BOD, aes(as.factor(Time), demand)) + geom_col() + xlab("Time") + ggtitle("uhahahaha") + 
        theme_bw() + theme(plot.title = element_text(hjust=0.5))
ggplot(BOD, aes(as.factor(Time), demand)) + geom_col(fill = "lightblue") + xlab("Time") + ggtitle("uhahahaha") + 
        theme_bw() + theme(plot.title = element_text(hjust=0.5))
ggplot(BOD, aes(as.factor(Time), demand)) + geom_col(fill = "lightblue") + labs(x = "Time", title = "uhahaha", y = "wonkwang jo") + 
        theme_bw() + theme(plot.title = element_text(hjust=0.5))


diamonds # diamonds라는 데이터
ggplot(diamonds, aes(x=cut)) + geom_bar() # geom_bar는 bar그래프 만드는 것

diamonds %>%
        count(cut) %>%
        ggplot(aes(cut, n)) + geom_col() +
        geom_text(aes(label = n), color = "white", vjust = 1.5) # 각각의 값을 숫자로 보이도록 한 것


library(gcookbook)
?uspopchange # us population change라는 데이터터

order(uspopchange$Change) #오름차순으로 정리하려면, 어떻게 섞어야 정렬이 될까??
rank(uspopchange$Change) #오름차순으로 세우면, 각 값들이 몇 등일까??

upc2 <- uspopchange %>%
        filter(rank(-Change)<=10) # Top10만 가져온 것


ggplot(upc2, aes(x=Abb, y=Change, fill=Region)) + geom_bar(stat="identity")
ggplot(upc2, aes(x=Abb, y=Change, fill=Region)) + geom_col()

ggplot(upc2, aes(x=reorder(Abb, Change), y=Change, fill=Region)) + # Abb를 change 기준으로 재정렬해라
        geom_col(colour="black") +
        scale_fill_manual(values=c("#669933", "#FFCC66")) +
        xlab("State")

csub <- climate %>%
        filter(Source=="Berkeley" & Year >= 1900)

csub$pos <- csub$Anomaly10y >= 0

ggplot(csub, aes(x=Year, y=Anomaly10y, fill=pos)) +
        geom_col()

ggplot(csub, aes(x=Year, y=Anomaly10y, fill=pos)) +
        geom_col(color="black", size = .25) +
        scale_fill_brewer()

ggplot(csub, aes(x=Year, y=Anomaly10y, fill=pos)) +
        geom_col(color="black", size = .25) +
        scale_fill_manual(values=c("#CCEEFF", "#FFDDDD"), guide=FALSE)

ggplot(csub, aes(x=Year, y=Anomaly10y, fill=pos)) +
        geom_col(color="black", size = .25) +
        scale_fill_brewer(palette = "Set1") # 조합이 괜찮은 색깔들을 모아놓은 것


#line graph

ggplot(BOD, aes(x=Time, y=demand)) + geom_line()
ggplot(BOD, aes(x=Time, y=demand)) + geom_line() +geom_point()
ggplot(BOD, aes(x=Time, y=demand)) + geom_line(linetype="dashed", size=1, colour="blue")
ggplot(BOD, aes(x=Time, y=demand)) + geom_line() +geom_point(shape = 3)
?geom_point()




# Flow control ------------------------------------------------------------


#loop

i <- 0

while (i > -1) {
        print(i)
        i<-i+1
}


for (i in 1:10) {
        x<-i^2+2
        print(x)
}



#condition

x <- 100


if (x < 0) {
        print("Negative number")
        
} else if (x > 0) {
        
        print("Positive number")
        
} else {
        
        print("Zero")
        
}




# Function ----------------------------------------------------------------

# 반복을 피하고, 실수를 줄일 수 있음

# function (arguments) {operations}

# signeva는 input x를 받는 function으로 정의 그 다음 {} 열고 함수의 기능을 정의
signeva <- function(x) {
        if(x<0) {print("Nega")}
        else if(x>0) {print("Posi")}
        else {print("Zero")}
}

signeva(0)


add2 <- function(x,y) {x+y}

add2(3,5)

for (i in -5:5){
        
        signeva(i)
        
}

#functional

# 피보나치 수열
fib <- function(n){
        
        if (n == 1) {
                return(1)
        }
        
        else if (n == 2) {
                return(1)
        }
        else {
                return(fib(n-1)+fib(n-2))
                
        }
}


fib(6)






# dplyr basic(디플라이어 / 연구하는 사람들에게 굉장히 좋은!) -------------------------------------------------------------


install.packages("nycflights13")

library(tidyverse)
library(nycflights13)

#data frame 형태의 데이터가 주어졌을 때 이를 다루는 방식 다수
#dplyr는 굉장히 직관적/효율적인 명령을 가능하게 함

#filter -> 케이스 골라내기
#arrange -> 정렬
#select -> 변수 선택
#mutate -> 기존 변수 활용하여 새 변수 합성
#summarize -> 여러 값들 요약
#group_by -> 집단 별 구분하고 위의 여러 함수 적용

flights <- flights #미국 뉴욕 3개 공항 자료




# filter ------------------------------------------------------------------


filter(flights, month == 1, day == 1) # filter에 데이터 넣고, 뒤에 조건들 넣기기
jan_1 <- filter(flights, month == 1, day == 1)

#논리값이 들어가는 것이라고 생각하면 됨 / 거기서 true에 해당하는 행만 다오는 것
#논리값을 산출하는 연산자 전반적으로 쓸 수 있음. (<, >, ==, !=, %in%)
#논리값을 산출하는 함수도 다 쓸 수 있음

after_sep <- filter(flights, month >= 9)

#당연히 &,| 등으로 조건 연결 가능

filter(flights, month == 11 | month == 12)




# arrange(정렬) -----------------------------------------------------------------

# 여러 개의 변수를 넣어서 정렬시킬 수 있음
arrange(flights, year)
arrange(flights, year, month, day)
arrange(flights, year, desc(month), day) # 오름차순 정렬이 default인데, descending으로 내림차순으로 바꿀 수 있음
arrange(flights, year, -month, day) # -month를 기준으로 정렬하라는 것은 즉, 내림차순이랑 같은 의미가 됨




# select (변수 선택) ------------------------------------------------------------------

select(flights, year, month, day)
select(flights, month:arr_time) # month부터 arr_time까지
select(flights, -year)
select(flights, -(year:sched_dep_time))

select(flights, ends_with("time") # 끝나는 거 가져와라)
select(flights, starts_with("a")) # 시작하는 거 가져와라
select(flights, contains("_")) # 포함하는 거 가져와라

vars <- c("Petal.Length", "Petal.Width")
select(iris, one_of(vars))


rename(flights, tail_num = tailnum)

#변수 순서를 바꾸는 용도로 쓸 수 있음
#다 쓰기 귀찮을 때는 아래와 같이

select(flights, time_hour, air_time, everything())



# mutate (새 변수 합성) ------------------------------------------------------------------

flights_2 <- select(flights, ends_with("delay"), distance, air_time)

mutate(flights_2, gain = dep_delay - arr_delay, speed = distance / air_time) # gain: 고객이 예상보다 빨리 도착해서 얻은 시간
# mutate: 위처럼 새로 계산된 변수들을 붙여라

?flights

#만든 변수를 뒤에서 다시 쓰는 것도 가능

mutate(flights_2, gain = dep_delay - arr_delay, gain_per_minute = gain / air_time)
transmute(flights_2, gain = dep_delay - arr_delay, gain_per_minute = gain / air_time) #새로 만든것만 놔두고 싶을때



# summarize and group -----------------------------------------------------


#summarise, summarize (요약 통계량)

summarize(flights, delay = mean(dep_delay, na.rm = TRUE)) # na.rm: 결측값들이 있으면, 배제하고 계산해라
?mean


#group_by (데이터 안에 내부 구조를 만들 때 사용)

by_month <- group_by(flights, month) # month별로 따로 계산을 하고 싶다

summarize(by_month, delay = mean(dep_delay, na.rm = TRUE)) # 월별 dealy를 알 수 있음




# pipe --------------------------------------------------------------------


#굉장히 유용한 기능. 앞서 일어난 결과를 그대로 다음 함수에 연속해서 반영시키는 것


flights %>% # pipe 기호. 앞의 것의 return 값을 뒤의 것의 input으로 써라
        group_by(dest) %>% # flights data를 가지고, destination 기준으로  group_by를 해라
        summarize(count = n(), # 그리고 그 group_by를 가지고 summarize를 해라
                  dist = mean(distance, na.rm = TRUE),
                  delay = mean(arr_delay, na.rm = TRUE)) %>% 
        filter(count > 10000, dest != "HNL") %>%
        ggplot(aes(reorder(dest, -dist), dist)) + geom_col() +
        labs(x = "x축 이름", title = "실험")

# 위의 일련의 과정들이 pipe(%>%)를 사용하는 일련의 과정들임


?n()

flights %>%
        group_by(dest) %>%
        summarize(count = length(distance),
                  dist = mean(distance, na.rm = TRUE),
                  delay = mean(arr_delay, na.rm = TRUE)) %>% 
        filter(count > 20, dest != "HNL")



flights %>% 
        filter(!is.na(dep_delay), !is.na(arr_delay)) %>%
        group_by(year, month, day) %>% 
        summarise(mean = mean(dep_delay))





# (1) nycflights13 패키지에 있는 flights 데이터는 
# 뉴욕 3개 공항에서 출발한 항공편의 데이터를 포함하고 있다. 
# 이중 날짜가 2013년 9월이고 출발지가 JFK인 데이터만을 추출하여 
# sep_JFK이라는 대상에 할당하라. 


# (2) sep_JFK 데이터에서 총 연착 시간을 나타내는 
# total_delay라는 열을 새로 작성하여 데이터 맨 마지막 열에 추가하라. 
# (total_delay는 dep_delay + arr_delay이다.) 
# sep_JFK에 열을 추가하는 작업을 해서 
# sep_JFK라는 대상에 다시 할당하라는 말이다. 
# 즉, sep_JFK에 total_delay라는 변수도 존재해야 한다. 



# (3) 노선을 출발지와 종착치의 연결이라 가정했을 때 
# (예를 들어, JFK-IAH가 하나의 노선이다), 
# sep_JFK 데이터에 있는 모든 노선별로 
# 평균 total_delay와 평균 arr_time을 나타내는 데이터를 만들고, 
# 이 결과를 JFK_mean_delay_by_course라는 새로운 대상에 저장/할당하라. 
# JFK_mean_delay_by_course라는 데이터에서 노선별 
# 평균 total_delay를 나타내는 열은 mean_total_delay, 
# 평균 arr_time을 나타내는 열은 mean_arr_time라고 설정되어야 한다. 
# 이를 산출하는 평균 계산 과정에서 결측값(NA)은 제외한다. 
# (결측값 제외는 mean함수에 존재하는 na.rm = TRUE 라는 옵션을 활용하라)




# (4) JFK_mean_delay_by_course 데이터에서 mean_total_delay가 0이상이면서 2이하인 행만 추출하고, 이렇게 추출된 데이터를 mean_arr_time을 기준으로 오름차순으로 정렬한 결과를 출력하는 코드를 작성하라 (즉, 아래와 같은 결과가 출력되어야 한다)





