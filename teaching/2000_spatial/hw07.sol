Stat 5810, Homework #7 - Solutions
----------------------------------

3) ArcView/XGobi Places data ("Climate") in S-Plus:

# Read in the data and create a data frame (using the XGobi names
# as variable names)

places _ matrix(scan("/home/symanzik/axx/xgobi/data_xgobi/places"), 
  329, 14, byrow=T) 
places.col _ scan("/home/symanzik/axx/xgobi/data_xgobi/places.col") 

> places.col
 [1] "Climate"     "HousingCost" "HlthCare"    "Crime"       "Transp"     
 [6] "Educ"        "Arts"        "Recreat"     "Econ"        "CaseNum"    
[11] "Long"        "Lat"         "Pop"         "StNum"      

places.frame _ data.frame (places) 
dimnames (places.frame)[[2]] _ places.col

# Before we can model a meaningful variogram, we have to assess
# (and eventually remove) the large scale variation, i.e., 
# do a trend surface analysis

# First, let's do some basic graphical assessment 

par (mfrow = c(2, 2))
plot (places.frame$Long, places.frame$Lat, main="Sampling Locations")

hist (places.frame$Climate, main="Histogram")

places.interp _ interp (x = places.frame$Long, y = places.frame$Lat, 
  z = places.frame$Climate)

contour (places.interp, main = "Contour Plot")
image (places.interp, main = "Intensity Plot") 

# There seems to be some trend  - and this is more than just a linear
# trend surface - so let's try a quadratic trend surface

places.lsfit <- lsfit (cbind(places.frame$Long, places.frame$Long^2,
  places.frame$Lat, places.frame$Lat^2, places.frame$Long*places.frame$Lat), 
  places.frame$Climate)

> ls.print(places.lsfit)
Residual Standard Error = 82.4645,  Multiple R-Square = 0.5412
N = 329,  F-statistic = 76.1871 on 5 and 323 df, p-value = 0

                coef  std.err   t.stat p.value 
Intercept  1743.4951 341.1623   5.1105   0e+00
       X1    71.4513   5.2094  13.7157   0e+00
       X2     0.3179   0.0212  14.9849   0e+00
       X3   121.2101  11.7232  10.3393   0e+00
       X4    -2.0885   0.1813 -11.5220   0e+00
       X5    -0.3071   0.0752  -4.0835   1e-04

# Note that all coefficients are significant - thus, use all estimated parameters
# for the predication

places.trend _ cbind(rep(1, 329), places.frame$Long, places.frame$Long^2,
    places.frame$Lat, places.frame$Lat^2, places.frame$Long*places.frame$Lat) %*%
  places.lsfit$coef

# Compare contour and image plots for data and estimated trend surface

places.trendinterp _ interp (x = places.frame$Long, y = places.frame$Lat, 
  z = places.trend)
par (mfrow = c(3, 2))
contour (places.interp, main = "Contour Plot - Data")
image (places.interp, main = "Intensity Plot - Data") 
contour (places.trendinterp, main = "Contour Plot - Trend")
image (places.trendinterp, main = "Intensity Plot - Trend") 

# Detrend the data and look at the residuals

places.res _ places.frame$Climate - places.trend

places.resinterp _ interp (x = places.frame$Long, y = places.frame$Lat, 
  z = places.res)
contour (places.resinterp, main = "Contour Plot - Residuals")
image (places.resinterp, main = "Intensity Plot - Residuals") 

# Certainly not perfect but good enough for our needs... - Now,
# create the variogram cloud, variogram (mom), and variogram (robust)

par (mfrow = c(2, 2))
places.vcloud _ variogram.cloud (places.res ~ loc (Long, Lat), 
  data = places.frame, maxdist = 60) 
places.varmom _ variogram (places.res ~ loc (Long, Lat), 
  data = places.frame, maxdist = 60) 
places.varrob _ variogram (places.res ~ loc (Long, Lat), 
  data = places.frame, maxdist = 60, method = "robust") 

plot(places.vcloud, main = "Variogram Cloud") 
plot(places.varmom, main = "Variogram (MoM)") 
plot(places.varrob, main = "Variogram (Robust)") 

# Finally try to fit a gaussian theoretical variogram model

model.variogram (places.varrob, fun = gauss.vgram, range = 50, sill = 32000)
title("Theoretical Var Model") 
