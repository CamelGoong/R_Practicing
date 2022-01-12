# sum of two dice
roll <- 100
dice <- ceiling(runif(roll) * 6) + ceiling(runif(roll) * 6)
a <- table(dice)
barplot(a)

a
a[1]
