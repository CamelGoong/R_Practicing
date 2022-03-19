# R 그래픽1 (히스토그램)
## 그래프의 기본함수
## points(): 점그리기 lines(), abline(), arrows(): 선그리기
## text(): 문자출력 rect(), ploygon(): 도형
## axis(): 좌표축, grid(): 격자표현

## 그래픽 옵션
## par(): 그래프의 출력을 조정 - 그래프 화면의 분할, 마진, 글자크기, 색상
## ex) par(mfrow = c(2,2), mar = c(2,2,2,2)) 2행2열의 그래프
## par()의 여러가지 옵션
## pty = "s" (x축과 y축을 동일비율로 설정), "m"(최대크기로 설정)
## legend = c("name1", "name2") # title 설정
## bty = "o" box type 그래프의 상자모양을 설정
## pch = 1 point character 기본값인 1은 그냥 동그라미 그래프
## lty = 1 line type
## lwd = 1 (선의 굵기)
## cex = 1 (character expansion) 문자나 점의 크기
## mar (아래, 왼쪽, 위쪽, 오른쪽)

## 히스토그램(1차원)

getwd()

# setwd() # 지금은 위치가 잘 설정되어있으므로 이 명령어 생략
brain <- read.csv(file = 'brain2210.csv')
head(brain)
dim(brain)

attach(brain) # 앞으로 이 데이터를 사용하겠다.

# 1. histogram
# 1-1 histogram with no options
hist(wt) # histogram() 아님. 이런 함수 없음.
hist(wt, col = "lightblue")

# 1-2 histogram with color and title, legend
hist(wt, breaks = 10, col = "lightblue", main = "Histogram of Brain Weight") # breaks = 몇개의 구간으로 나눌 것인지

# R에서 사용하는 색깔은 657가지
colors() # 이렇게 쳐서 볼 수 있음.

# 위의 여러 색깔 중에서도 select colors including "blue"
grep("blue", colors(), value = TRUE)

# 밀도 함수 그려보기
par(mfrow = c(1,1))
d <- density(wt) # 밀도 함수 객체 구하는 듯.
plot(d)

# R 그래픽2 (상자그림, 산점도)
# 상자그림 (boxplot, 1차원)

# 2. boxplot
bar(mfrow = c(1,2)) # 그래프 구성
# 2-1 boxplot for all data
boxplot(wt, col = c("coral"))

# 2-2 boxplot by group variable(female, male)
boxplot(wt~sex, col = c("green", "orange")) # ~의 의미는 wt가 종속변수, sex가 독립변수임.

# 남아의 뇌의 무게가 더 무거운 분포를 보이는 것으로 볼 수 있음.

## 이상치들은 Q1, Q3로부터 1.5 IQR을 넘는 값들임.

# 2-3 horizontal boxplot / 기존의 함수 안에 horizontal = TRUE 옵션만 추가해주면 됨.
par(mfrow = c(1,1))
boxplot(wt~sex, boxwex = 0.5, horizontal = TRUE, col = c("grey", "red")) # boxwex : 모든 상자에 대한 확장폭

detach(brain)

# 막대그림(barplot, 2차원)

car <- read.csv("autompg.csv")
head(car)
attach(car)

# barplot과 histogram의 차이는 barplot: 범주형 변수에 대한 빈도. / histogram: 연속형 변수에 대한 빈도

# barplot은 범주형 변수에 대한 빈도이므로, 우선 table()로 각 범주의 빈도를 구해줘야 함.
par(mfrow = c(1,1))
freq_cyl = table(cyl)
freq_cyl

names(freq_cyl) <- c("3cyl", "4cyl", "5cyl", "6cyl", "8cyl")

barplot(freq_cyl, col = c("lightblue", "mistyrose", "lightcyan", "lavender", "cornsilk"))

# 산점도 (scatterplot) 2차원

# 차의 무게와 연비 간의 산점도
par(mfrow = c(2,1))
plot(wt, mpg) # scatterplot이 아니고, plot 이런식으로 하면 산점도가 나옴.

# 마력과 연비 간의 산점도
plot(hp, mpg)

# 즉, 차의 무게가 무거울수록, 연비는 낮다.
# 즉, 마력과 연비 간의 산점도에서는 두 개의 클러스타가 보이는데,
# 마력이 높을수록 연비가 낮게 나타난다.

