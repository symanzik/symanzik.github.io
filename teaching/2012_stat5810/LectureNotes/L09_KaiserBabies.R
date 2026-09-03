load(url("http://www.math.usu.edu/~symanzik/teaching/2012_stat5810/LectureNotes/KaiserBabies.rda"))

names(infants)
dim(infants)
is.data.frame(infants)

# Here are the data for the first 200 birth weights.What do you see?

infants$bwt[1:200]


# Set up an empty plot without data, but with titles and labels

plot(c(min(infants$bwt), max(infants$bwt)), c(0, 1),
     type = "n",
     main = "Kaiser Babies",
     xlab = "Birth Weight (oz)",
     ylab = "",
     yaxt = "n" )


# Experiment with the rug command

rug(infants$bwt)

rug(infants$bwt, ticksize = 0.6)

rug(jitter(infants$bwt, amount = 0.1), ticksize = 0.6)


# Redo the plot with the final settings for rug

plot(c(min(infants$bwt), max(infants$bwt)), c(0, 1),
     type = "n",
     main = "Kaiser Babies",
     xlab = "Birth Weight (oz)",
     ylab = "",
     yaxt = "n" )
rug(jitter(infants$bwt, amount = 0.1), ticksize = 0.6)

# Each baby’s weight is represented as a tickmark. The thicker lines 
# are from multiple babies with similar weights. A little random noise 
# has been added to the weights to keep them from falling on top of 
# each other. 
#
# What can you see now?  How are birth weights distributed?


# A more common approach to show the distributon of a data set
# is via a histogram/density plot

hist(infants$bwt)

hist(infants$bwt,
     main = "Kaiser Babies",
     xlab = "Birth Weight (oz)")

hist(infants$bwt,
     freq = FALSE,
     main = "Kaiser Babies",
     xlab = "Birth Weight (oz)")

hist(infants$bwt,
     freq = FALSE,
     main = "Kaiser Babies",
     xlab = "Birth Weight (oz)",
     ylim = c(0, 0.03))

hist(infants$bwt,
     freq = FALSE,
     main = "Kaiser Babies",
     xlab = "Birth Weight (oz)",
     xlim = c(40, 180),
     ylim = c(0, 0.03))

hist(infants$bwt,
     freq = FALSE,
     nclass = 7,
     main = "Kaiser Babies",
     xlab = "Birth Weight (oz)",
     xlim = c(40, 180),
     ylim = c(0, 0.03))

hist(infants$bwt,
     freq = FALSE,
     nclass = 7,
     main = "Kaiser Babies",
     xlab = "Birth Weight (oz)",
     xlim = c(40, 180),
     ylim = c(0, 0.02))

# Finally, combine the histogram with the rug plot

hist(infants$bwt,
     freq = FALSE,
     nclass = 7,
     main = "Kaiser Babies",
     xlab = "Birth Weight (oz)",
     xlim = c(40, 180),
     ylim = c(0, 0.02))
rug(jitter(infants$bwt, amount = 0.1), ticksize = 0.02)


# A Density plot is smoothed histogram 

plot(density(infants$bwt), 
     main = "Kaiser Babies",
     xlab = "Birth Weight (oz)")

# Density plots use a bandwidth (bw).
# R chooses a bandwith for you, but you can specify one if you like.
# The goal is to see the overall shape of the distribution, not the 
# individual points. In a way, the density is a smooth abstraction 
# of the distribution.

plot(density(infants$bwt, bw = 0.1),
     main = "Kaiser Babies",
     xlab = "Birth Weight (oz)")

plot(density(infants$bwt, bw = 1),
     main = "Kaiser Babies",
     xlab = "Birth Weight (oz)")

plot(density(infants$bwt, bw = 10),
     main = "Kaiser Babies",
     xlab = "Birth Weight (oz)")

# Which bandwidth did R choose?

is.list(density(infants$bwt))

names(density(infants$bwt))

density(infants$bwt)$bw

# Finally, combine histogram, rug plot, and density plot

hist(infants$bwt,
     freq = FALSE,
     nclass = 7,
     main = "Kaiser Babies",
     xlab = "Birth Weight (oz)",
     xlim = c(40, 180),
     ylim = c(0, 0.025))
rug(jitter(infants$bwt, amount = 0.1), ticksize = 0.02)
lines(density(infants$bwt))


# Boxplots

boxplot(infants$bwt, 
        xlab="Birth Weight (oz)")

boxplot(infants$bwt, 
        xlab="Birth Weight (oz)",
        horizontal = TRUE)


# Parity: Number of siblings
#
# This quantitative variable is different from birth weight – 
# there are only a few possible values, i.e. it’s not possible 
# to have 2.3 siblings, and it’s highly unlikely to have 17.

table(infants$parity)

hist(infants$parity,
     breaks = 0:14,
     right = F,
     main = "Kaiser Babies",
     xlab = "Number of Siblings",
     ylim = c(0, 350))

# Now assume that parity is categorical.
# Look carefully at the right hand side of the plot
# and notice what happens!

barplot(table(infants$parity)) 

# Some further modifications via the plot command

plot(table(infants$parity), 
     type = "h", 
     lwd = 4, 
     ylab = "Frequency", 
     col = "darkgrey")

