		#########################
		#  Brittany Allred	#
		#  Graphics in the Stat #
		#  Classroom		#
		#  Stat 6560 Project #1	#
		#  2 Examples		#
		#########################

###############  Example 1 Histograms and goodness of fit
par(mfrow=c(2,2))
# Ex 1 (Data in R - "miles flown by commercial airlines in the United States for each year from 1937 to 1960.")
head(airmiles)
hist(airmiles, freq=FALSE, prob=TRUE, main="Miles flown in US from 1937-1960")
plot(function(x) dnorm(x,m=(ave(airmiles)),s=sd(airmiles)), 
	min(airmiles), max(airmiles), n=1000, add=TRUE, col="red", lwd=2)

# Ex 2 (Data in R - stopping distance and speed of 1920's cars)
head(cars)
speed <- cars$speed
hist(speed, freq=FALSE, prob=TRUE, main="Speed of 1920's cars")
plot(function(x) dnorm(x,m=(ave(speed)),s=sd(speed)), 
	min(speed), max(speed), n=1000, add=TRUE, col="red", lwd=2)

# Ex 3 (Data from a Stat 1040 Class - Number of Siblings each student had)
sibs <- c(3,3,8,2,4,4,3,5,3,3,2,1,4,4,6,5,5,7,4,4,2,4,7,2,10,3,6,2,2,3,8,1,3,3,6,4,2,2,3,3,5)
hist(sibs, freq=FALSE, prob=TRUE, main="Number of Siblings - 1040 Data")
plot(function(x) dnorm(x,m=(ave(sibs)),s=sd(sibs)), 
	min(sibs), max(sibs), n=1000, add=TRUE, col="red", lwd=2)

# Ex 4 (Data from a Stat 1040 Class - average hours of sleep a night)
sleep <- c(7,7,8,7,6,8,8,6,7,6,6,6,7,6,7,7,7,5,7,7,6,7,8,6,6,6,7,7,7,6,6,7,7,6,6,7,7,8,6,7,6,5,7,8,7,7,7)
hist(sleep, freq=FALSE, prob=TRUE, main="Hours of sleep/night - 1040 Data")
plot(function(x) dnorm(x,m=(ave(sleep)),s=sd(sleep)), 
	min(sleep), max(sleep), n=1000, add=TRUE, col="red", lwd=2)


###############  Example 2 Linear Regression

anscombe
x1 <- anscombe$x1; x2 <- anscombe$x2; x3 <- anscombe$x3; x4 <- anscombe$x4
y1 <- anscombe$y1; y2 <- anscombe$y2; y3 <- anscombe$y3; y4 <- anscombe$y4

# average of the data
apply(anscombe, 2 ,FUN=ave)

# standard devaiton of the data
apply(anscombe, 2, FUN=sd)

# correlation
cor1 <- cor(x1, y1); cor2 <- cor(x2, y2); cor3 <- cor(x3, y3); cor4 <- cor(x4, y4)
correlation <-cbind(cor1, cor2, cor3, cor4)
correlation

#### Regression 
par(mfrow=c(2,2))
# x1 vs. y1
	set1 <- lm(y1~x1); set1
	plot(x1, y1, xlab = "x values", ylab = "y values", pch = 16, main="x1 vs. y1")
	abline(a=3.0001, b=0.5001, col="blue", lwd=2)
# x2 vs. y2
	set2 <- lm(y2~x2); set2
	plot(x2, y2, xlab = "x values", ylab = "y values", pch = 16, main="x2 vs. y2")
	abline(a=3.001, b=0.500, col="blue", lwd=2)
# x3 vs. y3
	set3 <- lm(y3~x3); set3
	plot(x3, y3, xlab = "x values", ylab = "y values", pch = 16, main="x3 vs. y3")
	abline(a=3.0025, b=0.4997, col="blue", lwd=2)
# x4 vs. y4
	set4 <- lm(y4~x4); set4
	plot(x4, y4, xlab = "x values", ylab = "y values", pch = 16, main="x4 vs. y4")
	abline(a=3.0017, b=0.4999, col="blue", lwd=2)

#### Residuals
par(mfrow=c(2,2))
set1.r <-resid(set1)
	plot(set1.r, main="Residuals x1 vs. y1", pch=16)
	abline(a=0, b=0, lwd=2, col="green")
set2.r <-resid(set2)
	plot(set2.r, main="Residuals x2 vs. y2", pch=16)
	abline(a=0, b=0, lwd=2, col="green")
set3.r <-resid(set3)
	plot(set3.r, main="Residuals x3 vs. y3", pch=16)
	abline(a=0, b=0, lwd=2, col="green")
set4.r <-resid(set4)
	plot(set4.r, main="Residuals x4 vs. y4", pch=16)
	abline(a=0, b=0, lwd=2, col="green")





