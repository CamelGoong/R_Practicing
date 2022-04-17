## 1차시: 두 그룹간 평균비교분석

# 단일표본의 평균 검정: t.test(변수, mu = 검정하고자 하는 평균값)
# t-test for two sample means
# set working directory
setwd("C:/Users/goong/OneDrive - postech.ac.kr/바탕 화면/Postech/학교, 학사/1학년 1학기/데이터 분석을 위한 R프로그래밍/wk6")
getwd()

stud <- read.csv("stud_math.csv")
head(stud)
dim(stud)
str(stud)
attach(stud)

# single t-test : to test whether or not mean of G3 is 10
# 가설 1: G3(최종서적)의 평균은 10인가?
t.test(G3, mu = 10)

# 두 집단의 평균검정: t.test(타겟변수~범주형변수, data = )
# 가설 2: 거주지역(R, U)에 따른 G3(최종성적) 평균에 차이가 있는가?(양측검정)
t.test(G3~address, data = stud)
boxplot(G3~address, boxwex = 0.5, col = c("yellow", "coral"))

# 두 집단 표본평균 비교검정: t.test(타겟변수~범주형변수, data = )
# 단측검정: 기각역이 한쪽에만 있는 경우, alternative = c("greater") 혹은 alternative = c("less")
# 가설: Ur < Uu
t.test(G3~address, data = stud, alternative = c("less"))

# 가설 3: 방과후 활동여부(yes, no)에 따른 G3(최종성적) 평균에 차이가 있는가?
t.test(G3~activities, data = stud)
boxplot(G3~activities, boxwex= 0.5, col = c("blue", "red"))

# 두 집단의 비모수적 방법(Wilcoxon rank sum Test) : wilcox.test(x, y)
wilcox.test(G3~address)

## 2차시: 짝을 이룬 그룹간 평균 비교 (paired t-test) 

# 예제 1 : 고혈압 혈압강하제 투여 전 후 비교
# paired t-test : t.test(before, after, mu=0, paired = T) (양측검정)
# 동일한 표본의 before & after의 측정 
bp <- read.csv("bp_pair.csv")
attach(bp)
head(bp)

t.test(bp_pre, bp_post, mu = 0, paired = T)

# paired t-test : t.test(before, after, mu=0, paired = T) (단측검정)
t.test(bp_pre, bp_post, mu = 0, alternative = "greater", paired = T)

detach(bp)

# 예제 2 : 극저 칼로리 식이요법의 효과
diet <- read.csv("weight.csv")
attach(diet)

# paired t-test (양측검정)
t.test(wt_pre, wt_post, mu = 0, paired = T)

## 3차시: 분산분석(ANOVA)
# 분산분석: Factor가 한 개 일 때, "One-way ANOVA"
# (1) 거주지역에 따른 학업성취도: 거주지역(factor: R/U), 학업성적(1-20)
# (2) 통학 시간에 따른 학업성취도: 통학시간(factor: 1-4), 학업성적(1-20)

# 2. boxplot
par(mfrow = c(1,2))
boxplot(G3~address, boxwex = 0.5, col = c("yellow", "coral"), main = "G3 by (Urban, Rural)") # main은 제목
boxplot(G3~traveltime, boxwex = 0.5, col = c("red", "orange", "yellow", "green"), main = "G3 by traveltime")

# (1) 거주지역에 따른 학업성취도: 거주지역(factor: R/U), 학업성적(1-20)
# 이 경우에는 앞에서처럼 T-test를 사용해도, ANOVA를 사용해도 동일한 결과를 얻을 수 있음.
# 1. ANOVA by address
a1 <- aov(G3~address)
summary(a1)

# t-apply - give FUN value by address
round(tapply(G3, address, mean),2)

# (2) 통학 시간에 따른 학업성취도: 통학시간(factor: 1-4), 학업성적(1-20)
traveltime <- as.factor(traveltime) # traveltime이 factor 변수로 정의가 되어있지 않다면, 우선 이렇게 정의를 해주어야 함.
a2 <- aov(G3~traveltime)
summary(a2)

# 사후검정: ANOVA에서 어떤 factor의 유의성이 검정되면, 그 다음 단계에 하는 검정
# should be factor for Tukey's Honest Significant Difference test
TukeyHSD(a2, "traveltime", ordered = TRUE) # ordered = 순서대로 해달라.
plot(TukeyHSD(a2, "traveltime"))

# 추가 예제: 분산분석
# 연애경험여부에 따른 학업성취도 : 연애경험(yes, no), 학업성적(1-20)
a4 <- aov(G3~romantic)
summary(a4)
# tapply
round(tapply(G3, romantic, mean), 2)

boxplot(G3~romantic)
