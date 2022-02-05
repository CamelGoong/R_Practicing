# 06-1 그래프 그리기
## 1) 그래프 기본 틀 만들기: ggplot(데이터 세트, aes(데이터 속성))
install.packages("ggplot2")
library("ggplot2")
str(airquality)
ggplot(airquality, aes(x = Day, y = Temp)) + geom_point() # 2) 산점도 그리기: +geom_point()
ggplot(airquality, aes(x = Day, y = Temp)) + geom_point(size = 3, color = 'red') # 산점도 점 크기와 색상 변경
plot.new() # 작성한 그래프 지우기

## 3) 선 그래프 그리기: +geom_line()
ggplot(airquality, aes(x = Day, y = Temp)) + geom_line()

## 4) 막대 그래프 그리기: +geom_bar()
ggplot(mtcars, aes(x = cyl)) + geom_bar(width = 0.5) # width 옵션으로 막대의 두께를 지정
ggplot(mtcars, aes(x = factor(cyl))) + geom_bar(width = 0.5) # factor()함수를 적용하여, cyl열에서 빈 범주를 제외하고 4, 5, 6으로 구성된 범주형 데이터로 만듦.

## 4-1) 누적 막대 그래프 그리기: +geom_bar(aes(fill = ))
ggplot(mtcars, aes(x = factor(cyl))) + geom_bar(aes(fill = factor(gear)))

## 4-2) 선버스트 차트 그리기: +coord_polar()
ggplot(mtcars, aes(x = factor(cyl))) + geom_bar(aes(fill = factor(gear))) + coord_polar()
ggplot(mtcars, aes(x = factor(cyl))) + geom_bar(aes(fill = factor(gear))) + coord_polar(theta = "y")

## 5) 상자 그림 그리기: ggplot(data, aes(x=, y=, group =)) + geom_boxplot()
ggplot(airquality, aes(x = Day, y = Temp, group = Day)) + geom_boxplot()

## 6) 히스토그램 그리기: ggplot(data, aes()) + geom_histogram()
ggplot(airquality, aes(Temp)) + geom_histogram()

## 연산자로 이어진 코드 줄 바꿈하기
ggplot(airquality, aes(x = Day, y = Temp)) + # 연산자까지 작성한 후에 줄을 바꿔야 코드 한줄로 인식됨.
  geom_point()

# 그래프에 그래프 더하기: 선 그래프와 산점도 같이 그리기
ggplot(airquality, aes(x = Day, y = Temp)) + # 그래프 기본틀 plotting
  geom_line(color = "red") + # 선그래프 그리기
  geom_point(size = 3) # 산점도 중첩해서 그리기

