# Code chunks from unit2_slides.pdf
# Used for Analysing Spatial Data in R: Vizualizing Spatial Data
#
# Roger Bivand
#
# Updated 9/25/2013
# Juergen Symanzik


# the source command reads (and executes) R commands from an entire external file;
# this allows us to recreate all variables from unit1

source(url("http://www.math.usu.edu/~symanzik/teaching/2013_stat5410/Files/unit1_mod_Juergen_V2.R"))


# Plotting a SpatialPoints object

plot(meuse1)

plot(meuse1, axes = TRUE)
plot(meuse1[meuse1$ffreq == 1, ], col = "green", add = TRUE)
title("Sampling Locations near the Meuse River")

# or

plot(as(meuse1, "Spatial"), axes = TRUE)
plot(meuse1, add = TRUE)
plot(meuse1[meuse1$ffreq == 1, ], col = "green", add = TRUE)
plot(meuse1[meuse1$ffreq == 2, ], col = "purple", cex = 1.5, add = TRUE)
plot(meuse1[meuse1$ffreq == 3, ], col = "yellow", pch = 15, 
     cex = 0.5, add = TRUE)
title("Sampling Locations near the Meuse River")


# Plotting a SpatialPolygons object

plot(rivers)

plot(rivers, axes = TRUE)

plot(rivers, axes = TRUE, col = "azure1",
     ylim = c(329400, 334000))
box()
plot(meuse1, add = TRUE)
title("Sampling Locations near the Meuse River")


# Plotting a SpatialPixels object

plot(meuseg1)

plot(meuseg1, axes = TRUE)

plot(rivers, axes = TRUE, col = "azure1",
     ylim = c(329400, 334000))
box()
plot(meuseg1, add = TRUE, col = "grey60", cex = 0.1)
plot(meuse1, add = TRUE, col = "red", cex = 0.5)
title("Sampling Locations near the Meuse River")


# Flood frequencies at soil sample sites

meuse1$ffreq1 = as.numeric(meuse1$ffreq)
plot(meuse1, axes = TRUE,
     col = meuse1$ffreq1, pch = 19)
labs = c("annual", "every 2-5 years", "> 5 years")
cols = 1:nlevels(meuse1$ffreq)
legend("topleft", legend = labs, col = cols, pch = 19, bty = "n")

plot(meuse1, axes = TRUE,
     col = meuse1$ffreq1, pch = 19)
legend("topleft", legend = labs, col = cols, pch = 19, 
       bty = "y", bg = "lightgray")


# Coloured contour lines

plot(volcano_sl)

volcano_sl$level1 = as.numeric(volcano_sl$level)
pal = terrain.colors(nlevels(volcano_sl$level))
plot(volcano_sl, bg = "grey70",
     col = pal[volcano_sl$level1], lwd = 3)


# Displaying gridded data

image(meuseg1)

meuseg1$ffreq1 = as.numeric(meuseg1$ffreq)
cols = c("black", "red", "green")
image(meuseg1, "ffreq1", col = cols)
legend("topleft", legend = labs,
       fill = cols, bty = "n")


# Class intervals

library(classInt)
library(RColorBrewer)

q5 = classIntervals(meuse1$zinc, n = 5, style = "quantile")
q5

eq5 = classIntervals(meuse1$zinc, n = 5, style = "equal")
eq5

fj5 = classIntervals(meuse1$zinc, n = 5, style = "fisher")
fj5

hc5 = classIntervals(meuse1$zinc, n = 5, style = "hclust")
hc5


# set up plotting area for 4 plots

par(mfrow = c(2, 2))

pal = brewer.pal(5, "Blues")

plot(q5, pal = pal)
plot(eq5, pal = pal)
plot(fj5, pal = pal)
plot(hc5, pal = pal)

dev.off()

# use these intervals for plotting colors on the map

q5
class(q5)
names(q5)
q5$brks
head(cut(meuse1$zinc, q5$brks))
head(as.integer(cut(meuse1$zinc, q5$brks)))


# modify the margins for the 4 plots

?par
par(mfrow = c(2, 2))
#par(mfrow = c(2, 2), mar = c(0, 0, 0, 0))
#par(mfrow = c(2, 2), mar = c(1, 1, 1, 0))
#par(mfrow = c(2, 2), mar = c(2, 2, 1, 0))
#par(mfrow = c(2, 2), mar = c(2, 2, 1, 0.5))

plot(meuse1, axes = TRUE,
     col = pal[as.integer(cut(meuse1$zinc, q5$brks))], 
     pch = 19)
plot(meuse1, axes = TRUE,
     col = pal[as.integer(cut(meuse1$zinc, eq5$brks))], 
     pch = 19)
plot(meuse1, axes = TRUE,
     col = pal[as.integer(cut(meuse1$zinc, fj5$brks))], 
     pch = 19)
plot(meuse1, axes = TRUE,
     col = pal[as.integer(cut(meuse1$zinc, hc5$brks))], 
     pch = 19)

dev.off()


# Bubble plots

library(lattice)

bubble(meuse1, "zinc", maxsize = 2,
       key.entries = 100 * 2^(0:4))

bubble(meuse1, "zinc", maxsize = 2,
       key.entries = c(1, seq(200, 2000, by = 200)))

bubble(meuse1, "zinc", maxsize = 3,
       key.entries = c(1, seq(200, 2000, by = 200)))

bubble(meuse1, "zinc", maxsize = 3,
       col = "#00FF00",
       key.entries = c(1, seq(200, 2000, by = 200)))

bubble(meuse1, "zinc", maxsize = 3,
       col = "#00FF0060",
       key.entries = c(1, seq(200, 2000, by = 200)))


# Level plots

bpal = colorRampPalette(pal)(41)

# notice something interesting here:

class(colorRampPalette)
class(colorRampPalette(pal))
class(colorRampPalette(pal)(41))

spplot(meuseg1, "dist", col.regions = bpal,
       cuts = 40)


