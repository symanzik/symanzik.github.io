moonPhase <- function(x, y, phase, size=.07) {
  # phase 1: first quarter
  #       2: full
  #       3: last quarter
  #       4: new
  # size is in inches
  n <- 17
  angle <- seq(0, 2*pi, length=n)
  xx <- x + cos(angle)*xinch(size)
  yy <- y + sin(angle)*yinch(size)
  if (phase == 4)
    fill <- "black"
  else
    fill <- "white"
  polygon(xx, yy, col=fill)
  if (phase == 1)
    polygon(xx[(n/4):(n*3/4) + 1],
            yy[(n/4):(n*3/4) + 1],
            col="black")
  if (phase == 3)
    polygon(xx[c(1:(n/4 + 1), (n*3/4 + 1):n)],
            yy[c(1:(n/4 + 1), (n*3/4 + 1):n)],
            col="black")
}

# Data from Land Information New Zealand
# http://hydro.linz.govt.nz
# + 1 for daylight saving
hours <- c(18, 18, 19, 20, 21, 22, 23,
           0, 1, 2, 3, 4, 5, 5,
           6, 7, 8, 9, 10, 11, 12,
           13, 13, 14, 15, 15, 16) + 1
hours[7] <- 0 # 23 + 1 = 0 on a 24-hour clock
mins <- c(9, 57, 49, 46, 48, 54, 59,
          59, 52, 41, 28, 14, 1, 52,
          36, 43, 41, 39, 38, 35, 26,
          10, 49, 26, 2, 39, 16)
lowTideDate <- ISOdatetime(2005, 2, c(1:6,8:28),
                           hours, mins, 0)
lowTideHour <- ISOdatetime(2005, 2, 1,
                           hours, mins, 0)
phases <- ISOdatetime(2005, 2, c(2, 9, 16, 24),
                      c(19, 10, 12, 16) + 1,
                      c(28, 30, 16, 55), 0)
mainHours <- ISOdatetime(2005, 2, 1,
                         c(0, 4, 8, 12, 16, 20, 23), 
                         c(rep(0, 6), 59), 
                         c(rep(0, 6), 59))

library(pixmap)
# Original image from NASA
# http://grin.hq.nasa.gov/ABSTRACTS/GPN-2000-000473.html
moon <- read.pnm(system.file(file.path("Images", 
                                       "GPN-2000-000473halfsize.pnm"), 
                             package="RGraphics"))

#http://people.sc.fsu.edu/~burkardt/data/pnm/pnm.html

#moon <- read.pnm("NASA_Moon_GPN-2000-000473.bmp")
#plot(moon)

#moon <- read.pnm(system.file("pictures/logo.ppm", package="pixmap")[1])
#plot(moon)

moon <- read.pnm("PNM_Info_snail2.pnm")
plot(moon)

jpeg(filename = "Murrell_Snake.jpg", width = 480, height = 480, 
  units = "px", pointsize = 12, quality = 95, bg = "white")

par(pty="s", xaxs="i", yaxs="i", cex=.7)
plot.new()
addlogo(moon, 0:1, 0:1, asp=1)
par(new=TRUE, xaxs="r", yaxs="r", las=1)
plot(lowTideDate, lowTideHour, type="n",
     ylim=range(mainHours), axes=FALSE, ann=FALSE)
# dashed reference lines
midday <- ISOdatetime(2005, 2, 1, 12, 0, 0)
abline(h=midday, v=phases,
       col="black", lty="dashed")
# grey "repeat" of tide info to show gradient
lines(lowTideDate[6:7], 
      c(ISOdatetime(2005, 1, 31,
                    hours[6], mins[6], 0),
        lowTideHour[7]),
      lwd=2, col="grey50")
points(lowTideDate[6:7], 
       c(ISOdatetime(2005, 1, 31,
                     hours[6], mins[6], 0),
         lowTideHour[7]),
       pch=16, cex=.7, col="grey50")
for (subset in list(1:6, 7:27)) {
  lines(lowTideDate[subset], lowTideHour[subset],
        lwd=2, col="black")
  points(lowTideDate[subset], lowTideHour[subset],
         pch=16, cex=.7, col="black")
}
box()
axis.POSIXct(1, lowTideDate)
axis.POSIXct(2, at=mainHours, format="%H:%M")
mtext("Time of Low Tide (NZDT)", side=2, line=4, las=0)
mtext("Auckland, New Zealand 2005", side=1, line=3)
axis(3, at=phases, labels=FALSE)
par(xpd=NA)
ymax <- par("usr")[4]
for (i in 1:4)
  moonPhase(phases[i], ymax + yinch(.2), c(3, 4, 1, 2)[i])
mtext("Phases of the Moon", side=3, line=3)

dev.off()



