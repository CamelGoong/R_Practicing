## while문
i<-1

while(i<100){
  
  if(i>50){
    break;
  }
  print(i)
  i <- i + 1
}

# 일반적으로는 for문을 while문보다 많이 사용 / while문은 무언가의 값이 정해져있지 않을 때, 사용을 함
i<-100

while(i>0.01){
i <- i-runif(1, min = -0.001, max = 0.01) # 난수 추출
print(i)

}

# 크롤링할 때, 네트워크 속도에 따라서, 크롤링 여부가 결정되기 때문에, 될 때까지 while문을 돌리기도 하나, 일반적으로는 while문을 많이 사용하지는 않음

