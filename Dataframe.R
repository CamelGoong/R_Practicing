name <- c('John', 'Jaehee', 'juliet', "James")
sex <- c("f", "f", "f", "m")
occup <- c('athlete', 'doctor', 'ceo', 'analyst')
age <- c(40, 35, 43, 29)

#데이터프레임 만들기
member = data.frame(name, sex, occup, age)
member

# 원소 선택하기
member[1] # 첫번째 열
member[1,]

member[1,] # 첫번째 행
member$name
member$sex
member[2,3] # Jaehee의 occup

member[1,2] = "m" # John의 성별 바꾸기
member
