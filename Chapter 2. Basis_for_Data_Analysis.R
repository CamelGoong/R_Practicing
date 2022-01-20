# 02-2 데이터의 생김새

# 숫자형 데이터
ex_vector1 <- c(-1,0,1)
mode(ex_vector1) # 데이터 유형을 확인
typeof(ex_vector1)

str(ex_vector1)
length(ex_vector1)

# 논리형 데이터
ex_vector4 <- c(TRUE, FALSE, TRUE, FALSE) # 대문자로 작성해야함
mode(ex_vector4)


# 데이터 제거
remove(ex_vector1)
rm(ex_vector4)

# 범주형 자료: 특수한 형태의 벡터로 이루어져 있으며, 명목형 자료를 바탕으로 범주화. '수치형 자료'와 상반되는 개념
ex_vector5 <- c(2, 1, 3, 2, 1)
ex_vector5

cate_vector5 <- factor(ex_vector5, labels = c("Apple", "Banana", "Cherry"))
cate_vector5

# 행렬과 배열: 한가지 유형의 데이터만 담는 것 / 배열: 2차원에 해당하는 행렬을 n차원으로 확장한 것

## 행렬 matrix()
x <- c(1,2,3,4,5,6)
matrix(x, nrow = 2, ncol = 3)
matrix(x, nrow = 2, ncol = 3, byrow = T)

## 배열 array()
y <- c(1,2,3,4,5,6)
array(y, dim = c(2,2,3))

# 리스트와 데이터프레임: 여러 가지 유형의 데이터를 담는 것

## 리스트 list()
list1 <- list(c(1,2,3), "Hello")
list1
str(list1)
list1[[1]] # 대괄호로 이렇게 인덱싱

## 데이터 프레임
ID <- c(1:10)
SEX <- c("F", "M", "M", "M", "F", "F", "M", "M", "F", "F")
AGE <- c(50, 23, 24, 65, 87, 12, 13, 16, 19, 42)
AREA <- c("서울", "경기", "제주", "서울", "서울", "서울", "경기", "서울", "인천", "경기")
dataframe_ex <- data.frame(ID, SEX, AGE, AREA)
dataframe_ex
