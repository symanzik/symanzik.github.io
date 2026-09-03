# Stat 5810/6810 - Homework 3 - Mo 9/24/2012
#
# 17 questions x 3 points each = 51 points total
#
# Due: Fr 10/5/2012, 9:30am (Printout at start of class) or 1:00pm (by e-mail)
#
# Do not remove any of the comments. These are marked by #.
#
# Directly fill in the R code you used underneath each question.
#
# Start each answer line with ###, then provide an explanation or
# copy the results from the R output after the ###.
#
# 6810 Students:  Please follow the same Latex template as for HW 02.


### Name:

# Graphics Skills

# The goals of this assignment are: 
# 1. become familiar with the variety of plotting functions available in R,
# 2. learn which types of plots are appropriate for which types of data
# 3. gain practice in making plots that make the data stand out,
#      facilitate comparison, and are information rich
# 4. gain additional experience working with data frames and vectors

# It is always a good idea to get a 2nd opinion regarding a graphic.
# In particular, you are allowed to talk to Anna, Chunyang and Nate
# (who previously took my Stat 6560 Graphical Methods class) or any
# other graduate student in the department who took that class 
# whether they can think of any further improvements of your graphics.
# It is your responsibility to implement these suggestions in R.

# The data are related to the 2012 Summer Olympics.
# We have three data sets available for you:

# a. SO2012Ctry which is a data frame with information about 
# each country that had an athlete participate in the olympics

# b. London2012ALL_ATHLETES.csv - a csv file which contains data
# on individual atheletes who participated in the 2012 Olympics

# c. wr1500m - a data frame containing information about the 
# world record in the 1500 meter men's race

# We will be making 4 plots with these sources of data.

# The help for plot.default describes many parameters that are  
# available for many of the plotting functions.
# Also, ?par provides help on many other plotting parameters.
# Some of these can be set in the plot function, while others
# are set in a call to par()


##############################

# PLOT 1. 
#
# World Record in Men's 1500 meter run
#
# When watching the summer Olympics, we might be curious
# about how much faster today's runners are compared to
# runners 50 or 100 years ago. 

# A search on Wikipedia shows us tables of the times for the
# world record holder in 1500 meters dating back to 1892:
#    http://en.wikipedia.org/wiki/1500_metres_world_record_progression
# We can use readHTMLTable() in R and this function goes off
# to the Web and downloads the tables we need and reads them
# into R as data frames. After some text manipulation, we have
# a data frame that we can use to examine the world records
# graphically.
# Later in this semester, you will be able to do the same sort
# of thing (access data from the Web from within R and clean it
# for analysis). Right now, the data are available to you at:

load(url("http://www.math.usu.edu/~symanzik/teaching/2012_stat5810/LectureNotes/WR1500MeterMen.rda"))

# The name of the object loaded is wr1500m
# The time in these data are recorded in seconds, and they are seconds
# over 3 minutes (= 180 seconds). So a time of 70 is really 4 minutes and 10 seconds
# (180 + 70 seconds = 250 seconds = 4 minutes and 10 seconds).


# Q1a. How many entries does this data frame contain? And how many 
# of those are unique (see help pages) world record times?


# Q1b. Use R commands (!) to find out who currently holds the world
# record in the men's 1500 meter - do not simply list the most recent entry!


# Let's look at the relationship between date and time.

# Q1c. What type of variable (e.g., numeric, integer, factor)
# are year and times? (no need to use R code to answer this question)


# When we are examining a variable to see how it changes in time,
# we typically make a line plot, with time on the x-axes and 
# the (x,y) values connected with line segments.

# Q2. Begin by making a line plot of year by times for these data.
# Don't bother to make it pretty yet; we will get to that later.
# But do add 180 to the times so that they are accurate measurements in seconds.


# Q3. The current world record was set in 1998. If we want to
# show that this record still stands in 2012, we could add a 
# horizontal line segment to the plot from 1998 to 2012 at the 
# 1998 record time.  
# To do this: remake the plot and set the xlim parameter 
# so that 2012 is included in the x-axis scale;
# then use the points function with type = "l" to add 
# the additional segment.


# Q4. There are two times where the record stood for several
# years - in 1944 and 1998. Let's make it easier to see these
# dates and let's include the name of the athlete who first set
# the record.  This additional reference information makes
# our plot richer.
# Add two grey vertical lines. One at 1944 and the other at 1998.
# Add the runner's name next to each vertical line.
# To do this, you will need the abline() function, the text() function,
# and you might want to consider the cex, col, pos, adj parameters.
# Also, do not type in the athlete's names nor the times. Instead, 
# use subsetting of wr1500m$athlete and wr1500m$times to access these.


# Q5. Now we are ready to add other contextual information.
# Remake the plot adding axis labels and a title.

# THIS IS THE PLOT THAT SHOULD BE PRINTED AND TURNED IN.

# 6810 Students: Write your plot to a pdf (or jpeg) file via the
# pdf (or jpeg) command (see the documentation for more details).
# Make sure to use a rectangular plotting area in R - do not change
# the aspect ratio in Latex, or your fonts in the plot will be distorted.
# When done with plotting, close the file via the dev.off() command
# to write the plot file to your hard disc. This is the file
# you need to include into your Latex file for HW 03. 


################################

# PLOT 2.
#
# A lot of medal counting goes on during the Olympics.
# We might wonder about the relationship between the number of medals
# a country has won and the size of its population and its wealth.
# We collected data from various sources (ManyEyes, Guardian,
# ISO) to create this data frame with GDP, population, and other information
# about each country that participated in the Olympics.

