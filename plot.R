# plotting -> ggplot
plot(1) # (1,1)에 plotting

m <- matrix(1:15, ncol=3, byrow = T)
m <- data.frame(m)

plot(m) # 산점도를 시각화

cor(m) # correlation matrix를 만듦

rnorm(100) # 표준 정규분포를 따르는 난수를 100개 생성
plot(rnorm(100))
hist(rnorm(100))

data <- cbind(rnorm(100), rnorm(100), rnorm(100))
cor(data)
plot(data.frame(data))

# R은 파이썬에 비해서 plotting이 쉬움.

ts.plot(data[,1]) # 시계열 plot 그리기
ts.plot(data, col = c('red', "blue", "black")) # 그래프의 색깔을 다르게 해주기

data2 <- data.frame(data)
head(data2)
fit <- lm(X3~., data=data2) # lm: 회귀분석, data2를 가져와서, 모든 것에 대해서 회귀분석을 돌림림
data2

for(i in 1:30){
  data2 <- cbind(data2,rnorm(100))
  colnames(data2)<- paste0("X", 1:ncol(data2))
  fit <- lm(X1~.,data = data2)
  sse <- c(sse,sum((fit$residuals)^2)) # sum of quares error SSE
  ts.plot(sse)
}


