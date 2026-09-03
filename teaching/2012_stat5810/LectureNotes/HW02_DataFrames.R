# Stat 5810/6810 - Homework 2 - Mo 9/17/2012
#
# 10 questions x 3 points each = 30 points total
#
# Due: Mo 9/24/2012, 9:30am (Printout at start of class) or 11:59pm (by e-mail)
#
# Do not remove any of the comments. These are marked by #.
#
# Directly fill in the R code you used underneath each question.
#
# Start each answer line with ###, then provide an explanation or
# copy the results from the R output after the ###.
# 
# There will be additional instructions regarding Latex by We 9/19/2012.
# Please follow those if you take this course at the 6000 level.


### Name:

# In this assignment you will manipulate a data frame, by taking subsets and creating new variables, 
# with the goal of creating a plot.

# You will work with housing data that have been made available by the San
# Francisco Chronicle. These data contain information about sales in the
# San Francisco Bay Area, including the date of sale, sale price, square
# footage and location of each house sold from April 2003 to May 2006.

# Before beginning with the housing data, you will do some warm up 
# exercises with the small family data set that we have used in class.

# There exist many ways how to format R code, but many authors nowadays
# follow "Google's R Style Guide" from
#   http://google-styleguide.googlecode.com/svn/trunk/google-r-style.html
#
# Before you submit your assignments from now on, ask another student from this
# class to check the style and agree to do the same for someone else in this class.
# Our auditing participants are invited to participate in this activity.



#PART 1.  Family Data
# Load the data from the Web into your R session with the following command:
load(url("http://www.math.usu.edu/~symanzik/teaching/2012_stat5810/LectureNotes/family.rda"))

# In the following exercises try to write your code to be as general as possible
# so that it would still work if the family had 27 members in it or if the 
# variables were in a different order in the data frame.


# Q1. 
# The NHANES survey used different cut-off values for men and women when classifying
# them as over weight.  Suppose that a man is classified as obese if his bmi exceeds 26
# and a woman is classified as obese if her bmi exceed 25.

# Write a logical expression to create a logical vector, called OW_NHANES, that is TRUE if 
# a member of family is obese and FALSE otherwise. Display its content.


# Q2. 
# Here is an alternative way to create the same vector that introduces 
# some useful functions and ideas.

# We first create a numeric vector called OW_limit that is 26 for each male in
# the family and 25 for each female in the family.  To do this, create a vector 
# of length 2, called OWval, where the first element is 26 and second element is 25.


# Now, create the OW_limit vector by subsetting OWval by position, where the 
# positions are the numeric values in the gender variable 
# (i.e. use as.numeric to coerce the factor vector to a numeric vector).
# Notice that we can "subset" a vector of length 2 by a much longer vector.


# Finally, use OW_limit and the bmi vector in family to create the desired logical vector, 
# and call it OW_NHANES2. Display its content. Compare with your result from Q1 via the 
# sum function! What does this numerical result mean?


# Q3.
# Use the vector OW_limit and each person's height to find the weight 
# that they would have if their bmi was right at the limit (26 for men and 
# 25 for women). Call this weight OW_weight.

# To do this, start with the formula:
# bmi = (weight/2.2) / (2.54/100 * height)^2
# and re-express it in terms of weight.


# Make the following plot of actual weight against the weight at which they would
# be over weight

plot(family$weight, OW_weight)
abline(a = 0, b = 1)

# Redo this plot with at least 5 optional parameters for more meaningful titles, 
# axis labels, ranges, etc. Also explain what the abline does - and what it implies.



#PART 2.  San Francisco Housing Data
#
# Load the housing data into R.
load(url("http://www.math.usu.edu/~symanzik/teaching/2012_stat5810/LectureNotes/SFHousing.rda"))

# Q4.
# What is the name and class of each object you have loaded into your workspace?
### Your code below


### You answer here

# What are the names of the vectors in housing?
### Your code below


### Your answer here


# How many observations are in housing?
### Your code below

### Your answer here

# Explore the data using the summary function. 
# Describe in words at least two problems that you see with the data.

#### Write your response here


# Q5.
# We will work with houses in Albany, Berkeley, Piedmont, and Emeryville only.
# Subset the data frame so that we have only houses in these cities,
# and keep only the variables city, zip, price, br, bsqft, and year.
# Call this new data frame BerkArea. This data frame should have 4059 observations
# and 6 variables.


# Q6.
# We are interested in studying the relationship between price and size of house, but first
# we will further subset the data frame to remove the unusually large values.
# Use the quantile function to determine the 99th percentile of price and bsqft
# and eliminate all of those houses that are above either of these 99th percentiles
# Call this new data frame BerkArea, as well. It should have 3999 observations.
# Write your code so that it is very general and does not depend on the 
# actual numeric value for these quantiles.


# Q7.
# Create a new vector that is called pricepsqft by dividing the sale price by the square footage
# of the house.  Add this new variable to the data frame.


# Q8.
# Create a vector called br5 that is the number of bedrooms in the house, except
# if this number is greater than 5, it is set to 5.  That is, if a house has 5 or more
# bedrooms then br5 will be 5. Otherwise it will be the number of bedrooms in the house.


# Q 9. 
# Use the rainbow function to create a vector of 5 colors, call this vector rCols.
# When you call this function, set the alpha argument to 0.25 (we will describe what this does later)
# Create a vector called brCols of 3999 colors where each element's
# color corresponds to the number of bedrooms in br5.
# For example, if the element in br5 is 3, then the color will be the third color in rCols.


# Q10.
# We are now ready to make a plot!
# Try out the following code

plot(pricepsqft ~ bsqft, data = BerkArea,
     main = "Housing Prices in the Berkeley Area",
     xlab = "Size of house (square ft)",
     ylab = "Price per square foot",
     col = brCols, pch = 19, cex = 0.5)
legend(legend = 1:5, fill = rCols, "topright")

####
### What interesting feature do you see that you didn't know before making this plot? 
### Numerically quantify and interpret this feature.

