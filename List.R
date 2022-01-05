# list
lista <- list()
lista

m <- matrix(1:15, ncol=3, byrow = T)
m2 = data.frame(m)

lista[[1]] <- m2
lista[[2]] <- c(1,2,3)
lista[[3]] <- c("a", "b", "c")

lista

# 리스트는 큰 방과 작은 방으로 이루어져있음.

# 이런식으로 3번째 큰 방의 작은 방들에 접근할 수 있음.
lista[[3]][1]
lista[[3]][2]

aa <- lista[[1]][1,]
aa[1]

save(lista, file = "lista.RData") # list는 csv형식이  아니라, RData 형식으로 저장해야 함.
load("lista.RData")
lista
m2

m[,1] <- as.character(m[,1])

m <- data.frame(m)
m
str(m)
for(i in 1:ncol(m)){
  m[,i] <- as.numeric(m[,i])
}

str(m)
