# L08b: Graphics 1 - Kaiser Babies

load(url("http://www.math.usu.edu/~symanzik/teaching/2013_stat6910_003_fall/Files/KaiserBabies.rda"))

names(infants)
dim(infants)
is.data.frame(infants)

# Here are the data for the first 200 birth weights.
# What do you see?

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

rug(jitter(infants$bwt, amount = 0.5), ticksize = 0.6)


# Redo the plot with the final settings for rug

plot(c(min(infants$bwt), max(infants$bwt)), c(0, 1),
     type = "n",
     main = "Kaiser Babies",
     xlab = "Birth Weight (oz)",
     ylab = "",
     yaxt = "n" )
rug(jitter(infants$bwt, amount = 0.5), ticksize = 0.6)

# Each baby'sweight is represented as a tickmark. The thicker lines 
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
rug(jitter(infants$bwt, amount = 0.5), ticksize = 0.02)


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
rug(jitter(infants$bwt, amount = 0.5), ticksize = 0.02)
lines(density(infants$bwt))


# Boxplots

boxplot(infants$bwt, 
        xlab = "Birth Weight (oz)")

boxplot(infants$bwt, 
        xlab = "Birth Weight (oz)",
        horizontal = TRUE)


# Parity: Number of siblings
#
# This quantitative variable is different from birth weight as
# there are only a few possible values, i.e. it's not possible 
# to have 2.3 siblings, and it's highly unlikely to have 17.

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


### Typically, when plotting, we start with a relatively plain plot
### and add details in the next few iterations of this plot. 
###
### It is not uncommon to create 10 (or more) versions of a plot.
###
### To save a plot, you can click on "Export" in RStudio or work
### with the commands pdf("file.pdf") or jpeg("file.jpg")
### to create pdf or jpg files, respectively.
### Other external formats (such as bmp, png, tiff & postscript) can
### be created similarly. Check carefully which arguments exist
### for which of these external plot commands.
###
### Your plot *MUST* be finished with the dev.off() command
### that shuts down the current output device and physically
### writes the content to the pdf (or jpg) file. Otherwise,
### before dev.off(), the external graphics file may not be
### printed or accessed by other programs, even though the
### file name may show up in the directory.


# Finally, let's use this data set for a few more examples to 
# practice some of the apply commands:

names(infants)
summary(infants$ed)
summary(infants$marital)

# Calculate mean ages for ed & marital (separately!)

levels(infants$ed)
tapply(infants$age, infants$ed, mean)
tapply(infants$age, infants$ed, mean, na.rm = TRUE)

levels(infants$marital)
tapply(infants$age, infants$marital, mean, na.rm = TRUE)


# Combine ed & marital into a new factor, then calculate
# mean ages for this new factor

table(infants$ed, infants$marital)
table(infants$ed, infants$marital, useNA = "ifany")
table(infants$ed, infants$marital, useNA = "always")

newFactor = as.factor(sapply(1:length(infants$ed), function (x)
  paste(as.character(infants$ed[x]), "-", as.character(infants$marital[x]))))
infants[1:10, c("ed", "marital")]
head(newFactor, n = 10)

tapply(infants$age, newFactor, mean, na.rm = TRUE)


# Compare the following two expressions and their results:

summary(infants)
sapply(infants, summary) 

class(summary(infants))
class(sapply(infants, summary))

       
       