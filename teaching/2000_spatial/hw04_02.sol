Stat 5810, Homework #4.2 - Solutions
------------------------------------

2) Index of Dispersion Test:

idtbasic _ function (spp, m = 7, A = 0.01)
{
  ### a help function that does the counting
  ### there is no optimization done at all to make this fast

  # extract the basics from the SPP

  x _ spp[,1]
  xmax _ max (x)
  xmin _ min (x)
  y _ spp[,2]
  ymin _ min (y)
  ymax _ max (y)

  # plot the SPP

  plot (spp,
    main = paste( "SPP with", as.character(m), "Quadrats of Area", 
      as.character(A), collapse = "" ))

  count _ rep(0, m)
  k _ 1

  Awidth _ sqrt(A) / 2

  # create the m quadrats

  while (k <= m)
  {
    # determine the coordinates of the corners of a quadrat

    xcenter _ runif (1, xmin, xmax)
    ycenter _ runif (1, ymin, ymax)
    xl _ xcenter - Awidth
    xu _ xcenter + Awidth
    yl _ ycenter - Awidth
    yu _ ycenter + Awidth

    # check if the quadrat entirely falls into the region of interest

    if (xl >= xmin && xu <= xmax && yl >= ymin && yu <= ymax) 
    {
      # draw the quadrat

      lines (c(xl, xu, xu, xl, xl), c(yl, yl, yu, yu, yl), type = "l")

      # count the number of points in the quadrat

      for (i in (1:nrow (spp)))
      {
        if (x[i] >= xl && x[i] <= xu && y[i] >= yl && y[i] <= yu)
          count[k] _ count[k] + 1
      }

      k _ k + 1
    }
  }

  # check if the mean count is > 1.0

  if (mean (count) <= 1.0)
  {
    cat ("The mean count is", mean (count), " \n")
    cat ("This value should be > 1.0 to be meaningful. \n")
    cat ("Please rerun this function with a larger value for A. \n")
    return (-1)
  }
  else
    return (count)
}


idttest _ function (spp, m = 7, A = 0.01, alpha = 0.05)
{
  ### the main function that performs the test

  m _ as.integer(m)

  # check that m is appropriate

  while (m < 7)
  {
    cat("m must be >= 7. \n")
    cat("Please input a new value for m. \n")
    mstring _ readline()
    m _ as.integer (mstring)
  }

  # check that alpha is appropriate

  while (alpha <= 0 || alpha >= 0.5)
  {
    cat("alpha must be in the interval (0, 0.5). \n")
    cat("Please input a new value for alpha. \n")
    alphastring _ readline()
    alpha _ as.numeric (alphastring)
  }

  # call the help function

  idtcount _ idtbasic (spp, m, A)

  if (idtcount[1] < 0)
    return(F)

  # calculate the test statistic and critical values

  x2 _ (m - 1) * var(idtcount) / mean(idtcount)

  x2l _ qchisq (alpha / 2, m - 1)
  x2u _ qchisq (1 - alpha / 2, m - 1)

  if (x2 < x2l || x2 > x2u)
    {
      cat("Reject H0: CSR for alpha =", alpha, fill = T)
      cat("The observed value of", x2, "does not fall into the intervall (")
      cat(x2l, ",", x2u, ")", fill = T)
    }
  else
    {
      cat("Do not reject H0: CSR for alpha =", alpha, fill = T)
      cat("The observed value of", x2, "falls into the intervall (")
      cat(x2l, ",", x2u, ")", fill = T)
    }
}


##### now some testing

# to reduce the overplotting, we are just using the first 100 points 
# from quakes.bay to demonstrate these two functions

xx.spp _ quakes.bay[1:100,]

par (mfrow = c(2, 2), oma = c(0, 0, 4, 0))
mtext ("HW 4, Question 2", side = 3, outer = T, cex = 1.2, line = 0)

idttest (xx.spp, 5, 0.01)

idttest (xx.spp, 10, 0.25)

idttest (xx.spp, 6, 0.25, 0.01)

idttest (xx.spp, 7, 0.2, 0)

# upper left plot

> idttest (xx.spp, 5, 0.01)
m must be >= 7. 
Please input a new value for m. 
2
m must be >= 7. 
Please input a new value for m. 
7
The mean count is 0.285714285714286  
This value should be > 1.0 to be meaningful. 
Please rerun this function with a larger value for A. 
[1] F

# upper right plot

> idttest (xx.spp, 10, 0.25)
Reject H0: CSR for alpha = 0.05
The observed value of 157.488372093023 does not fall into the 
intervall (2.70038949998036 , 19.0227677986416 )

# lower left plot

> idttest (xx.spp, 6, 0.25, 0.01)
m must be >= 7. 
Please input a new value for m. 
10
Reject H0: CSR for alpha = 0.01
The observed value of 26.0952380952381 does not fall into the 
intervall (1.73493290499667 , 23.5893507812574 )

