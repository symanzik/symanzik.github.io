# L05a: loops


### typical for-loop (for demonstration purposes only)

for (i in 1:10) {
  print(i^2)
}

# note that a vectorized version is preferred !

(1:10)^2

# or working with sapply

sapply(1:10, "^", 2)

sapply(1:10, function(x) print(x^2))

# note that each produces a slightly different output/return value



### we can loop over any index set: integers

for (i in seq(1, 11, by = 2)) {
  cat(i, i^2, "\n")
}


### we can loop over any index set: numeric

for (i in seq(0.3, 0.7, by = 0.05)) {
  cat(i, i^2, "\n")
}


### we can loop over any index set: characters

for (i in letters[5:10]) {
  cat(i, toupper(i), "\n")
}


### we can loop over any index set: logic

for (i in c(TRUE, FALSE, NA)) {
  cat(i, ":", i & NA, i | NA, "\n")
}



### while loops

p = 0.25
sample(c(1, 0), size = 1, prob = c(p, 1 - p)) 


### Simulate number of tosses (= steps) to get 10 heads 

max.iter = 1000
x = 0
steps = 0

while (x < 10) {
  x = x + sample(c(0, 1), 1)
  steps = steps + 1
  if (steps == max.iter) {
    warning("Maximum iteration reached")
    break
  }
}

cat("Steps:", steps, "Successes:", x)


# Question: What is the expected number of steps to obtain x successes
# and what is the corresponding variance (depending on p)?

CalculateSteps = function(successes = 10, p = 0.5, max.iter = 1000) {
  x = 0
  steps = 0
  
  while (x < successes) {
    x = x + sample(c(0, 1), 1, prob = c(1 - p, p))
    steps = steps + 1
    if (steps == max.iter) {
      warning("Maximum iteration reached")
      break
    }
  }
  
  return(steps)
}

CalculateSteps()

CalculateSteps(max.iter = 10)

CalculateSteps(10, p = 0.25)

sample1 = sapply(rep(10, 1000), CalculateSteps)
mean(sample1)
var(sample1)
hist(sample1)

sample2 = sapply(rep(20, 1000), CalculateSteps)
mean(sample2)
var(sample2)
hist(sample2)

sample3 = sapply(rep(10, 1000), CalculateSteps, p = 0.25)
mean(sample3)
var(sample3)
hist(sample3)

sample4 = sapply(rep(10, 10000), CalculateSteps, p = 0.25)
mean(sample4)
var(sample4)
hist(sample4)

sample5 = sapply(rep(20, 10000), CalculateSteps, p = 0.25)
mean(sample5)
var(sample5)
hist(sample5)

