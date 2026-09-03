load(url("http://www.math.usu.edu/~symanzik/teaching/2012_stat5810/LectureNotes/videogame.rda"))

# Investigate the data 

is.data.frame(video)

names(video)

dim(video)


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
           main="Expected Grade")

# Leave out the Ds & Fs

mosaicplot(table(video$sex, video$grade)[, 3:5], 
           main="Expected Grade")

mosaicplot(table(video$sex, video$grade)[, 5:3], 
           main="Expected Grade")

