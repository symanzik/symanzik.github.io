# Stat 6910 - Homework 2 - Mo 9/23/2013
#
#
### Name:
#
#
# 15 questions x 4 points each = 60 points total
#
# Due: Mo 9/30/2013, 3pm (By e-mail)
#
# Do not remove any of the comments in this file. These are marked by # or ###.
#
# Directly fill in the R code you used underneath each question and e-mail 
# your modified version of this file back to me when done. 
#
# You do not have to submit any of the figures, but you should verify in a clean
# R session that I can reproduce your figures on my side!!!
#
# Start each text answer line with ###, then provide an explanation or
# copy the results from the R output after a #. So, you must include
# the R commands (without a # so that I can rerun these on my side if necessary)
# and the R output (with a # in front of each output line).
# 
# As an example, assume that the question reads: Write an R expression that
# calculates the bmi from weight (in pounds) and height (in inches) and apply
# this to 2 people with weights of 175 and 125 pounds and heights of 70 and 64 inches,
# respectively. Your answer should look as follows:

###

weight <- c(175, 125)
height <- c(70, 64)
bmi <- weight / 2.2 / (2.54 / 100 * height)^2
bmi

### Output

# [1] 25.16239 21.50106

#
# Check that your R code follows formatting requirements from the google R style guide at
#    http://google-styleguide.googlecode.com/svn/trunk/Rguide.xml
#
# The only thing where I disagree is the usage of <- and = for assignments.
# This is your choice, but you must be consistent, e.g., either use <- or use =
# throughout your entire document.
#
# Before you submit your assignment, ask another student from this
# class to check the style and agree to do the same for someone else in this class.
# Our auditing participants are invited to participate in this activity.
# 
# Assuming that you are editing this file in RStudio, mark it entirely when done,
# and click on Run. Check that it reproduces all results and does not
# return any error messages, other than where they are supposed to occur. 
# 
# Re-running your code when completely done is a way to check for reproducibility,
# e.g., to make sure that you didn't type in a command at the console and later
# have forgotten to add it to your R code, that you didn't use the 
# content of a variable from the previous workspace (while it wasn't assigned 
# for this chunk of R code), and so on.
#


### Background Information

# In this assignment you will manipulate a data frame, by taking subsets and creating  
# new variables, with the goal of creating a plot.
#
# You will work with housing data that have been made available by the San
# Francisco Chronicle. These data contain information about sales in the
# San Francisco Bay Area, including the date of sale, sale price, square
# footage and location of each house sold from April 2003 to May 2006.
#
# Before beginning with the housing data, you will do some warm up 
# exercises with the small family data set that we have used in class.
#


# PART 1.  Family Data
#
# Load the data from the Web into your R session with the following command:

load(url("http://www.math.usu.edu/~symanzik/teaching/2013_stat6910_003_fall/Files/family.rda"))

# In the following exercises, try to write your code to be as general as possible
# so that it would still work if the family had 27 members in it or if the 
# variables were in a different order in the data frame.


# Q1. 
# The NHANES survey used different cut-off values for men and women when classifying
# them as over weight.  Suppose that a man is classified as obese if his bmi exceeds 26
# and a woman is classified as obese if her bmi exceeds 25.

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

pdf("YOUR_NAME_HW02_Q3_original.pdf")
plot(OW_weight, family$weight)
abline(a = 0, b = 1)
dev.off()

# Redo this plot with at least 5 additional arguments for more meaningful titles, 
# axis labels, ranges, etc. Also explain what the abline does - and what it implies.

pdf("YOUR_NAME_HW02_Q3_improved.pdf")
plot(OW_weight, family$weight, [at least 5 additional arguments])
abline(a = 0, b = 1)
dev.off()

#### The pdf command writes a plot to an external file on your computer.
#### You should include a path to a directory of your choice so you can more easily
#### locate this file. The dev.off command closes the output file.


# PART 2.  San Francisco Housing Data
#
# Load the housing data into R.

load(url("http://www.math.usu.edu/~symanzik/teaching/2013_stat6910_003_fall/Files/SFHousing.rda"))

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
# Describe in words at least three problems that you see with the data.

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
# Note that there is no need for any "if"-statements or loops to create this vector -
# just basic R commands discussed so far will be sufficient!


# Q9. 
# Use the rainbow function to create a vector of 5 colors, call this vector rCols.
# When you call this function, set the alpha argument to 0.25 (we will describe what this does later)
# Create a vector called brCols of 3999 colors where each element's
# color corresponds to the number of bedrooms in br5.
# For example, if the element in br5 is 3, then the color will be the third color in rCols.


# Q10.
# We are now ready to make a plot!
# Try out the following code

pdf("YOUR_NAME_HW02_Q10_provided.pdf")
plot(pricepsqft ~ bsqft, data = BerkArea,
     main = "Housing Prices in the Berkeley Area",
     xlab = "Size of house (square ft)",
     ylab = "Price per square foot",
     col = brCols, pch = 19, cex = 0.5)
legend(legend = 1:5, fill = rCols, "topright")
dev.off()

####
### What interesting feature do you see that you didn't know before making this plot? 
### Numerically quantify and interpret this feature.
####


# Q11.
# To finish, let's use some of the apply commands for the housing data set.
# For each of the following, provide the R code, the R output, and some
# interpretation (where requested).

# Look at the names in housing first so you know the names of the variables:
names(housing)

# Determine how many missing values were present for each of the variables.

### Your code below


### Your answer here


# Q12.
# For each county, calculate the median price. 

### Your code below


### Your answer here


# Q13. 
# For each city, calculate the mean price. Display the resulting
# 10 highest prices in decreasing order.

### Your code below


### Your answer here


# Q14.
# Zip codes for San Francisco cover the range 94102 through 94134 - see
# http://sanfrancisco.about.com/od/neighborhoodprofiles/ig/sfmaps/SF-District---Zip-Code-Map.htm
#
# First, create a logical vector called SFZip that is TRUE when a zip code belongs
# to San Francisco. Be careful when converting from factor to integer.
# Likely, your first attempt will not work. Try converting to character first -
# and then converting to integer. How many of the observations fall into the SF area
# (according to their zip codes)?

### Your code below


### Your answer here


# Q15.
# Compare the average number of bedrooms (br) inside and outside of San Francisco.
# What do you notice? Provide a clear interpretation of this numerical output!

### Your code below


### Your answer here



###
### DONE WITH THE R BOOTCAMP !!! CONGRATULATIONS !!!
###

