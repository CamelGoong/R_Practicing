
# 1차시: 두 그룹간 평균비교분석 -------------------------------------------------------

# 단일표본의 평균검정: t.test(변수, mu = 검정하고자 하는 평균값)
# 가설 1: G3이 평균은 10인가?
getwd()
setwd("C:/Users/goong/OneDrive - postech.ac.kr/바탕 화면/Postech/학교, 학사/1학년 1학기/데이터 분석을 위한 R프로그래밍/wk6")

stud <- read.csv("stud_math.csv")
head(stud)
attach(stud)

# single t-test
t.test(G3, mu = 10)

# 두 집단의 평균검정: t.test(타겟변수~범주형변수, data = ) # 이 부분에서는 따로 mu를 입력하는 부분이 없음.
# 가설 2: 거주지역(R, U)에 따른 G3(최종성적) 평균에 차이가 있는가?
# <양측 검정>
t.test(G3~address, data = stud)

# <단측 검정> : alternative = c("less") 나 c("greater")을 추가하면 됨.
# 가설 : 성적(Rural) < 성적(Urban)
t.test(G3~address, data = stud, alternative = c("less"))

# 가설 3: 방과후 활동여부(yes, no)에 따른 G3(최종성적) 평균에 차이가 있는가?
t.test(G3~activities, data = stud)
boxplot(G3~activities, boxwex = 0.5, col = c("blue", "red"))

# 설명 (두 집단 표본평균 비교검정 t.test 설명)
# p-value = 0.75는 유의수준 0.05 보다 크다. 즉, 검정통계량의 값이 기각역에 있지 않으므로, 귀무가설(평균이 같다)을 기각할 수 없고
# 따라서 방과후 활동 여부는 G3에 유의한 영향이 없다고 볼 수 있다.

# 두 집단의 비모수적 비교검정: wilcox.test(타겟변수~범주형변수)
wilcox.test(G3~address)

# 2차시: 짝을 이룬 그룹간 평균비교 -----------------------------------------------------
# t.test(before, after, mu = 0, paired = T)
# 예제 1: 고혈압 환자 10명에게 혈압강하제를 12주동안 투여한 후, 복용 전의 혈압과 복용 후의 혈압을 비교. 효과가 있다고 할 수 있는가?
hp <- read.csv("bp_pair.csv")
head(hp)

# 설명
# p-value가 0.0015로 유의수준보다 작으므로, 투약 전과 투약 후의 혈압에 유의한 차이가 있다고 볼 수 있다.
# 또한, mean of the differences를 봤을 때, 투약 후에 평균적으로 혈압이 14.5 떨어졌다!!

# <양측 검정>
t.test(hp$bp_pre, hp$bp_post, mu = 0, paired = T)

# <단측 검정>
t.test(hp$bp_pre, hp$bp_post, mu = 0, alternative = "greater", paired = T)

# 예제 2: 비만 대상자들(성인)에게 12주 동안 극저 칼로리 식이요법을 실시한 후, 그 효과를 비교. 이 프로그램이 체중감소에 효과가 있었는가?
diet <- read.csv("weight.csv")
head(diet)

t.test(diet$wt_pre, diet$wt_post, mu = 0, paired = T)


# 3차시: 분산분석(ANOVA) --------------------------------------------------------

# 분산분석: Factor가 1개일 때,
# 가설 1: 거주지역(R/U)에 따라 G3에 유의한 영향이 있나?
# aov(타겟변수~factor)
a1 <- aov(G3~address)
a1
summary(a1)

# tapply로 각 address별 G3의 평균을 구해서 비교확인 해보기
tapply(G3, address, mean)

# 가설 2: 통학 시간에 따라, G3에는 유의한 차이가 있나?
traveltime <- as.factor(traveltime) # 이렇게 factor형 변수가 아닌 경우에는 factor형 변수로 바꿔줘야 함. 아니면 p-value값이 완전 반대로 나와버림!!
a2 <- aov(G3~traveltime)
summary(a2)
a2

# 사후검정: ANOVA에서 어떤 factor의 유의성이 검정되면, 그 다음 단계에 하는 검정.
TukeyHSD(a2, "traveltime", ordered = TRUE)
# 설명명
# 즉, 결과를 보면, 모든 신뢰구간에 0이 포함되므로, 유의성이 없다는 의미.

# 추가 예제: 분산분석
# 연애경험여부에 따른 학업성취도: 연애경험(yes,no), 학업성적(1-20)

# 우선, ANOVA 분석
a4 <- aov(G3~romantic)
summary(a4) # 일단 p-value가 0.05보다 작게 나오므로, 유의성이 있다.
# t-apply로 mean의 차이가 있는지 확인
tapply(G3, romantic, mean)