# lower right plot

> idttest (xx.spp, 7, 0.2, 0)
alpha must be in the interval (0, 0.5). 
Please input a new value for alpha. 
0.01
Reject H0: CSR for alpha = 0.01
The observed value of 92 does not fall into the 
intervall (0.675726777455467 , 18.5475841785111 )

# since all those observed values are greater than the upper critical value,
# this test reports clustering for the first 100 observations of
# the quakes.bay data set (we should get a similar result when using
# the full data set)

# use these commands to open and close a postscript file, respectively
# postscript("HW4Q2.ps")
# dev.off()

=============================================================================

4) Obtain the distribution of days between earthquakes:

# transfer the date format from the string format used
# in the data set to the internal date format

date.str _ dates (quakes.bay$date)

# calculate the julian dates and determine the difference
# note that the data is already sorted by date - otherwise,
# an extra step would be needed

date.julian _ julian (months(date.str), days(date.str), years(date.str))
date.diff _ diff (date.julian)

# plot a histogram

par (mfrow = c(2, 3), oma = c(0, 0, 4, 0))
hist (date.diff, main = "(a) Histogram of Difference in Days")
mtext ("HW 4, Question 4", side = 3, outer = T, cex = 1.2, line = 0)

# doesn't this look like an exponential distribution?
# note that the ML estimate for the exponential is 1 / mean

mean (date.diff)
length (date.diff)
date.julian[length (date.julian)] - date.julian[1]

# The result is 
# [1] 3.55957
# [1] 2048
# [1] 7290
#
# i.e., the mean date difference in days is 3.55957,
# we have 2048 + 1 recorded earthquakes in an observation
# period of 7290 days (about 20 years between 01/04/62 and 12/20/81)

# by the way, the following gives us the same result - 
# so we really didn't need the julian function

date.diff.2 _ diff (date.str)
mean (date.diff.2)
length (date.diff.2)

# The result is 
# [1] 3.55957
# [1] 2048

date.rate _ 1 / (mean (date.diff))

# note that S-Plus needs the rate which is defined as 1/mean

plot (sort(date.diff), qexp((1:date.len - 0.5) / date.len, date.rate),
  xlab = "Observed Date Differences", ylab = "Theoretical Percentiles",
  main = "(b) Not quite perfect")
abline(0, 1)

# this QQ plot doesn't look perfect - but if we experimentially
# increase the rate up to 1 / 4.4, we get some reasonably looking
# QQ plot 

plot (sort(date.diff), qexp((1:date.len - 0.5) / date.len, 1 / 4.4),
  xlab = "Observed Date Differences", ylab = "Theoretical Percentiles",
  main = "(c) Better with mean = 4.4")
abline(0, 1)


### Finally, we do some simulation experiments: we simulate 2049 observations
# from an exp distribution with rate = date.rate = 1 / 3.55957.
# We bin the data (by truncating each value) and count how many observations
# fall in each bin. We repeat this 100 times.
# Then we extract the minimum and maximum number of counts in each bin.

datemat _ rep (0, 50)
for (j in 0:49)
  datemat[j + 1] _ sum (date.diff == j)


simexpmat _ matrix(0, 100, 50)

for (i in 1:100)
{
  expsim _ trunc (rexp (2049, date.rate))
  for (j in 0:49)
    simexpmat[i, j + 1] _ sum (expsim == j)
}

simexpmat.min _ apply (simexpmat, 2, min)
simexpmat.max _ apply (simexpmat, 2, max)

plot (0:49, datemat, "(d) Bins and Simulation Env's")
lines (0:49, simexpmat.min)
lines (0:49, simexpmat.max)

# Since this is hard to see in the plot, here are the numbers:

> simexpmat.min
 [1] 457 335 252 184 131 100  73  47  37  21  16  15  10   4   2   1   1   1   0
[20]   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0
[39]   0   0   0   0   0   0   0   0   0   0   0   0
> datemat
 [1] 565 349 251 169 138 104  91  91  46  41  30  32  28  19  18  12  15  10   6
[20]   7   6   1   3   4   4   3   0   1   0   0   1   2   0   1   0   0   0   0
[39]   0   0   0   0   0   0   0   0   0   0   0   0
> simexpmat.max
 [1] 551 423 337 249 202 153 131  90  75  54  44  36  26  23  19  14  14  10   8
[20]   7   8   6   5   4   3   3   3   2   2   2   1   1   1   2   1   1   1   0
[39]   1   0   0   0   1   0   0   0   0   0   0   0

# Most notably, there are too many observations (565) in bin 0 since
# that 99% confidence interval is [457, 551] and too few observations (169)
# in bin 3 since that 99% confidence interval is [184, 249].
#
# So, an exp distribution with this rate is indeed very unlikely.
# But, what about an exp distribution with rate = 1 / 3.4 ?

