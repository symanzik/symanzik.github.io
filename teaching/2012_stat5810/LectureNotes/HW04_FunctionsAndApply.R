# Stat 5810/6810 - Homework 4 - Tu 10/16/2012
#
# 8 questions x 5 points each = 40 points total
#
# Due: Fr 10/26/2012, 11:59pm (by e-mail)
#
# Do not remove any of the comments. These are marked by #.
#
# Directly fill in the R code you used underneath each question.
#
# Start each answer line with ###, then provide an explanation or
# copy the results from the R output after the ###.
#
# 6810 Students:  Please follow the same Latex template as for HW 03.


### Name:

# Functions, Apply, and Simulation

# Load the data into R

load(url("http://www.math.usu.edu/~symanzik/teaching/2012_stat5810/LectureNotes/Cache500.rda"))


# 1. The data are stored as an object called Cache500, a list of length 500.
# What are the 500 elements of this list?  Verify that they are all the same type.


# 2. Create 3 vectors, each of length 500, one value for each web site.
# numChanges: the number of changes at a site
# firstChange: the time of the first change
# lastChange: the time of the last change


# 3. We will examine a subset of web sites: those that have between 200 and 250 changes 
# (including 200 and 250) and where the last change was after the 700th visit.  
# Use the which() function and some of the vectors created above to create a vector 
# called whichOK that provides the indices of the elements that meet these conditions.  
# Just so you know you got it right, there should be 23 such web sites.


# 4. Write a function to make a quantile plot. 
# To make a quantile plot, plot the 0.01 quantiles of your data 
# against the uniform quantiles (i.e. 0.01, 0.02, ..., 0.99).  

Qplot = function(x){
  # x is a vector, and this function should make a quantile plot for that vector.
  # The plot you make can be specific to this dataset, so the values of x will
  # be integers from 1 to 720.  Test the function on the first of the whichOK vectors
  # to verify that it works.
}


# 5. Simulate a random vector of changes with the same length as a vector from whichOK.
# In the function below, n should be a number from 1 to 23 to reference one of the 
# whichOK vectors.  This function should output a vector of random integers of the same 
# length as the corresponding vector from Cache500, suitable for use as input for Qplot().
# Run the Qplot() function based on the output from this function to verify that
# it produces something close to a straight line.

SimData = function(n){ 
  # Use n to access the nth element of whichOK
	
  # Use the length of this vector to generate that many random uniform values
  # The range of the uniforms should be between 0 and 720.
	
  # Round up these uniform values to integers.
}


# Below is a function that does the following:
# It creates a vector that sorts the input vector and divides by 720. 
# The result is a vector where the last value is somewhat close to 1 and the first 
# value is somewhat close to 0, so that each input vector will be scaled the same way.
# The real data are already sorted but we will use this function for simulated
# data which are not.  The function then creates a vector of the same length,
# which goes (almost) from 0 to 1 in equal increments.  Finally the function
# takes the maximum distance between these vectors, a value that assesses
# how close the values of x are to being equally spaced, which is what we'd
# expect, roughly, for uniformly generated data.

MaxDiff = function(x) {
  scaled.x = sort(x) / 720
  n = length(x) + 1
  uq = seq(1 / n, by = 1 / n, length = n - 1)
  md = max(abs(scaled.x - uq))
  return(md)
}


# 6. Write the function SimMaxDiff described in the assignment. 

SimMaxDiff = function(x, n = 1000) {

  # Create the matrix of integers between 0 and 720

  # Apply over this matrix to get the MaxDiff for each column to get n MaxDiffs

  # Rank the MaxDiff for x among the n MaxDiffs

  # Return the rank
}


# 7. Write the function HistRanks described in the assignment.

HistRanks = function(x) {
  # Use sapply to determine the rank of each vector in x 

  # Scale the ranks by n + 1

  # Make a histogram of the scaled ranks (see instructions)

  # Return the scaled ranks
}


# 8. The purpose of these functions is to establish for which websites the distribution 
# of changes is roughly uniform.  Roughly speaking, the ranks that are to the right 
# of the red line in your histogram are so extreme that the data do not seem to be 
# uniform.  
# Choose one of the websites with a scaled rank of 1, meaning that for this 
# website the maximum difference was bigger than for all 1000 simulated values.  
# Run the Qplot() function on this website.  
# Also run Qplot() on a website with a scaled rank less than 0.8,
# meaning that at least 20% of the simulated datasets had larger maximum differences.  
# Contrast the quantile plots for these two cases. 
# Briefly describe what seems to be happening for the website with a scaled rank of 1.  
# When are changes more frequent? 

# As usual, provide a general summary of the results you found in this assignment.

