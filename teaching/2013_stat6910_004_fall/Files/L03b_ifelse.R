# L03b: ifelse

# Refer to the functions in WritingFunctions.R
# The functions here are modifications of the functions in that document.


# Modify Convert to check if the input is a list
# If a list, use sapply

xlist = list(1:5)
xlist

Convert(xlist)

ConvertAll = function(x) {
  if (is.list(x)) {
    sapply(x, '*', 2.54) 
  } else {
    x * 2.54
  }
}

ConvertAll(xlist)

ConvertAll(c(1:5))


# Modify qqunif to optionally add a line

qqunifLine = function(data, qs = 0.01, addLine = FALSE) {
  UQuants = seq(qs, 1 - qs, by = qs)
  dataQs = quantile(data, probs = UQuants)
  plot(x = UQuants, y = dataQs, 
       xlab = "Uniform Quantiles", 
       ylab = "Empirical Quantiles",
       main = "Uniform QQ Plot", 
       xlim = c(0, 1))
  if (addLine) 
    abline(a = 0, b = 1, lwd = 3, col = "red")
}

qqunifLine(rnorm(200))

qqunifLine(rnorm(200), addLine = TRUE)

qqunifLine(rnorm(200), 0.05, addLine = TRUE)

qqunifLine(runif(100), addLine = TRUE)

qqunifLine(runif(100, -1, 1), 0.1, addLine = TRUE)


# Modify numInts to compute duration

numIntsDur = function(x, duration = FALSE) {
  if (duration) {
    floor(max(x) - min(x)) 
  } else {
    length(unique(floor(x)))
  }
}

numIntsDur(day$st050183)
numIntsDur(day$st050183, duration = TRUE)

numIntsDur(day$st050263)
numIntsDur(day$st050263, duration = TRUE)

sapply(day, numIntsDur)
sapply(day, numIntsDur, duration = TRUE)


# Add a check to see if the x and y are the same length

# x is a vector and 
# y is a vector the same length as x.

distToPtCheck = function(x, y, point = c(0, 0)) {
  if (length(x) != length(y)) 
    stop("x and y must be the same length")
  sqrt((x - point[1])^2 + (y - point[2])^2)
}

distToPtCheck(1, 1)
distToPtCheck(1, 1:2)

distToPtCheck(1, 1, point = c(2, 2))
distToPtCheck(1:5, 1:5, point = c(2, 2))
distToPtCheck(1:5, 1:4, point = c(2, 2))


### Search Path & Objects

search()

objects()

objects(1)

objects(5)

objects("package:datasets")


# Masking an object and extracting an object from an environment

cars

cars = 1:10

cars

envr.cars = get("cars", envir = as.environment("package:datasets"))

envr.cars


