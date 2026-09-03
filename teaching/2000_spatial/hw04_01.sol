Stat 5810, Homework #4.1 - Solutions
------------------------------------

1) CSR pattern inrectangular region:

isintriangle _ function (xy)
{
  # returns T if the pair xy falls in the triangle
  # with vertices (x, y) = (0, 0), (1, 0), and (0.5, 1)
  
  x _ xy[1]
  y _ xy[2]

  if (x < 0 || x > 1 || y < 0 || y > 1)
    return (F)
  if ((x < 0.5 && y > 2 * x) || (x > 0.5 && y > 2 - 2 * x))
    return (F)
  return (T)
}


makecsr _ function (n = 1, regiontest)
{
  # simulates n points of s homogeneous Poisson process
  # user has to provide a function that checks whether
  #   a point falls inside the region of interest
  # assume that bounding box is the rectangle with
  #   coordinate (0, 0) and (1, 1)

  csr _ matrix(0, n, 2)
  count _ 1
  while (count <= n)
  {
    xypair _ runif (2)
    if (regiontest (xypair))
      {
        csr[count, ] _ xypair
        count _ count + 1
      }
  }  

  csr
}

# test the isintriangle function:

isintriangle (c(0.2, 0.8))
isintriangle (c(0.5, 0.5))
isintriangle (c(1.0, 0.0))
isintriangle (c(0.5, 1.0))
isintriangle (c(-0.1, 0.2))
isintriangle (c(0.0, 0.0))

# the correct answers are given:

# [1] F
# [1] T
# [1] T
# [1] T
# [1] F
# [1] T

# now make the point pattern:

csr _ makecsr (1000, isintriangle)   

# Note - we are using our own function `isintriangle'
# as an input to the makecsr function

par (mfrow = c(2, 4), pty = "s")

# Draw the raw data and the triangle

plot (c(0, 1, 0.5, 0), c(0, 0, 1, 0), type = "l", 
  xlab = "xcoord", ylab = "yccord")
points (csr, pch = "x", cex = 0.1)
title (main = "(a) CSR in Triangle")

# Create a SPP, determine smooth estimate of the intensity,
# and draw 2 plots - no visible pattern, so indeed CSR ?!? 

csr.spp _ spp (csr)
csr.bin _ intensity (csr.spp, method = "kernel", 
   nx = 30, ny = 30, bw = 0.1)
image (csr.bin, main = "(b) Image of Smoothed Data")
contour (csr.bin, main = "(c) Contours of Smoothed Data")

# Draw a plot of Lhat which should be a straight line

csr.lhat _ Lhat (csr.spp)
abline (0, 1)
title (main = "(d) Lhat")

# Ooops, whats wrong? This isn't a straight line !
# This looks as if there is some clustering going on.
# But what about edge correction? A triangle is extremly
# irregularly shaped! Do the same, but now with
# a rectangular bounding box inside the area.

csr.inpoly _ points.in.poly (csr.spp[,1], csr.spp[,2], 
  bbox(c(0.3, 0.7), c(0.0, 0.6)))

csr.polyspp _ spp (csr[csr.inpoly,], 
  boundary = bbox(x = c(0.3, 0.7), y = c(0.0, 0.6)))

plot (c(0, 1, 0.5, 0), c(0, 0, 1, 0), type = "l", 
  xlab = "xcoord", ylab = "yccord", main = "(e) Data in Rectangle")
points (csr.polyspp, pch = "x", cex = 0.1)

csr.lhat2 _ Lhat (csr.polyspp)
abline (0, 1)
title (main = "(f) Lhat of Rectangle")

# add a title to the entire plot

mtext ("HW 4, Question 1", side = 3, outer = T, cex = 2, line = -5)

# NOTE: OMITTING EDGE CORRECTION IN A RECTANGLE IS STILL ACCEPTABLE -- 
# OMITTING EDGE CORRECTION IN OTHER CASES (SUCH AS THE INITIAL TRIANGLE) 
# CAN BE FATAL TO THE RESULT OF OUR ANALYSIS ...

# use these commands to open and close a postscript file, respectively
# postscript("HW4Q1.ps")
# dev.off()

=============================================================================


3) Sample point patterns from S+SpatialStats

par (mfrow = c(3, 5), pty = "s")

bramble.spp _ spp (bramble)
plot (bramble.spp, main = "(a1) bramble")
bramble.bin _ intensity (bramble.spp, method = "kernel", 
   nx = 30, ny = 30, bw = 0.2)
