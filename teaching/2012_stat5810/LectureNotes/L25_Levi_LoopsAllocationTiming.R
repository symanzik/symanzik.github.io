L25: by Levi Phippen (10/26/2012)

######################################################################################################
#################################  Loops within Loops and Timing Issues ##############################

### The functions that follow are examples of two different ways of making a numeric vector many 
### elements long.

### Function One initializes a vector of a desired length and then fills each element with a desired
### value as the function moves through the loop.


f = "Function One"
max.iter = 1000
x = 0
steps = 0
n = 10000
stvec = rep(0,n)
time = system.time(
  for(i in 1:n){
    while(x < 10){
      x = x + sample(c(0,1), 1, prob = c(0.75, 0.25))
      steps = steps + 1
      if(steps == max.iter){
        warning("Maximum iteration reached")
        break
      }
    }
    stvec[i] = steps
    x = 0
    steps = 0
  } 
)
f
time

##################################################################################################
##################################################################################################

### Function Two creates the same type of vector as Function One, but instead of the vector being 
### initialized to some desired length and elemental values, it is created as the loop progresses,
### with each new element contatenated to the end of the the vector from the previous iteration.

g = "Function Two"
max.iter = 1000
x = 0
steps = 0
stvec = NULL
n = 10000
time2 = system.time(
  for(i in 1:n){
    while(x < 10){
      x = x + sample(c(0,1), 1, prob = c(0.75, 0.25))
      steps = steps + 1
      if(steps == max.iter){
        warning("Maximum iteration reached")
        break
      }
    }
    stvec = c(stvec,steps)
    x = 0
    steps = 0
  } 
)
g
time2

#################################################################################
####################  Function 1 at different n Values  #########################

time1 = rep(0, 10)
f = "Function One"
max.iter = 1000
x = 0
steps = 0
nval1 = rep(0, 10)
n = 10000

for(j in 1:10){
  stvec = rep(0,n)
  time = system.time(
    for(i in 1:n){
      while(x < 10){
        x = x + sample(c(0,1), 1, prob = c(0.75, 0.25))
        steps = steps + 1
        if(steps == max.iter){
          warning("Maximum iteration reached")
          break
        }
      }
      stvec[i] = steps
      x = 0
      steps = 0
    } 
  )
  nval1[j] = n
  n = n + 10000
  time1[j] = as.numeric(time[[3]])
}

### The following is a plot of how long it took the computer to work through the loop at each different
### value of n:

plot(nval1, time1, main = "Loop-1 Time for Different n Values", xlab = "n Values", ylab = "Time in Seconds")

#################################################################################
##################  Function 2 at Different n Values ############################

time2 = rep(0, 10)
g = "Function 2"
max.iter = 1000
x = 0
steps = 0
n = 10000
nval2 = rep(0, 10)

for(j in 1:10){
  stvec = NULL
  time = system.time(
    for(i in 1:n){
      while(x < 10){
        x = x + sample(c(0,1), 1, prob = c(0.75, 0.25))
        steps = steps + 1
        if(steps == max.iter){
          warning("Maximum iteration reached")
          break
        }
      }
      stvec = c(stvec,steps)
      x = 0
      steps = 0
    } 
  )
  nval2[j] = n
  n = n + 10000
  time2[j] = as.numeric(time[[3]])
}


### The following is a plot of how long it took the computer to work through the loop at each different
### value of n:

plot(nval2, time2, main = "Loop-2 Time for Different n Values", xlab = "n Values", ylab = "Time in Seconds")

### The following is a plot of how times from Function One compare to the times from Function Two:

plot(time1, time2, main = "Loop-2 v. Loop-1", xlab = "Loop-1 Times in Seconds", ylab = "Loop-2 Times in Seconds")

