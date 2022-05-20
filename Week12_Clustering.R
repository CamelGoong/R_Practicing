# 1차시: 군집분석과 유사성 척도 --------------------------------------------------------

# similarity measures - distance
# (소득, 브랜드)로 주어진 데이터프레임을 만듦.
m1 <- matrix(
  c(150, 50, 130, 55, 80, 80, 100, 85, 95, 91),
  nrow = 5,
  ncol = 2,
  byrow = T
)

# m1을 dataframe으로 정의
m1 <- as.data.frame(m1)

# 1. Euclidean distance
D1 <- dist(m1)
D1

# help("dist")를 쳐보면, default는 유클리디안이지만, 다양한 거리 측정 방법을 사용할 수 있는 것을 알 수 있음.

# 2. Minkowski distance
D2 <- dist(m1, method = "minkowski", p =3 ) # P는 차원? P = 2일때, 유클리디안 거리와 계산이 똑같아짐.
D2

# 3. Correlation coefficient / 객체간 상관계수
m2 <- matrix(
  c(20, 6, 14, 30, 7, 15, 46, 4, 2),
  nrow = 3,
  ncol = 3,
  byrow = T
)
m2

# correlation between obs1~obs2
cor(m2[1,], m2[2,])
# correlation between obs1~obs3
cor(m2[1,], m2[3,])

# 객체1과 객체2의 유사성 > 객체1과 객체3의 유사성 의 결과 도출.


# 2차시: 계층적 군집분석 -----------------------------------------------------------
# 완전연결법 vs 평균연결법
getwd()
setwd("C:/Users/goong/OneDrive - postech.ac.kr/바탕 화면/Postech/학교, 학사/1학년 1학기/데이터 분석을 위한 R프로그래밍/wk12")

# read csv file
wages1833 <- read.csv(file = "wages1833.csv")
head(wages1833, n = 10)

# preprocessing
# delete ID variable
dat1 <- wages1833[ , -1] # ID열만 제외.
# delete missing data
dat1 <- na.omit(dat1) # 결측치 제거
str(dat1)

# calculate distance
dist_data <- dist(dat1)

# prepare hierarchical cluster
# 1) 완전연결법
hc_c <- hclust(dist_data, method = "complete")
plot(hc_c, hang = -1, cex=0.7, main = "complete") # 댄드로그램 그리기

# 2) 평균연결법
hc_a <- hclust(dist_data, method = "average")
plot(hc_a, hang = -1, cex = 0.7, main = "average")

# 3) 워드(Ward's)방법을 적용 / 계층적 군집분석에서 가장 보편적인 방법
hc_w <- hclust(dist_data, method = "ward.D2")
plot(hc_w, hang = -1, cex = 0.7, main = "Ward's method")

# 3차시: 비계층적 군집분석 --------------------------------------------------------

# 1) K-means 군집분석
# K-means에서 가장 중요한 것은 K의 최적값을 정하는 일임.
# read csv file
wages1833 <- read.csv(file = "wages1833.csv")
head(wages1833)

# preprocessing
# delete ID varible
dat1 <- wages1833[, -1]
# delete missing data
dat1 <- na.omit(dat1)
head(dat1, n = 5)

# to choose the optimal k, silhouette
install.packages("factoextra")
library(factoextra)
library(ggplot2)

fviz_nbclust(dat1, kmeans, method = "wss")
fviz_nbclust(dat1, kmeans, method = "gap_stat")

# k=3으로 해서, kmeans를 실행
# compute kmeans
set.seed(123)
km <- kmeans(dat1, 3, nstart = 25)

km # 이렇게 함으로써, 각 클러스터의 평균들을 보고 각각의 군집을 어떤 특성의 군집인지 해석할 수 있음.

# 시각화
fviz_cluster(km, data = dat1, ellipse.type = "convex", repel = T)
# cluster 1,2,3의 결과. 첫번째 cluster는 관측치가 10개

# k-medoids 군집분석
# k-medoids의 2가지 알고리즘인 PAM 알고리즘과 CLARA 알고리즘 중 PAM 알고리즘 사용.
library("cluster")
pam_out <- pam(dat1, 3) # 3은 k에 해당하는 값값
pam_out # 각 cluster의 대표 객체를 볼 수 있음.

# freq of each cluster
table(pam_out$clustering)

# 시각화
fviz_cluster(pam_out, data = dat1,
             ellipse.type = "convex",
             repel = T)

# k-means의 결과와 동일하게 assign된 것을 볼 수 있음.

# DBSCAN 알고리즘
install.packages('fpc')
library(fpc)
db <- dbscan(dat1, eps = 70, MinPts = 3)

# result of clustering
db
db$cluster

# 시각화
fviz_cluster(db, data = dat1,
             ellpise.type = "convex",
             repel = T)

# 실루엣 계수 계산 / PAM 알고리즘과 DBSCAN 알고리즘의 결과를 가지고 실루엣 계수를 계산할 수 있음.
# 각 군집별로 실루엣계수를 계산한 후, 이들을 평균을 내어서 비교분석을 할 수 있음.
library(cluster)
sil_pam <- silhouette(pam_out$clustering, dist(dat1))
sil_pam
mean(sil_pam)
sil_db <- silhouette(db$cluster, dist(dat1))
sil_db
mean(sil_db)
# 실루엣 계수 값을 비교해보았을 때, PAM > DBSCAN이므로 PAN이 더 군집화가 잘 되었다고 볼 수 있음.
# Quiz --------------------------------------------------------------------

## 3번 문제
m1 <- matrix(
  c(150, 50, 130, 55, 80, 80, 100, 85, 95, 91),
  nrow = 5,
  ncol = 2,
  byrow = T
)
m1 <- as.data.frame(m1)
m1

dist(m1, method = "manhattan")

## 5번 문제
setwd("C:/Users/goong/OneDrive - postech.ac.kr/바탕 화면/Postech/학교, 학사/1학년 1학기/데이터 분석을 위한 R프로그래밍/wk12")

# read csv file
wages1833 <- read.csv(file = "wages1833.csv")
head(wages1833, n = 10)
data1 <- wages1833[, -1]
head(data1)

dist_u <- dist(data1, method = "euclidean")
hc_w <- hclust(dist_u, method = "ward.D2")
plot(hc_w, hang = -1, cex = 0.7, main = "Ward's method")
