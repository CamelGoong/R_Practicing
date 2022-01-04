m<-matrix(1:15, ncol=3, byrow = T) # ncol: column 수 / byrow: 숫자를  row순으로 정렬
? matrix # matrix를 사용하는 방법이 나옴

mdat <- matrix(c(1,2,3, 11,12,13), nrow = 2, ncol = 3, byrow = TRUE,
               dimnames = list(c("row1", "row2"),
                               c("C.1", "C.2", "C.3"))) # dimnames는 각 행과 열에 이름을 붙여주는 것
mdat

m[2,2] # vector와 다르게 matrix에서는 대괄호에 , 를 사용해서 접근 가능
m[1,c(1,2,3)]
m[1,] # 1행의 모든 것의 의미 뒤에 비워놓으면 위와 다르게 1행 모두 출력하라는 의미

## , 기준으로 해서 앞에는 행에 대한 정보 / 뒤에는 열에 대한 정보
m[,1] # 1열만 가져와
m[-1,] # 1행만 빼고 가져와와
m[c(1,3),] # 행은 1행과 3행만 가져오고, 열은 전부 가져와
m[-c(1,3),] # 행은 1행과 3행을 빼고, 열은 전부 가져와
m[2:4, c(2,3)] # 헹은 2행부터 4행 가져오고, 열은 2,3열 가져와

m

m2 <- data.frame # matrix m을 dataframe으로 만들고 m2에 넣기
m2

## 데이터를 import할 때, Dataframe을 만드는 것이 좋음.

m[,1] <- as.character(m[,1]) # m의 첫번째 열을 억지로 문자열로 바꿔서 덮어씌운 것
m # 위 같이 m의 첫번째 열을 문자열로 바꿈으로써, 다른 모든 열까지 문자열로 바뀌어버림

str(m2) # str()은 structure의 약자로 m2의 structure을 보고 있는 것 / 모두 정수형(int)로 되어있음

m2[,1] <- as.character(m2[,1]) # dataframe인 m2에도 마찬가지로, 위에서처럼 1열만 강제로 문자열로 바꾸는 실행
str(m2) # 결과를 보면, matrix와 다르게 1열만 문자열로 바뀌어져 있음. 여기서 matrix와 dataframe의 차이는 matrix는 모든 요소의 형태가 같아야 함.

m3 <- as.matrix(m2) # dataframe을 강제로 matrix로 바꾸어주는 것 / 가끔 머신러닝에서 matrix 형태를 요구할 때/

str(m3)

# 성별 남 여

sex<-c("남", "여", "여", "남") # factor형 -> 숫자형으로 변환
sex2 <- ifelse(sex=="남", 1, 0) # ifelse문
sex2

m2$X1 # $를 누르면, dataframe을 칼럼명으로 접근할 수 있음

m2$x4 <- c(1,2,3,4,5) # 이런 식으로 새로운  column 추가 가능
m2
