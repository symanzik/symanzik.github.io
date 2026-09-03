# L18a: More Simulations

### Inspect random numbers from a historic VAX FORTRAN implementation

data(randu)
class(randu)
dim(randu)

pairs(randu)

library(rgl)

plot3d(randu)


### How can we determine pi via simulation ?!?

squarePoints = cbind(runif(100, -1, 1), runif(100, -1, 1))
plot(squarePoints, xlim = c(-1, 1), ylim = c(-1, 1))

onCircle = seq(0, 2 * pi, length = 360)
points(sin(onCircle), cos(onCircle), type = "l")


insideCircle = (squarePoints[, 1]^2 + squarePoints[, 2]^2 <= 1)
plot(squarePoints, col = ifelse(insideCircle, "red", "grey"),
     xlim = c(-1, 1), ylim = c(-1, 1))

points(sin(onCircle), cos(onCircle), type = "l")


# fraction of points inside circle

sum(insideCircle) / 100 * 4


# translate this code into a function

EstimatePi = function(n = 100, plotIt = TRUE) {
  squarePoints = cbind(runif(n, -1, 1), runif(n, -1, 1))
  insideCircle = (squarePoints[, 1]^2 + squarePoints[, 2]^2 <= 1)
  
  if (plotIt) {
    onCircle = seq(0, 2 * pi, length = 360)
    plot(squarePoints, col = ifelse(insideCircle, "red", "grey"),
         xlim = c(-1, 1), ylim = c(-1, 1))
    points(sin(onCircle), cos(onCircle), type = "l")
  }
  
  return(sum(insideCircle) / n * 4)
}

EstimatePi(1000)
EstimatePi(10000)
EstimatePi(100000)

EstimatePi(1000000, plotIt = FALSE)
EstimatePi(10000000, plotIt = FALSE)


# 95% CI for our pi estimate, based on 100 samples of size 1,000,000

multiplePiEstimates = sapply(1:100, function(x) EstimatePi(n = 1000000, plotIt = FALSE))

quantile(multiplePiEstimates, probs = c(0.025, 0.5, 0.975))


