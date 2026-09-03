# calculate some summary statistics (separately for the 
# four columns of X's and Y's)

# mean of the X's
mean(anscombe$x1)
mean(anscombe$x2)
mean(anscombe$x3)
mean(anscombe$x4)

# mean of the Y's
mean(anscombe$y1)
mean(anscombe$y2)
mean(anscombe$y3)
mean(anscombe$y4)

# standard deviation of the X's
sqrt(var(anscombe$x1))
sqrt(var(anscombe$x2))
sqrt(var(anscombe$x3))
sqrt(var(anscombe$x4))

# standard deviation of the Y's
sqrt(var(anscombe$y1))
sqrt(var(anscombe$y2))
sqrt(var(anscombe$y3))
sqrt(var(anscombe$y4))

# correlation coefficient
cor(anscombe$x1, anscombe$y1)
cor(anscombe$x2, anscombe$y2)
cor(anscombe$x3, anscombe$y3)
cor(anscombe$x4, anscombe$y4)

# slope of the regression line
slope1 = cor(anscombe$x1, anscombe$y1) * sqrt(var(anscombe$y1)) / sqrt(var(anscombe$x1))
slope2 = cor(anscombe$x2, anscombe$y2) * sqrt(var(anscombe$y2)) / sqrt(var(anscombe$x2))
slope3 = cor(anscombe$x3, anscombe$y3) * sqrt(var(anscombe$y3)) / sqrt(var(anscombe$x3))
slope4 = cor(anscombe$x4, anscombe$y4) * sqrt(var(anscombe$y4)) / sqrt(var(anscombe$x4))
slope1
slope2
slope3
slope4

# intercept of the regression line
intercept1 = mean(anscombe$y1) - slope1 * mean(anscombe$x1)
intercept2 = mean(anscombe$y2) - slope2 * mean(anscombe$x2)
intercept3 = mean(anscombe$y3) - slope3 * mean(anscombe$x3)
intercept4 = mean(anscombe$y4) - slope4 * mean(anscombe$x4)
intercept1
intercept2
intercept3
intercept4

# rms error
rmserror1 = sqrt(1 - cor(anscombe$x1, anscombe$y1)^2) * sqrt(var(anscombe$y1))
rmserror2 = sqrt(1 - cor(anscombe$x2, anscombe$y2)^2) * sqrt(var(anscombe$y2))
rmserror3 = sqrt(1 - cor(anscombe$x3, anscombe$y3)^2) * sqrt(var(anscombe$y3))
rmserror4 = sqrt(1 - cor(anscombe$x4, anscombe$y4)^2) * sqrt(var(anscombe$y4))
rmserror1
rmserror2
rmserror3
rmserror4

