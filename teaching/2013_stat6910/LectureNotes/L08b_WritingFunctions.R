# L08b: WritingFunctions

load(url("http://www.math.usu.edu/~symanzik/teaching/2012_stat5810/LectureNotes/rainfallCO.rda"))

# Convert inches to centimeters

Convert = function(x) x * 2.54 

Convert(1:5)

Convert(c(0.6, 2.4))


# Find the number of unique years a station is
# in operation

numInts = function(x) {
  length(unique(floor(x)))
}

numInts(day$st050183)

numInts(day$st050263)

sapply(day, numInts)


objects()

# Notice that Convert & numInts now are objects in our workspace.


# We can ask what class it is:

class(numInts)

# [1] "function"
# It is a function object.


# We can print its value to the screen:

numInts

#function(x) {
#  length(unique(floor(x)))
#}

# We see that is not the same as calling the function.
# Instead we get to see the code that would be executed 
# when we call the function


# Let's write a function to make a uniform quantile plot
# What will be the input arguments to this function? 
# Notice that qs has a default value, and data does not.

qqunif = function(data, qs = 0.01) {
  UQuants = seq(qs, 1 - qs, by = qs)
  dataQs = quantile(data, probs = UQuants)
  plot(x = UQuants, y = dataQs, 
       xlab = "Uniform Quantiles", 
       ylab = "Empirical Quantiles",
       main = "Uniform QQ Plot", 
       xlim = c(0, 1))
}

qqunif(rnorm(200))

qqunif(rnorm(200), 0.05)

qqunif(runif(100))

qqunif(runif(100, -1, 1), 0.1)


# Next we write a function that will compute 
# the distance from each set of (x,y) pairs 
# in a set of vectors to a single(x,y) pair. 

# x is a vector and 
# y is a vector the same length as x.

distToPt = function(x, y, point = c(0, 0)) {
  sqrt((x - point[1])^2 + (y - point[2])^2)
}

distToPt(1, 1)

distToPt(1, 1, point = c(2, 2))

distToPt(1:10, 1:10, point = c(2, 2))

