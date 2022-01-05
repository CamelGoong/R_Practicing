m <- matrix(1:15, ncol=3, byrow = T)
m2 = data.frame(m)
colnames(m2) <- paste0("v", 1:3)
m2


getwd() # working directory 가져오는 방법
setwd("C:\\Users\\goong\\Desktop\\R_practicing") # 기존의 역슬래시가 하는 특수 역할이 있기 때문에, 역슬래시를 하나 더 붙여서 그 기능을 무력화

getwd()

rownames(m2)
write.csv(m2, "m2.csv")
aaa <- read.csv("m2.csv", row.names = F) 
dim(aaa) # 불러들일 때는 원래 기존의 rownames들이 추가적인 열로 인식이 됨.
aaa

save(m2, file = "m2.RData") # r 파일로 저장
load("m2.RData")
m2

# r은 csv와 달리 vector, dataframe, array, list 등의 다양한 형태의 데이터들이 그대로 저장이 되고, 그대로 불러올 수 있음. 그러나 csv는 데이터가 깨질 수도 있고, 그대로 파일의 형태 그대로를 불러들일 수 없음.