contour (bramble.bin, main = "(a2) Contours of Smoothed Data")
bramble.ghat _ Ghat (bramble.spp)
title (main = "(a3) Ghat of bramble")
bramble.lhat _ Lhat (bramble.spp)
title (main = "(a4) Lhat of bramble")
abline (0, 1)
bramble.env _ Lenv (bramble.spp, nsims = 20, process = "binomial")

bramble.hatdist _ bramble.lhat$values[,1] < 0.2
plot (bramble.lhat$values[bramble.hatdist,])
title ("(a5) Lhat in [0.0, 0.2]")
lines (bramble.env$dist[bramble.hatdist], 
  bramble.env$upper[bramble.hatdist])
lines (bramble.env$dist[bramble.hatdist], 
  bramble.env$lower[bramble.hatdist])
abline(0, 1)

# (a1) many points are overplotting and some regions are completely empty
# (a2) visible contours
# (a3) steep increase of Ghat
# (a4) Lhat seems to be linear, but take a closer look
# (a5) Lhat clearly above simulation envelopes
# ===> Clustering at small distances



lansing.spp _ spp (lansing)
plot (lansing.spp, main = "(b1) lansing")
lansing.bin _ intensity (lansing.spp, method = "kernel", 
   nx = 30, ny = 30, bw = 0.2)
contour (lansing.bin, main = "(b2) Contours of Smoothed Data")
lansing.ghat _ Ghat (lansing.spp)
title (main = "(b3) Ghat of lansing")
lansing.lhat _ Lhat (lansing.spp)
title (main = "(b4) Lhat of lansing")
abline (0, 1)
lansing.env _ Lenv (lansing.spp, nsims = 20, process = "binomial")

lansing.hatdist _ lansing.lhat$values[,1] < 0.2
plot (lansing.lhat$values[lansing.hatdist,])
title ("(b5) Lhat in [0.0, 0.2]")
lines (lansing.env$dist[lansing.hatdist], 
  lansing.env$upper[lansing.hatdist])
lines (lansing.env$dist[lansing.hatdist], 
  lansing.env$lower[lansing.hatdist])
abline(0, 1)

# (b1) difficult to see anything
# (b2) relatively smooth
# (b3) standard increase of Ghat
# (b4) Lhat seems to be linear, but take a closer look
# (b5) Lhat falls between simulation envelopes
# ===> CSR
# NOTE: If we split the data into its 2 components (maple and
# hickory, we get a different result - see Kaluzny et al.)



quakes.wash.spp _ spp (quakes.wash)
plot (quakes.wash.spp, main = "(c1) quakes.wash")
quakes.wash.bin _ intensity (quakes.wash.spp, method = "kernel", 
   nx = 30, ny = 30, bw = 5)
contour (quakes.wash.bin, main = "(c2) Contours of Smoothed Data")
quakes.wash.ghat _ Ghat (quakes.wash.spp)
title (main = "(c3) Ghat of quakes.wash")
quakes.wash.lhat _ Lhat (quakes.wash.spp)
title (main = "(c4) Lhat of quakes.wash")
abline (0, 1)
quakes.wash.env _ Lenv (quakes.wash.spp, nsims = 20, process = "binomial")

quakes.wash.hatdist _ quakes.wash.lhat$values[,1] < 6.0
plot (c(0.0, 6.0), c(0.0, 6.0), type = "n")
lines (quakes.wash.lhat$values[quakes.wash.hatdist,])
title ("(c5) Lhat in [0.0, 6.0] - rescaled")
lines (quakes.wash.env$dist[quakes.wash.hatdist], 
  quakes.wash.env$upper[quakes.wash.hatdist])
lines (quakes.wash.env$dist[quakes.wash.hatdist], 
  quakes.wash.env$lower[quakes.wash.hatdist])
abline(0, 1)

# (c1) data concentrated around 1 or 2 locations
# (c2) extreme peak, concentric circles
# (c3) extremely steep increase of Ghat
# (c4) Lhat far above the straight line and simulation envelopes
# (c5) Lhat rescaled - straight line is far off
# ===> Extreme clustering at small distances

# add a title to the entire plot

mtext ("HW 4, Question 3", side = 3, outer = T, cex = 2, line = -3)

# use these commands to open and close a postscript file, respectively
# postscript("HW4Q3.ps")
# dev.off()

### Note - fonts and symbols are different for the screen and postscript
### files. What looks good on the screen does not necessarily look good
### in a postscript file (see Figure HW 4, Question 3)...
### However, if we want to publish an S-Plus graphic in a paper, thesis,
### etc., postscript files often have advantages (in particular, we need
### ps files when writing the document with LaTeX). In that case, we should
### optimize the graphical output for the postscript file...


