jpeg("Chapter5_unknown_hist.jpg")

par(mfrow = c(2, 2))
set.seed(1234)
xvect1 = NULL

for(i in 1:4)
{
  x = rnorm(10)
  xvect1 = c(xvect1, x)
  hist(x, main = "Unknown Distribution",
    xlab = "x-values")
}

dev.off()


jpeg("Chapter5_unknown_qqplot.jpg")

par(mfrow = c(2, 2))
set.seed(1234)
xvect2 = NULL

for(i in 1:4)
{
  x = rnorm(10)
  xvect2 = c(xvect2, x)
  qqnorm(x, main = "Unknown Distribution",
    xlab = "Normal Quantiles")
}

dev.off()


# Plot all data combined

par(mfrow = c(1, 1))
hist(xvect1)

par(mfrow = c(1, 1))
qqnorm(xvect2)

