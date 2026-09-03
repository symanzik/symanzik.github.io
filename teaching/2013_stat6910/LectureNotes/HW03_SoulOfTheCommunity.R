# Stat 6910 - Homework 3 - Sun 2/3/2013
#
#
### Name:
#
#
# 10 questions x 5 points each = 50 points total
#
# Due: Sun 2/10/2013, 11:59pm (By e-mail)
#
# Do not remove any of the comments in this file. These are marked by # or ###.
#
# Directly fill in the R code you used underneath each question and e-mail 
# your modified version of this file back to me when done. In addition,
# you also need to submit 3 (or more) pdf figures (see below for details).
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
#    http://google-styleguide.googlecode.com/svn/trunk/google-r-style.html
#
# The only thing where I disagree is the usage of <- and = for assignments.
# This is your choice, but you must be consistent, e.g., either use <- or use =
# throughout your entire document.
#
# Before you submit your assignment, ask another student from this class to
# check the style and agree to do the same for someone else in this class.
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

# In this assignment, you will work with one of the data sets from the
# "Soul of the Community" project, sponsored by the Knight Foundation.
# See here for more details:
#    http://www.soulofthecommunity.org/
#    http://www.knightfoundation.org/
#
# These data sets are featured in the 2013 Data Expo of the Sections on
# Statistical Graphics & Statistical Computing of the American Statistical
# Association (ASA), in collaboration with the Knight Foundation - see
#    http://streaming.stat.iastate.edu/dataexpo/2013/
#
# We will only focus on the 2008 data set. You should also download the
# codebook for 2008 and 2009 (in MS Word format) from the web site above
# to better understand what the variables represent.

#
# Load the data from the Web into your R session with the following command:

SOTC = read.csv(url("http://streaming.stat.iastate.edu/dataexpo/2013/data/sotc08.csv"), 
                header = TRUE)

# These are about 18MB of data. So, you only want to download the data file
# once from the web and then work with a local copy thereafter. But, it often
# happens in such competitions that data files get updated or corrected -
# so, be prepared that you need to reload a new version of the data in the future.
#
# You shouldn't modify the data file in Excel - and rather do all modifications
# in R, so that a future version of the data file can be modified in a similar way.

# In the following exercises, try to write your code to be as general as possible
# so that it would still work for the 2009 data set (and possibly for the 2010
# data set). So, avoid all constants with respect to dimensions, locations of
# variables in the columns (and rather use the names of the variables), etc.

dim(SOTC)

# This should be 
# [1] 13822   156

class(SOTC)

# [1] "data.frame"


# Q1.
# First, obtain the classes of the data frame. What are they?
# Assign the result to SOTCclasses.

### Your answer here


# What are the unique classes? Assign the result to SOTCclassesUnique.

### Your answer here


# Now count how many of the variables are of each of the classes 
# (and assign to SOTCclassesCount).
# Obviously, the sum of the count should result in 156 again.

### Your answer here


# Hint: Two of these 3 questions can best be answered via commands
# from the apply family!


# Q2.
# What are the different communities? Use the column QSB.
# Assign the result to SOTCQSBUnique.

### Your answer here


# Further separate city and state and assign to SOTCQSBUniqueList.
# You'll need the command strsplit and use ", " for splitting.
# Your first attempt likely will result in an error!
# Recall which classes we have - and what strsplit needs!

### Your answer here


# Q3.
# Obtain the unique states (as character strings in alphabetical order) 
# from SOTCQSBUniqueList and assign to SOTCQSBUniqueStates. 
# What are they - and how many are there?

### Your answer here


# Hint: You may want to work with the unlist command!
# Manually check whether your result is correct and you didn't
# miss any states!


# Q4.
# Install and load the "maps" package. See how you can produce
# a basic map of the 48 contiguous states of the United States.

# Note that R has default data sets state.abb and state.name.
# Use these to color the state map such that a state that appears
# in SOTCQSBUniqueStates is colored "blue" and all other states
# are colored "grey". Save your map as "YOUR_NAME_HW03_Q4_map.pdf"
# and submit as one of your files when turning in the assignment.

### Your answer here


# Hint: This may be easiest to do in two steps: First create
# the grey base map. Then overlay the proper states in blue.
# The %in% command may be useful. As usual, check that your
# result is correct by comparing the map with SOTCQSBUniqueStates.


# Q5.
# Columns QS3 and QS3_02 look very similar. Is there any difference
# between them - and if so, in which rows(?)

### Your answer here


# Q6.
# First create a table of the races, based on column QD111
# and assign to SOTCraceTable. Then create a barchart
# where the bars are sorted increasingly from smallest
# to largest. Make sure that *all* bars are labeled!
# This can be done via this code snippet where
# you need to fill in the missing parts:
#
# par(oma = c(6, 1, 1, 1))
# barplot(...,
#        las = 2,
#        cex.names = 0.7)
#
# Save your bar chart  as "YOUR_NAME_HW03_Q6_barplot.pdf"
# and submit as one of your files when turning in the assignment.

### Your answer here


# Q7.
# Create a summary table of column Q5. Omit categories
# with fewer than 100 responses and assign to SOTCmove.
# What is the content of SOTCmove?

### Your answer here


# Q8.
# Create a 2-dimensional table of columns Q5 and QS4
# and assign to SOTC2dimTable. 
# Look at the rownames and colnames of this table.
# Those names are very long. Assign some meaningful
# shorter names instead that can be used in a mosaicplot.
# Finally, create a mosaicplot of the table (with a meaningful title),
# but leave out rows and columns for (DK) and (Refused).
# So, this will be a 4x4 mosaicplot. Set the 
# shade argument to TRUE and interprent your plot!!!
# You need to comment on at least two of the areas in the plot.

# Fine-tune your pdf version of the plot - and not the screen version!
# Save your final mosaicplot  as "YOUR_NAME_HW03_Q8_mosaicplot.pdf"
# and submit as one of your files when turning in the assignment.

### Your answer here


# Q9.
# Verbally formulate another question of interest you would
# like to investigate. Your score for Q9 will be according to
# the "level of interest" of your question. A simple
# "how many..." question may only result in 1 or 2 points.
# Questions similar to the earthquake questions in our
# Quizzes 2 & 3 may result in 3 or 4 points (out of 5 points).

### Your answer here


# Q10.
# Answer your question from Q9 with R! In case you create
# any plot(s), save them according to the naming convention
# from the previous questions and turn them in as part of
# your final submission.

### Your answer here



###
### YOU ARE DONE !!!
###
### CONGRATULATIONS !!!
###

