# uniform distribution simulate
# p = 1/n, n of die = 6

roll <- 10000 # 주사위를 몇번 굴리는지

n <- 6 # 6개짜리 경우의 수가 있음

die <- ceiling(runif(roll)*n) # random한 값을 uniform하게 100개를 형성 / ceiling은 숫자를 올림하겠다

b <- table(die) # 각 숫자들이 몇개 나왔는지 집계하는 함수수

barplot(b) # 테이블을 barplot으로 그림

