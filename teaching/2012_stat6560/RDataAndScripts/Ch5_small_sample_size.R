par(mfrow = c(2, 2))
set.seed(1234)
xvect = NULL
for(i in 1:4)
{
  x = rnorm(10)
  xvect = c(xvect, x)
  hist(x, main = "Unknown Distribution",
    xlab = "x-values")
}

par(mfrow = c(1, 1))
hist(xvect)


par(mfrow = c(2, 2))
set.seed(1234)
for(i in 1:4)
{
  qqnorm(rnorm(10), main = "Unknown Distribution",
    xlab = "x-values")
}

par(mfrow = c(1, 1))
qqnorm(xvect)