simexpmat2 _ matrix(0, 100, 50)

for (i in 1:100)
{
  expsim _ trunc (rexp (2049, 1 / 3.4))
  for (j in 0:49)
    simexpmat2[i, j + 1] _ sum (expsim == j)
}

simexpmat2.min _ apply (simexpmat2, 2, min)
simexpmat2.max _ apply (simexpmat2, 2, max)

plot (0:49, datemat, "(e) Bins and Simulation Env's")
lines (0:49, simexpmat2.min)
lines (0:49, simexpmat2.max)

# Again, the results are hard to see in a plot - so here are the numbers:

>  simexpmat2.min
 [1] 463 348 243 188 131  96  72  48  31  26   9   9   6   3   2   1   0   0   0
[20]   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0
[39]   0   0   0   0   0   0   0   0   0   0   0   0
> datemat
 [1] 565 349 251 169 138 104  91  91  46  41  30  32  28  19  18  12  15  10   6
[20]   7   6   1   3   4   4   3   0   1   0   0   1   2   0   1   0   0   0   0
[39]   0   0   0   0   0   0   0   0   0   0   0   0
> simexpmat2.max
 [1] 560 434 326 254 198 146 111  89  66  55  41  34  29  20  16  11   9  11   7
[20]   6   6   3   4   2   3   2   2   2   1   1   1   2   1   1   1   1   1   1
[39]   1   0   0   1   0   0   0   0   0   0   0   0

# Still, some observed numbers fall outside their confidence interval -
# but note, these are simulations. Next time, we may get slightly
# different intervals! So, an exp distribution does not seem impossible.
# Note one thing: the QQplot suggests a larger mean than the one
# observed from the data while simulation suggests a smaller mean 
# than the one observed to better describe the data.

# use these commands to open and close a postscript file, respectively
# postscript("HW4Q4.ps")
# dev.off()

=============================================================================

5) Determine the distribution of the Byth & Ripley statistic under H0:

# From Section 2.4.3, we know that 
#    pi X^2 ~ Exp(lambda)
# and
#    pi W^2 ~ Exp(lambda)

# The Byth & Ripley test statistic pairs x_i values randomly with w_i values.
# Thus, under H0, we divide a value of an exp distribution by the same
# value plus a value of an another independent exp distribution.
# By simulation, we see that this ratio relates to a Uniform(0,1) distribution.

# A random variable U that has a Uniform(0,1) distribution 
# has mean 1/2 and variance 1/12. Therefore, it follows by the
# Central Limit Theorem that Ubar (i.e., the mean of m independent
# Uniform(0,1) observations) is approximately Normal distributed
# with mean 1/2 and variance 1 / (12 m).

# Below, we conduct simulation runs for two different rates (1 and 10).
# We create m = 1000 pairs of independent x_i and w_i values and
# calculate the test statistic, i.e., the mean.
# We plot a histogram of the last simulation run of the ratio
# (x_i / (x_i + w_i)) and notice that this appears to be Uniform(0,1).

# We repeat this part 5000 times. Then we plot a histogram from
# the 5000 means we obtained. This appears to be Normal.
# Finally, we compare the observed means with the theoretical
# percentiles of a N(1 / 2, 1 / (12 * 1000)) distribution
# and obtain a perfect match in our QQ plot.


par (mfrow = c(2, 3), oma = c(0, 0, 4, 0))
mtext ("HW 4, Question 5", side = 3, outer = T, cex = 1.2, line = 0)

### exp with rate = 1

means _ rep(0, 5000)

for (i in 1:5000)
{
  w _ rexp(1000)
  x _ rexp(1000)

  ts _ x / (x + w)
  means[i] _ mean(ts)
}

hist (ts, main = "(a) Last Simulation (rate = 1)")
hist (means, main = "(b) Means (rate = 1)")
plot (sort (means), qnorm( (1:5000 - 0.5) / 5000,
   mean = 0.5, sd = sqrt(1 / (12 * 1000))),
   xlab = "Sorted Means", ylab = "Theoretical Percentiles",
   main = "(c) QQ Plot (rate = 1)")

### exp with rate = 10

means10 _ rep(0, 5000)

for (i in 1:5000)
{
  w _ rexp(1000, 10)
  x _ rexp(1000, 10)

  ts10 _ x / (x + w)
  means10[i] _ mean(ts10)
}

hist (ts10, main = "(d) Last Simulation (rate = 10)")
hist (means10, main = "(e) Means (rate = 10)")
plot (sort (means10), qnorm( (1:5000 - 0.5) / 5000,
   mean = 0.5, sd = sqrt(1 / (12 * 1000))),
   xlab = "Sorted Means", ylab = "Theoretical Percentiles",
   main = "(f) QQ Plot (rate = 10)")

# use these commands to open and close a postscript file, respectively
# postscript("HW4Q5.ps")
# dev.off()