# col = as.integer(그룹변수) 를 사용하여 각 cyl마다 다른 색깔 적용. as.integer() 정수형 벡터로 변환
par(mfrow = c(1,2), mar = c(4,4,2,2))
plot(disp, mpg, col = as.integer(cyl))
plot(wt, mpg, col = as.integer(cyl))

## Conditioning plot: 그룹별로 산점도를 그려보는 것;
## coplot(y~x | z) 여기서 z는 factor(그룹)

car1 <- subset(car, cyl == 4 | cyl ==6 | cyl == 8) # subset으로 4, 6, 8기통 데이터만 나누어서 가져오기
head(car1)
coplot(car1$mpg~car1$disp | as.factor(car1$cyl), data = car1,panel = panel.smooth, rows = 1)

# pairwise scatterplot: pairs(변수 리스트)
pairs(car1[, 1:6], col = as.integer(car1$cyl), main = "autompg") # 여기서도 다시 col = as.integer()로 색깔 다르게 해주기
# car[1, 1:6] 로 앞 순서대로 6개의 변수만 따온 것.

# 최적 적합 함수 추정 (선형회귀모형, 비선형회귀모형) / 회귀식 함수 추가할 수 있음.
# lm(y변수~x변수) : lm은 linear model(선형모형)의 약자
# abline : add line (선을 추가하는 함수)

par(mfrow = c(1,1))
plot(wt, mpg, col = as.integer(car$cyl), pch = 19) # pch(pointcharacter는 점의 크기)

# best fit linear line
abline(lm(mpg~wt), col = "red", lwd = 2, lty = 1) # lwd(linewidth), lty(linetype)

# 최적 적합 함수 추정 (비선형회귀모형, lowess 이용)
# 앞에서는 lm을 활용한 선형회귀식이었고, 지금은 lowess를 활용한 비선형회귀식
# lowess(locally-weighted polynomial regression)

plot(wt, mpg, col = as.integer(car$cyl))

# best fit linear line
abline(lm(mpg~wt), col = "blue", lwd = 2, lty = 1) # 선형회귀식 그리기

# lowess: locally-weighted polynomial regression
# 위의 선형회귀식과 다르게 비선형회귀식은 abline()이 아닌 lines()로 그림.
lines(lowess(wt, mpg), col = "red", lwd = 3, lty = 2)

# R 그래픽3 (ggplot2 활용)
install.packages('ggplot2')
library('ggplot2')

# Grammar of graphics(ggplot)
# layer를 더하는 것으로 생각하면 됨.

# (1) ggplot()이라는 기본 함수
# (2-1) Layers: aes(Aesthetic): 데이터를 어떻게 넣을지
# +(2-2) Layer: geom(Geometric objects): point(점), line(선) 등
# +(2-3) Layer: coor(coordinate system)

# ggplot(데이터이름, aes(x = x축 변수, y = y축 변수, color = factor변수, shape = factor 변수))

car1 <- subset(car, cyl == 4 | cyl == 6 | cyl == 8)
attach(car1)

# 1. ggplot for scatterplot
str(car1)
car1$cyl <- as.factor(car1$cyl) # cyl을 범주형 변수로 정의

# draw the plot using ggplot
par(mfrow = c(1,1))
ggplot(car1, aes(x = wt, y = disp, color = cyl, shape = cyl)) + # shape는 점의 모양인듯. 따라서 cyl 범주형 변수를 넣어주면, 범주에 따라서 다른 점의 모양이 생기는 듯
  geom_point(size = 3, alpha = 0.6) # geom_point는 점으로 그리는 것

# mpg의 크기를 표시한 그래프
str(car1)
ggplot(car1, aes(x = wt, y = disp, color = mpg, size = mpg))+
  geom_point(alpha = 0.6)
# mpg를 size별로 표시해달라. mpg는 numeric이니까 그냥 넣으면, 숫자 크기에 따라서 사이즈가 다르게 그려짐.

# geom_bar을 이용한 단계별 그래프 설명
# 1. grid를 cyl에 따라서 그림.
p1 <- ggplot(car1, aes(factor(cyl), fill = factor(cyl))) # fill 색깔
p1

# 2. geom_bar을 이용한 cyl빈도의 막대그래프
p1 <- p1 + geom_bar(width = 0.5)
p1

