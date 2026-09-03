# L16: CoinToss

coin = c(0, 1)
sample(coin, 1, replace = TRUE)


n = 10
tosses = sample(coin, n, replace = TRUE)
cumsum(tosses) / (1:n)


n = 1000
tosses = sample(coin, n, replace = TRUE)
cumProp = cumsum(tosses) / (1:n)

plot(x = 1:n, y = cumProp, type = "l", 
     ylim = c(0.3, 0.7))
abline(h = 0.5, col = "red")


coinToss = function(n, coin = c(0, 1), 
                    addPoints = TRUE) {
  tosses = sample(coin, n, replace = TRUE)
  cumProp = cumsum(tosses) / (1:n)
  colT = rgb(190, 190, 190, 64, maxColorValue = 255)
  
  if (addPoints) {
    points(x = 1:n, y = cumProp, type = "l",
           col = colT)
  } else {
    plot(x = 1:n, y = cumProp, type = "l", 
         ylim = c(0.3, 0.7))
    abline(h = 0.5, col = "red")
  }
  return(cumProp[n])
}

simFlips = function(reps = 400, m = 100) {
  firstFinal = coinToss(m, addPoints = FALSE)
  finalVals = sapply(2:reps, function(x) coinToss(m))
  return(c(firstFinal, finalVals))
}

simFlips2 = function(reps = 400, m = 100) {
  finalVals = numeric(length = reps)
  finalVals[1] = coinToss(m, addPoints = FALSE)
  for (i in 2:reps)
    finalVals[i] = coinToss(m)
  return(finalVals)
}


par(mfrow = c(1, 2))
SimFlipsProp = simFlips(20)
hist(SimFlipsProp, freq = FALSE, 
     xlim = c(0.2, 0.8),
     ylim = c(0, 15),
     breaks = seq(0.2, 0.8, by = 0.05))


par(mfrow = c(1, 2))
SimFlipsProp = simFlips(20, 1000)
hist(SimFlipsProp, freq = FALSE, 
     xlim = c(0.4, 0.6),
     ylim = c(0, 50),
     breaks = seq(0.4, 0.6, by = 0.0125))


par(mfrow = c(1, 2))
SimFlipsProp = simFlips(100, 1000)
hist(SimFlipsProp, freq = FALSE, 
     xlim = c(0.4, 0.6),
     ylim = c(0, 50),
     breaks = seq(0.4, 0.6, by = 0.0125))


par(mfrow = c(1, 2))
SimFlipsProp = simFlips(1000, 1000)
hist(SimFlipsProp, freq = FALSE, 
     xlim = c(0.4, 0.6),
     ylim = c(0, 50),
     breaks = seq(0.4, 0.6, by = 0.0125))

dev.off()


# MyRand

myRand = function(a = 3, b = 64, seed = 17) {
  return((a * seed) %% b)
}


n = 20
x3b64 = numeric(length = n)
x3b64[1] = myRand()
for (i in 2:n)
  x3b64[i] = myRand(seed = x3b64[i - 1])

plot(x3b64[1:(n-1)], x3b64[2:n], 
     xlab = "current value",
     ylab = "next value")


n = 1000
x3b64 = numeric(length = n)
x3b64[1] = myRand(a = 69069, b = 2^32)
for (i in 2:n)
  x3b64[i] = myRand(a = 69069, b = 2^32, seed = x3b64[i - 1])

plot(x3b64[1:(n-1)], x3b64[2:n], 
     xlab = "current value",
     ylab = "next value")

