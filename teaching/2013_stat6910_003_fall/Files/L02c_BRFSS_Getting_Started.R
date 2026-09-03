# L02c: BRFSS Getting Started

# Data file located at
#    http://www.math.usu.edu/~symanzik/teaching/2013_stat6910_003_fall/Files/BRFSS_CDC.rda

# Q: What file format is this?







# A: google for 
       rda file format



# Q: How can we read this into R?








load(url("http://www.math.usu.edu/~symanzik/teaching/2013_stat6910_003_fall/Files/BRFSS_CDC.rda"))
       


# Which variables are there?
       
names(cdc)
     
       
# How many observations and how many variables are there?
       
dim(cdc)
       
       
# Is this a ... matrix?
       
is.matrix(cdc)
       
       
# Is this a ... data.frame?
       
is.data.frame(cdc)
       
       
# What is a data.frame?
       
?data.frame
       
       
# Now, let's do a few calculations:
       
# Convert 175 pounds to kilograms

175 / 2.2


# Convert 69 inches to meters

69 * 2.54 / 100


# Compute BMI

79.5 / (1.7526^2)


# This time do all the computations at once

175 / 2.2 / (2.54 / 100 * 69)^2
       
       
# What are the first few weights?
              
head(cdc$weight)

       
# Can we simply access the variable weight?       

weight
       
       
# Simplify the access to the data.frame
       
attach(cdc)

       
# Try again
       
weight
       
       
# Access individual weight components
       
weight[1]

weight[1:5]       

weight[c(1, 3, 5, 7)]      
       
weight[weight >= 400]    
       
head(weight >= 400)
       
sum(weight >= 400)     
       
       
# Let's convert all of the values for weight 

weight / 2.2

# Notice that 10,000 values are printed on the screen
# and that's not all of the values in our weight vector;
# instead we assign the return value of the computations
# to a new variable called bmi

bmi = weight / 2.2 / (2.54 / 100 * height)^2

       
# We can summarize bmi by calling the summary function.
# Notice it provides quartiles, mean, min, and max

summary(bmi)

summary(weight)
       
# Or just obtain the mean
       
mean(weight)


# Here's a new variable called deltaWt. It's the difference
# between desired weight and weight

deltaWt = wtdesire - weight

       
# Here's the summary of deltaWt
       
summary(deltaWt)


# What is the mean of deltaWt?

mean(deltaWt)


# Do a few more things with desired weight

summary(wtdesire)

hist(wtdesire)

hist(wtdesire, breaks = 30)

hist(delta, breaks = 30)

hist(deltaWt, breaks = 30)

hist(deltaWt, breaks = 30, right = F)
       
timesWt = weight / deltaWt

summary(timesWt)


summary(gender)

      
# The head function is very helpful for looking at just a few values
       
head(gender)
       

# The class function returns the data type of the vector
       
class(gender)

class(weight)

class(bmi)

       
# Manipulate the data and assume the first value for
# weight is missing (represented as NA = "Not Available")
       
weight[1] = NA       

       
# Note the side effect! This creates a new vector called weight. 
# cdc$weight remains unchanged!
       
head(weight)
       
head(cdc$weight)       

       
# Redo some of the previous calculations
       
summary(weight)       
       
mean(weight)
              
mean(weight, na.rm = T)

sum(weight >= 400)       

sum(weight >= 400, na.rm = T)       
       
sum(is.na(weight))       
       
       
# Done - clean up and detach the data.frame

detach(cdc)

       