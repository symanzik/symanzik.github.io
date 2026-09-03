# L15a: Graphics_Options

# Assume we want to plot 6 different plots at the same time

myPlots = function(n = 6) {
  set.seed(7777)
  sapply(1:n, function(x) hist(rnorm(100, sd = x),
                               xlab = "x Values",
                               xlim = c(-20, 20),
                               main = paste("Histogram", x)))
}

dev.off()
myPlots()


# change layout with par() function

dev.off()
par(mfrow = c(3, 2))
myPlots()

dev.off()
par(mfrow = c(2, 3))
myPlots()


# adjust spacing around each plot

dev.off()
par(mfrow = c(2, 3), mar = c(0, 0, 0, 0))
myPlots()

dev.off()
par(mfrow = c(2, 3), mar = c(2, 1, 0, 0))
myPlots()

dev.off()
par(mfrow = c(2, 3), mar = c(3, 2, 2, 0))
myPlots()

dev.off()
par(mfrow = c(2, 3), mar = c(4, 4, 2, 0))
myPlots()

mtext("Histograms with 6 different SDs", 
      outer = TRUE,
      side = 3)


# allow space for a title above the 6 plots

dev.off()
par(mfrow = c(2, 3), mar = c(4, 4, 2, 0), oma = c(0, 0, 2, 0))
myPlots()
mtext("Histograms with 6 different SDs", 
      outer = TRUE,
      side = 3)

dev.off()
par(mfrow = c(2, 3), mar = c(4, 4, 2, 0), oma = c(0, 0, 2, 0))
myPlots()
mtext("Histograms with 6 different SDs", 
      outer = TRUE,
      side = 3,
      cex = 1.5)

dev.off()
par(mfrow = c(2, 3), mar = c(4, 4, 2, 0), oma = c(0, 0, 3, 0))
myPlots()
mtext("Histograms with 6 different SDs", 
      outer = TRUE,
      side = 3,
      line = 1,
      cex = 1.5)


# general layouts with layout() function

dev.off()
layout(matrix(c(1, 1, 1, 2, 2, 3, 
                4, 5, 5, 6, 6, 6), 
              2, 6, byrow = TRUE)) 
layout.show(6)

myPlots()


### a rather complicated layout for 22 plots

dev.off()

n3 = rep(0, 3)
n4 = rep(0, 4)

layout(matrix(c(n4, rep(1, 5), n3, rep(2, 5), n3, rep(3, 5), n3, rep(4, 5), n4,
                rep(5, 5), n3, rep(6, 5), n3, rep(7, 5), n3, rep(8, 5), n3, rep(9, 5),
                n4, rep(10, 5), n3, rep(11, 5), n3, rep(12, 5), n3, rep(13, 5), n4,
                rep(14, 5), n3, rep(15, 5), n3, rep(16, 5), n3, rep(17, 5), n3, rep(18, 5),
                n4, rep(19, 5), n3, rep(20, 5), n3, rep(21, 5), n3, rep(22, 5), n4),
              nrow = 5, byrow = TRUE))
layout.show(22)

par(mar = c(0, 0, 0, 0)) # should be adjusted to something more meaningful
myPlots()
myPlots()
myPlots()
myPlots(4)

dev.off()
