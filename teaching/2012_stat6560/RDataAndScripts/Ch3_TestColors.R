# plot a few lines and change the colors;
# then upload the result to
#   http://www.vischeck.com/vischeck/vischeckImage.php
# and check whether your choice of colors remain
# distinguishable for viewers with color vision deficiencies
#
# Juergen Symanzik
# 2/3/2009

# write directly to jpg file
jpeg(filename = "Ch3_ColorPlot.jpg", width = 480, height = 480, 
  units = "px", pointsize = 12, quality = 95, bg = "white")

# do the actual plotting
xvals = seq(0, 2 * pi, length = 100)
colused = c("yellow", "red", "green", "blue", "purple")

plot(xvals, sin(xvals), col = colused[1], 
  type = "l",
  lwd = 2,
  xlab = "Range",
  xlim = c(0, 8.5),
  ylab = "Curve Values",
  ylim = c(-1.2, 1.2),
  main = "Various Sine Curves"
)

lines(xvals, 0.9*sin(xvals + 0.2), col = colused[2], lwd = 2)
lines(xvals, 0.8*sin(xvals + 0.8) + 0.2, col = colused[3], lwd = 2)
lines(xvals, 1.1*sin(xvals + 1.5) - 0.1, col = colused[4], lwd = 2)
lines(xvals, 0.7*sin(xvals + 2.2) + 0.3, col = colused[5], lwd = 2)

legend (2 * pi + 0.2, 1, 
  #c("Curve 1", "Curve 2", "Curve 3", "Curve 4", "Curve 5"),
  legend = colused,
  col = colused,
  text.col = colused,
  lwd = 2
)

# close jpg file
dev.off()


# Hint: to identify possible colors in R by name, use
colors()