# The data frame SO2012Ctry contains this information.
# It can be loaded into R with

load(url("http://www.math.usu.edu/~symanzik/teaching/2012_stat5810/LectureNotes/SummerOlympics2012Ctry.rda"))

# Q6 Take a look at the variables in this data frame.
# What kind of variable is GDP and population?

# What about Total?

# To examine the relationship between these three variables,
# we could consider making a scatter plot of GDP against pop
# and use plotting symbols that are proportional in size to
# the number of medals. 

# To begin, make a plot of GDP against population. 
# Which of the three principles of good graphics does this
# plot violate and why?


# Q7. Let's examine GDP per person (create this new varialbe yourself)
# and population. Use a log scale for both axes. Use the symbols()
# function rather than plot(), and create circles for the plotting
# symbols where the area of the circle is proportional to the 
# total number of medals.


# Q8. It appears that the countries with no medals are circles too.
# Remake the plot, this time using only the countries that won
# medals. Then add the non-medal countries to the plot using the "." plotting
# character.


# Q9. Make the plot information rich by adding axis labels, 
# title, and label at least 5 of the more interesting points
# with the country name (one of these should be your native country, 
# labeled in red). Use text() to do this.

# THIS IS THE PLOT THAT SHOULD BE PRINTED AND TURNED IN.

# 6810 Students: Follow the instructions for Plot 1.


######################################

# PLOT 3.
#
# Plotting points on maps can help us see geographic relationships
# 
# Q10. Install the maps library and load it into your R session.
# Make a map of the world where the countries are filled with a light grey color.


# Q11. Use the symbols() function to add circles to the map where
# the circles are proportional in area to the number of medals
# won by the country. You may find the add parameter useful.
# (Be sure to NOT plot circles for countries with 0 medals).  
#
# Warning: Country names are sometimes spelled incorrectly, are abbreviated,
# or are used inconsistently (such as United States, Unites States of America,
# US, USA, or U.S.A.). Make sure that for each country in the SO2012Ctry file
# you can find the matching country name in the map file.
# Provide the R code that does this checking. For country names that
# do not match, you are allowed to manually adjust the names.
# Provide the R code that shows how you do this adjustment.


# Q12. Remake the plot and fill in the circles with a partially
# transparent gold color. To create this color: 
# install the RColorBrewer library and load it into R;
# call display.brewer.all() to examine the palettes;
# choose a palette and ask for the names of a few colors 
# using brewer.pal();
# pick one of the colors and create a new one that is transparent
# by adding two more digits to the end of the name, e.g.,
# if you want to use "#FEB24C" then make it transparent with
# e.g. myColor = "#FEB24CAA" or   "#FEB24C88"

# THIS IS THE PLOT THAT SHOULD BE PRINTED AND TURNED IN.

# 6810 Students: Follow the instructions for Plot 1.


##############################################

# PLOT 4
#
# When following the Olympics, we got to know some of the 
# athletes pretty well with all of their press coverage.
# Some news stories touted how this Olympics had by far
# the greatest number of women competing and some countries
# had female athletes competing for the first time.

# The csv file called London2012ALL_ATHLETES.csv
# contains information about every athlete who competed 
# in the Olympics.
# It can be loaded into R as a data frame with the following call:

athletes = read.csv("http://www.math.usu.edu/~symanzik/teaching/2012_stat5810/LectureNotes/London2012ALL_ATHLETES.csv",
                    header = TRUE)

# There is one observation for each athlete. 
# (Actually, about 20 atheletes have two records if they
# competed in different sporting events. Let's not worry about that.)

# Q13. We are interested in the relationship between Sport and Sex. 
# What type of data is each of these variables?
# How many athletes competed in the 2012 Olympics?
# How many women competed?
# How many sports were there?

# The table() function might be helpful for answering 
# some of these questions. 


# Q14. Make a barplot of Sport and Sex that emphasizes the 
# important differences. To do this, first make a table of 
# Sex by Sport. This will be the input to barplot(). 
# Make the barplot with the parameter beside = TRUE and 
# and again with beside = FALSE. Determine which of these 
# barplots provides the easiest comparison. 


# Q15. Remake the barplot above, but this time switch the order 
# of Sport and Sex in the call to table(). Use the value for
# the beside parameter that you decided was best for the 
# plot in Q 14. Compare the barplot with (Sex, Sport) vs 
# (Sport, Sex). Which makes a more interesting visual comparison?


# Q16. Notice that the bars are in alphabetical order by sport.
# To facilitate comparisons, we might want to arrange
# the bars in order of participation in a sport. To do this,
# call order() on the return value from making a table of Sport alone.
# Assign this vector to a variable, say orderSport.
# Then reorder your two-way table of Sport and Sex,
# using the orderSport vector and [ ] to subset the table and rearrange
# the rows/cols. The resulting barplot should show bars in 
# increasing height.


# Q17. Finally to make the plot more information rich, try turning
# the x-axis labels on their side. To do this, find a parameter
# in par() that will rotate the x-axis tick mark labels. Even though
# you found the parameter in the par() function, this
# parameter can be added in the call to barplot().
# Also find and use a parameter to shrink the text for these labels. 
# Lastly, add a title to the plot.

# THIS IS THE PLOT THAT SHOULD BE PRINTED AND TURNED IN.

# 6810 Students: Follow the instructions for Plot 1.


# You are DONE. HOORAY!
#
# Hope you had fun making increasingly complex and attractive plots with R.
# Soon you will be making your own beautiful plots without step-by-step instructions.