# 3. cyl의 bar chart를 변수 'origin'에 따라서 그림.
p1 <- p1 + facet_grid(.~origin) # facet_grid() : 쉽게 말해 multi plot. / 하나의 데이터를 여러 개의 plot으로 나눠서 보고자 할 때 사용.
p1
# .은 아마도 전체 데이터를 종속변수로 보겠다는 의미인듯

# geom_bar을 이용한 누적 막대그래프
p <- ggplot(car1, aes(factor(cyl)))
p
p <- p + geom_bar(aes(fill = factor(origin), color = "black"))
p

# R 그래픽4 (공간지도 분석)
library(dplyr)
library(ggplot2)

install.packages("maps") # maps: 세계의 지도 데이터베이스
library("maps")

install.packages("mapdata") # mapdata: maps보다 정교한 지도
library(mapdata)

install.packages("mapproj") # mapproj: 위도와 경도
library("mapproj")

# R 그래픽: 공간지도
par(mfrow = c(1,2), mar = c(2,2,2,2)) # mar: 여백을 나타냄.
# using map pakcage
map(database = 'world', region = c('South Korea', 'North Korea'), col = 'green', fill = TRUE)
title("Korea") # 이런식으로 괄호의 바깥에 별도로 써주어야 함.
# using map data package
map(database = 'worldHires', region = c('South Korea', 'North Korea'), col = "green", fill = TRUE)
title("Korea")

# 지도 :  이탈리아
# 2. Italy
par(mfrow =  c(1,1), mar = c(2,2,2,2))
map(database = "world", region = c('Italy'), col = "coral", fill = TRUE)
title("Italy")

# mapproj 패키지 - 위도와 경도를 활용(독도를 표시)
map('world', proj = 'azequalarea', orient = c(37.24223, 131.8643, 0)) # 지구본 모양의 지도
map.grid(col = 2)
points(mapproject(list( y = 37.24223, x = 131.8643)), col = "blue", pch = "x", cex = 2) # pch: pointcharacter인듯, cex: 점의 크기
# mapproject: 경도, 위도를 좌표계로 변환
title("Dokdo")

# 공간지도분석 예제 : 국내공항 및 항공노선
# 4. Airport & route data (source : httpls://www.data.go.kr/)
airport <- read.csv("airport.csv")
route <- read.csv("route.csv")
head(airport)
head(route)

head(route[order(route$id),]) # 행을 id 기준으로 정렬한 다음에 전체 데이터를 표시

# korea map(kr.map)
world.map <- map_data("world") # map.data에서 세계지도 정보 가져오기
kr.map <- world.map %>% filter(region == "South Korea") # world.map에서 한국 데이터만 필터링
head(kr.map)

# aes:  aes는 그래프의 미적(?)인 부분으로 x축, y축, 칼러 등 그래프가 안에 어떻게 생겼는지를 제외한 모습을 지정
ggplot()+
  geom_polygon(data = kr.map, aes(x = long, y = lat, group = group )) + # 세계지도를 도형으로 그려주는 함수
  geom_label(data = airport, aes(x = lon, y = lat, label = iata)) + # iata: 인청공항은 ICN가 같이 각 공항을 나타내는 약자
  labs(title = "South Korea Airport") # labs: 라벨링

# ggplot은 레이어를 추가하는 방식으로 그래프를 구현

# 공간지도분석 예제 2: 미국 행정데이터
par(mfrow = c(1,1))
library(maps)

# excluding Alaska, Hawaii
sub.usa <- subset(USArrests, !rownames(USArrests) %in% c("Alaska", "Hawaii"))

# data with State name, Assault count
usa.data <- data.frame(states = rownames(sub.usa), Assault = sub.usa$Assault)
head(usa.data)
# legend

col.level <- cut(sub.usa[,2], c(0, 100, 150, 200, 250, 300, 350)) # cut(): 연속형 변수 ->  factor형 변수
legends <- levels(col.level)
legends

# displaying color for the size
levels(col.level) <- sort(heat.colors(6), decreasing = TRUE) # heat.colors(6): 컬러 6개를 숫자 형태로 표현

# Map
map('state', region = usa.data$states, fill = TRUE, col = as.character(col.level)) # 이 부분 오타났던듯 col.level이 맞는 듯.
title("USA Assault map")
legend(-77, 34, legends, fill = sort(heat.colors(6), decreasing = TRUE), cex = 0.7)
# legend의 위치, legends로 쓸 변수인 legends

