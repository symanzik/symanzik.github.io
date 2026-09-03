# L07a: Graphics 1 - Video Games

load(url("http://www.math.usu.edu/~symanzik/teaching/2013_stat6910/LectureNotes/videogame.rda"))

# Investigate the data 

is.data.frame(video)

names(video)

dim(video)

head(video)


# Make tables of qualitative data

# Anything unusual about the expected grade? 

table(video$grade)

# Does expected grade depend on gender?

table(video$grade, video$sex)


# Create basic plots of expected grade: a) bar chart

barplot(table(video$grade))

barplot(table(video$grade)[5:1])

barplot(table(video$grade)[5:1],
        main = "Expected Grade")


# Create basic plots of expected grade: b) pie chart

pie(table(video$grade))

pie(table(video$grade)[5:3])

pie(table(video$grade)[5:3],
    clockwise = TRUE)

pie(table(video$grade)[c(4, 5, 3)],
    clockwise = TRUE)

pie(table(video$grade)[c(4, 5, 3)],
    clockwise = TRUE,
    main = "Expected Grade")


# Note that areas are hard to compare in a pie chart.
# What are the approximate percentages here?


# Sometimes, adding percentages to a pie chart may help

pie(table(video$grade)[c(4, 5, 3)],
    clockwise = TRUE,
    main = "Expected Grade")
text(0.4, 0,
     paste(as.character(round(table(video$grade)[4] / sum(table(video$grade)) 
                              * 100)), "%", sep = ""))
text(-0.4, 0,
     paste(as.character(round(table(video$grade)[5] / sum(table(video$grade)) 
                              * 100)), "%", sep = ""))
text(-0.16, 0.6,
     paste(as.character(round(table(video$grade)[3] / sum(table(video$grade)) 
                              * 100)), "%", sep = ""))


# Create basic plots of expected grade: c) dot plot

dotchart(table(video$grade))

dotchart(table(video$grade),
         pch = 19)

dotchart(table(video$grade),
         pch = 19,
         main = "Expected Grade")


# Dot plots allow us to focus on the comparison of the values 


# Now we want to explore how the expected grade distribution 
# might vary with gender

mosaicplot(table(video$sex, video$grade), 
           main = "Expected Grade")

# Leave out the Ds & Fs

mosaicplot(table(video$sex, video$grade)[, 3:5], 
           main = "Expected Grade")

mosaicplot(table(video$sex, video$grade)[, 5:3], 
           main = "Expected Grade")


# Another example for Mosaicplots: The survivors of the Titanic
# Background info provided at
#   http://en.wikipedia.org/wiki/Passengers_of_the_RMS_Titanic

# Look at the data and its format

Titanic

class(Titanic)

dim(Titanic)

# Mosaicplot

mosaicplot(Titanic)

# Improved version with color, taken from p23 of
#    http://www.stat.auckland.ac.nz/~ihaka/120/Lectures/lecture17.pdf

mosaicplot(Titanic,
           main = "Survival on the Titanic",
           col = hcl(c(240, 120)),
           off = c(5, 5, 5, 5))

