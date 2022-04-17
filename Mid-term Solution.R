library(dplyr)
library(ggplot2)

# 1번 문제

# 1.1
setwd("C:/Users/goong/Desktop/IMEN491R_midterm")
diamonds <- read.csv("diamonds.csv")
head(diamonds)
# 1
str(diamonds)
attach(diamonds)
# 2
mean(price)
a <- select(diamonds, price)
a <- filter(a, price > 3930)
a

# 1.2
par(mfrow = c(1,2))
hist(price, col = "lightblue", main = "Histogram of Price")
hist(carat, col = "coral", main = "Histogram of Carat")

par(mfrow = c(1,2))
boxplot(price, col = "lightblue", boxwex = 0.5, main = "Boxplot of Price")
boxplot(carat, col = "coral",  boxwex = 0.5, main = "Boxplot of Carat")
summary(diamonds)

# 1.3
ggplot(diamonds, aes(cut, price)) + geom_boxplot()

# 1.4
#(1)
clarity <- filter(diamonds, clarity=="I1" | clarity=="SI1" | clarity=="VS1")
clarity

#(2)
b <- lm(clarity$price~clarity$carat)
summary(b)
# (3)
si <- filter(clarity, clarity == "SI1")
c1 <- lm(si$carat~si$price)
head(si)
summary(c1)
# (4)
attach(si)
detach(si)
ggplot(si, aes(si$carat, si$price)) + geom_point()

# (5)
round(cor(si$carat, si$price),4)

# 2번 문제

# 2.1
US <- read.csv("USecon.csv")
attach(US)
west <- filter(US, WEST == 1)
west %>% arrange(ECAB)

# 2.2
t.test(ECAB~WEST, data = US)

# mean
east <- filter(US, WEST == 0)

mean(west$ECAB)
mean(east$ECAB)

arrange(US, ECAB)

# 2.3
cor(GROW, ECAB)

ggplot(US, aes(GROW, ECAB)) + geom_point(aes(color = WEST))
arrange(US, GROW)

US_exclude <- subset(US, STATE != "NV")
US_exclude

cor(US_exclude$GROW, US_exclude$ECAB)

# 2.4
result <- lm(ECAB~EX + YOUNG)
result
summary(result)

layout(matrix(c(1,2,3,4), 2, 2))
plot(result)