# R 그래픽5 (공간지도 시각화 - 행정데이터 공간지도 분석)
## 데이터 수집하기
## 지도데이터(.shp): 원하는 행정구역 단위 선택
## 분석데이터(.csv)
## 데이터 불러오기
## raster 패키지: shp파일을 불러오는 함수 제공
## ggplot2 패키지: shp파일을 데이터프레임으로 변환하는 함수 제공

## 행정구역 단위의 지도데이터(.shp) 다운받기
## GIS DEVELOPER에서 받기
## shp: 도형 파일 dbf: 각 도형의 속성정보 prj: 좌표정보, shx: 도형의 위치, 방향정보

## 2019 재해연보 통계자료(.csv)
## 시도별 태풍 평균 피해액
## 데이터 출처: 행정안전부 2019 재해연보 재구성

# 공간지도 패키지 불러오기
install.packages("raster") # raster: shp 파일을 불러오는 함수 제공
install.packages("rgdal")
install.packages("rgeos")
install.packages("ggplot2") # ggplot2: shp파일을 데이터프레임으로 변환하는 함수 제공
install.packages("maptools")

library(raster) 
library(rgdal)
library(rgeos)
library(ggplot2)
library(maptools)

# 1. 데이터 불러오기
# 지도 데이터 불러오기
getwd()
korea = shapefile('C:/Users/goong/Desktop/r_data/TL_SCCO_CTPRVN.shp') # 파일을 onedrive가 아닌 그냥 바탕화면에 했더니 됨.
korea <- spTransform(korea, CRS("+proj=longlat +ellps=WGS84 +datum=WGS84 +no_defs"))

# shp파일 -> 데이터프레임으로 변환
kmap <- fortify(korea, region = 'CTP_KOR_NM')
head(kmap)

# 분석 데이터 불러오기
loss <- read.csv("disaster_loss.csv")
loss = data.frame(loss)
loss

# 지도데이터(kmap)에 행정구역을 기준으로 분석데이터(loss) 결합
# 행정구역이 kmap에서는 'id'로 loss에서는 'CTP_KOR_NM'이라는 변수로 되어있음.
# 2. 행정구역 매핑하기
map_loss = merge(kmap, loss, by.x = 'id', by.y = 'CTP_KOR_NM') # by.x, by.y에 유의!
head(map_loss)

# 행정구역별 연평균 태풍 피해액 시각화_음영
# 3. 공간지도 그리기
ggplot()+
  geom_polygon(data = map_loss, aes(x = long, y = lat, group = group, fill = LOSS), color = 'black')+ # group변수는 도별로, fill 색깔은 loss 기준으로
  scale_fill_gradient(low = 'white', high = 'red') +  # 범위에 따라서 단계적으로 색깔이 바뀌게 해줌.
  labs(title = "Typhoon annual average loss")

# 행정구역별 연평균 태풍 피해액 시각화_라벨 (위의 색깔과 다르게 값을 붙여주는 것.)

## 3-1. 라벨을 이용해 그리기
#sido:라벨을 찍을 위치와 데이터 결합 파일
id=c('강원도','경기도','경상남도','경상북도','광주광역시','대구광역시','대전광역시','부산광역시',
     '서울특별시','세종특별자치시','울산광역시','인천광역시','전라남도','전라북도','제주특별자치도',
     '충청남도','충청북도')
lat=c(37.73533029652902,37.37461571682183,35.34289466534233, 36.36421656520106, 35.15304344259423, 35.832921148206935, 36.34515471294123, 35.17054383562119, 
      37.653727266473544, 36.54678809312607, 35.55526578760384,37.47597369268592, 34.865797681620236,35.758055644819734, 33.397462234218615,
      36.53241594721893, 37.00226015826154 )
lon=c(128.4397367563543, 127.26963023732642,128.19793564596964,128.9105911242575,126.83143573256017,128.57562177593638, 127.39223207828397, 129.06218231400558,
      126.98917443004862,127.25928222608304,129.3267761313981,126.67537883135644,126.95171618419725,127.15494457083665,126.55618969258185,
      126.85961846125828, 127.73357551475945)
sido=data.frame(id,lat,lon)
sido=merge(sido,loss,by.x='id',by.y='CTP_KOR_NM')

head(sido)
#라벨 그리기
ggplot() +
  geom_polygon(data=map_loss, aes(x=long, y=lat, group=group), color='black' ,fill='white')+
  geom_label(data=sido, aes(x=lon, y=lat, label=LOSS))+
  labs(title="Typhoon annual average loss")