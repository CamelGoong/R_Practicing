# 03-1 변수와 함수

## 변수 만들기
x <- 10
y <- "HI"

## 함수 호출하기
sum(10,20) # 더하기

## 내장 함수 사용하기
print("Hello World")

a <- sum(1:100)
a

Sys.Date()

## 사용자 정의 함수 만들기
multi_three_return <- function(a, b, c)
{
  result = a * b * c
  
  return (result)
}

multi_three_return(4, 5, 7)

## print(), cat() / print()는 첫번째 숫자만 출력. cat()은 여러 변수를 출력할 수 있음
print(1, 2, 3)
cat(1, 2, 3, "Hello")

# 03-2 패키지

## 패키지 설치하기
install.packages("reshape2")

## 설치한 패키지 확인하기
library()

## 패키지 삭제하기
remove.packages("reshape2")

# 03-3 조건문과 반복문

## 연산자

### 1) 할당 연산자
A <- 2
A
B = 10
B

C = D <- 5
C
D
# <- 와 = 는 동일한 기능을 하는 '할당 연산자'이지만, <- 의 우선순위가 더 높음.

### 2) 산술 연산자

20 / 7 # 나누기
20 %/% 7 # 몫
20 %% 7 # 나머지

### 3) 관계 연산자(=비교 연산자)
5 != 5

### 4) 논리 연산자
x <- 1:3
y <- 3:1

(x>0) & (y>1)
(x>0) | (y>1)

## if-else 조건문
a <- 10

if(a %% 2 == 0){
  print("짝수입니다.")
}else {
  print("홀수입니다.")
}

b <- 79

if(b >= 90){
  print("A학점입니다.")
}else if(b >= 80){
  print("B학점입니다.")
}else{
  print("C학점입니다.")
}

## 반복문
### for() 함수
for(i in 1:9){
  a <- 2*i
  print(a)
}

### 1) apply() 함수
x <- matrix(1:4, 2, 2) # 2행2열 행렬

apply(x, 1, sum) # 옵션이 1이니까, 각 행을 sum한 결과
apply(x, 2, min) # 각 열의 최솟값
apply(x, 1, max) # 각 행의 최댓값

str(iris)
View(iris) # View(): 데이터 살펴보기

apply(iris[, 1:4], 2, sum)

### 2) lapply() : 리스트로 반환
lapply(iris[, 1:4], sum)


### 3) sapply : 벡터로 반환
sapply(iris[, 1:4], mean)

# 좀 더 알아보기 : R 코드 오류 해결하기
install.packages("dplyr")

library("dplyr")
summarize(iris)
