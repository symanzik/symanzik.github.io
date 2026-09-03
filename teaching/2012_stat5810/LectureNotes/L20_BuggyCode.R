# L20: BuggyCode

# V1
# Here is a function that has been written to
# generate random Poisson scatter on an interval of length "L"
# with a rate of lambda per unit 

mybug = function(L, lambda) {
  numHits = rpois(L*lambda))
  hitLocs = runif(o, numHits)
  return(numHits, hitLocs)
}

# This is the error that I get when I run the function
# Error: unexpected ')' in:
# "mybug = function(L, lambda) {
#    numHits = rpois(L*lambda))"...



#V2
# Fix that error of the extra ) 
# And source in the code again.

mybug = function(L, lambda) {
	numHits = rpois(L*lambda)
	hitLocs = runif(o, numHits)
	return(numHits, hitLocs)
}

mybug(10, 1)

# Now I get the following error
# Error in rpois(L * lambda) : 
#   argument "lambda" is missing, with no default

# What does that mean?  there is a lambda there???
# 


#V3
# Help on rpois reveals the problem:
# > ?rpois
# We see that the function definition is:
# rpois(n, lambda)
# So we have not given rpois 2 arguments.

# Fix this problem

mybug = function(L, lambda) {
	numHits = rpois(1, L*lambda)
	hitLocs = runif(o, numHits)
	return(numHits, hitLocs)
}

mybug(10, 1)

# Error in runif(o, numHits) : object 'o' not found
# Now what is wrong?



#V4
# That o should be a 0.
# Let's fix and try again

mybug = function(L, lambda) {
	numHits = rpois(1, L*lambda)
	hitLocs = runif(0, numHits)
	return(numHits, hitLocs)
}

mybug(10, 1)


# Error in return(numHits, hitLocs) : 
#   multi-argument returns are not permitted


#V5
# We can't return more than one argument


mybug = function(L, lambda) {
numHits = rpois(1, L*lambda)
hitLocs = runif(0, numHits)
return(list(numHits, hitLocs))
}

x = mybug(10, 1)
x

# At last no errors!!!
# Our code is perfect.
#
# Or is it....
# > x
[[1]]
[1] 9

[[2]]
numeric(0)

#
# Does that look right?


#V6
# It's good to try your code on test cases when you know
# what the results should be, or at least have an idea about it.
# The number of hits is 9, but we didn't generate any locations

# If you don't get what you expect, then you may want to 
# check the values of variables as your function executes
# one line of code after another.
# This can help you narrow down the location of the error

# We add browser() inside our code

mybug = function(L, lambda) {
	browser()
	numHits = rpois(1, L*lambda)
	hitLocs = runif(0, numHits)
	return(list(numHits, hitLocs))
}

mybug(10, 1)

#Called from: mybug(10, 1)
#Browse[1]> objects()
#[1] "L"      "lambda"
#Browse[1]> L
#[1] 10
#Browse[1]> lambda
#[1] 1
#Browse[1]> n
#debug at #3: numHits = rpois(1, L * lambda)
#Browse[2]> numHits
#Error: object 'numHits' not found
#Browse[2]> 
#  debug at #4: hitLocs = runif(0, numHits)
#Browse[2]> numHits
#[1] 8
#Browse[2]> objects()
#[1] "L"       "lambda"  "numHits"
#Browse[2]> 
#  debug at #5: return(list(numHits, hitLocs))
#Browse[2]> objects()
#[1] "hitLocs" "L"       "lambda"  "numHits"
#Browse[2]> hitLocs
#numeric(0)
#Browse[2]> Q



#V7
# We find that the runif call has an error

mybug = function(L, lambda) {
	numHits = rpois(1, L*lambda)
	hitLocs = runif(numHits, 0, L)
	return(list(numHits, hitLocs))
}

x = mybug(10, 1)
x

#[[1]]
#[1] 6
#
#[[2]]
#[1] 1.006596 6.527695 6.113973 1.229748 6.833516 2.998272

# YES!!!


