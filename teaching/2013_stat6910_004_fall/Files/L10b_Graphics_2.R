# L10b: Graphics_2

# SF Housing Data

load(url("http://www.math.usu.edu/~symanzik/teaching/2013_stat6910_004_fall/Files/SFHousing.rda"))

someCities = c("Albany", "Berkeley", "El Cerrito", "Emeryville", "Piedmont", "Richmond", "Lafayette", "Walnut Creek", "Kensington", "Alameda", "Orinda", "Moraga")
shousing = housing[housing$city %in% someCities & housing$price < 2000000, ]
dim(shousing)

#adjust factors to those in someCities
shousing$city = factor(shousing$city, levels = someCities) 

boxplot(shousing$price ~ shousing$city, las = 2)

# reorder according to median
citymedian = tapply(shousing$price, shousing$city, median, na.rm=TRUE) 
cityOrder = order(citymedian)
shousing$cityO = factor(shousing$city, levels = levels(shousing$city)[cityOrder], ordered = TRUE) 

boxplot(shousing$price ~ shousing$cityO, las = 2)

# Scatterplot

ppsf = shousing$price / shousing$bsqft
plot(ppsf ~ shousing$bsqft)

plot(ppsf ~ shousing$bsqft,  # plot y against x
     pch = 19,               # change plotting character to solid circle
     cex = 0.2,              # shrink plotting character to 20%
     subset = shousing$city =="Berkeley", # Plot a subset of records 
     main = "Berkeley",      # title of plot
     xlab = "Area (ft^2)",   # label for x axis
     ylab = "Price/ft^2")    # label for y axis


# Chips Data

chips = read.table("http://www.math.usu.edu/~symanzik/teaching/2013_stat6910_004_fall/Files/chip04.txt", header = TRUE)
class(chips)
names(chips)
dim(chips)

plot(chips$Date, chips$Transistors,
     type ="l", 
     lwd = 3, 
     col ="green",
     log="y")


# RColorBrewer

library(RColorBrewer)

mycolors = brewer.pal(10, "RdYlGn")
mycolors

hist(runif(1000), breaks = seq(0, 1, by = 0.1), col = mycolors)

