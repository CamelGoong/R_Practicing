# cbind rbind

m<-matrix(1:15, ncol=3, byrow = T)
m

m2 = data.frame((m))
m2

cbind(m2, c(3,2,4,5,5)) # cbind: column bind 의 약자로, 인수로 받는 2개를 column으로 묶는 것
rbind(m2, c(3,2,4,5))
cbind(m2, m2)
rbind(m2, m2)

# for문

for(i in 1:10){
  print(i)
}

for(j in c(1,3,5,7)){
  print(j)
}

m2

m3 <- null # 빈값 선언
for(i in 1:10){
  
m3 <- rbind(m3,m2)
print(i)  
print(dim(m3))
}

## if 문

m3 <- NULL

for (i in 1:10){
  if(i %% 2 ==0){
    next; # 넘어가
  }

  cat("\n",i) #print와 역할은 동일 / \n은 enter \t은 tab / for문을 사용할 때는 error가 발생했을 때, 손쉬운 확인을 위해서 항상 cat을 같이 써줄 것!

}

# if-else문

for (i in 1:10){
  if(i %% 2 == 0){
    
  }
  
  else{
    m3<- rbind(m3,m2)
  }
  cat("\n", i)
}

dim(m3)



