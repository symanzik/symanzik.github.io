# Stat 5810/6810 - Homework 1 - Mo 9/10/2012
#
# 17 questions x 2 points each = 34 points total
#
# Due: Mo 9/17/2012, 1pm (Printout or by e-mail)
#
# Do not remove any of the comments. These are marked by #.
#
# Directly fill in the R code you used underneath each question.
#
# Start each answer line with ###, then provide an explanation or
# copy the results from the R output after the ###.
# 

### Name:

# Load the data for this assignment into your R session 
# with the following command:

load(url("http://www.math.usu.edu/~symanzik/teaching/2012_stat5810/LectureNotes/SFTemps.rda"))

# Check to see that the data were loaded by running:
objects()
# This should show five variables: dates, dayOfMonth, month, temp, and year

# Use the length() function to find out how many observations there are.


# 1. Find the average daily temperature


# 2. Find the 10% trimmed average daily temperature (hint: use the documentation!)


# 3. Find the 50% trimmed average daily temperature


# 4. Compute the median daily temperature. How does it compare to 
# the 50% trimmed mean? Explain. Put your explanation in a comment
# that begins with three ###

### Your explanation goes here


# 5. We would like to convert the temperature from Farenheit to Celsius. 
# Below are several attempts to do so that each fail.  
# Try running each expression in R. 
# Record the error message in a comment
# Explain what it means. 
# Be sure to directly relate the wording of the error message with the problem you find in the expression.

(temp - 32]5/9
### Error message here
### Explanation here

(temp - 32)5/9
### Error message here
### Explanation here

5/9(temp - 32)
### Error message here
### Explanation here

[temp - 32]5/9
### Error message here
### Explanation here


# 6. Provide a well-formed expression that correctly performs the 
# calculation that we want. Assign the converted values to tempC


# For the following questions, use one of: head(), summary(),
# class(), min(), max(), hist(), quantile() to answer the questions.

#7. What was the coldest temperature (in F) recorded in this time period?


#8. What was the warmest temperature (in F) recorded in this time period?
 

#9. What does the distribution of temperatures look like, i.e. 
# are there roughly as many warm as cold days, are the temps
# clustered around one value or spread evenly across the range
# of observed temperatures, etc.?


#10. Examine the first few values of dates. These are a special
# type of data. Confirm this with class(). 


#11. Run the following code to make a plot. 
# (don't worry right now about what this code is doing)

plot(temp~dates, col = rainbow(12)[month], type="p", pch=19, cex = 0.3)

# Resize the plot so that it is as wide as possible and not too high.

# Make an interesting observation about temp in the Bay Area
# based on this plot (something that you couldn't see with
# the calculations so far.)

### Your answer goes here

# What interesting question about the weather in the Bay Area
# would you like to answer with these data, but don't yet know 
# how to do it? 

### Your answer goes here


# For the remainder of this assignment we will work with 
# one of the random number generators in R.

# 12. Use the following information about you to generate 
# some random values:  
#a.   Use your month of birth for the mean of the normal.
#b.   Use the day of the month you were born for the sd of the normal curve.
#c.   Generate r random values, depending on the last 2 digits of the room 
#       number of your office (e.g., my room number 313 would result in 13).
#d.   Assign the values to a variable matching your first name.
#e.   Provide the values generated 


# 13. Generate a vector called "normsamps" containing 
# 1000 random samples from a normal distribution with 
# mean 1 and SD 2.  


# 14. Calculate the mean and sd of the 1000 values.

### The return values from your computation go here


# 15. Use implicit coercion of logical to numeric to calculate
# the fraction of the values in normsamps that are less than 3
# and comment.


# 16. Repeat #13, #14 & #15 twice. Run the same code each time. 
# What do you notice?

### Your answer goes here


# 17. Look up the help for rnorm. 
# You will see a few other functions listed.  
# Use one of them to figure out about what answer you 
# should expect for the previous problem.  
# That is, find the area under the normal(1, 2) curve 
# to the left of 3.  This should be the chance of getting 
# a random value less than 3.   

