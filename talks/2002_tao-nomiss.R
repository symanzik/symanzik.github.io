###
### R commands used during the demonstration of the R/GGobi link
### during the workshop on "Spatial Statistics: Integrating Statistics, GIS, 
### and Statistical Graphics", University of Washington, Seattle, Washington in
### the presentation "From ArcView/XGobi to R/GGobi: Recent Developments in 
### Exploratory Spatial Data Analysis" by Juergen Symanzik (October 18, 2002)
###
### Please be aware that some of the commands shown below are used for the 
### demonstration of general capabilities only and may not be helpful in an actual 
### analysis of the 2002_tao-nomiss.xml data set
###

# ----------------------------------------------------------------------------------

### First installation of Rggobi under Windows (see ggobi.org for other platforms):

# assume that R is installed as C:\R
# download current Rggobi version from ggobi.org
#   in R: Packages -> Install package from local zip file...
#       select the package to install, i.e., RggobiWin_0_4-1.zip
#       this will be unpacked as C:\R\rw1050\library\Rggobi

# in autoexec.bat: add appropriate path, e.g., 
#       PATH=[...];C:\R\RW1050\library\Rggobi\libs

# after Rggobi installation and path setting:
#       library(Rggobi)

# start (and stop) ggobi:
#       ggobi(matrix(1:15,5,3))
#       close.ggobi()
# see C:\R\rw1050\library\Rggobi\R-ex for other examples how to use ggobi through R

# installation of any of the spatial statistics packages
#   in R: Packages -> Install package from CRAN...
#       this will load the most recent version of the selected package
#       directly from the CRAN Web site

# ----------------------------------------------------------------------------------

# load the Rggobi library (at the start of a session)

library(Rggobi)

# TAO data (without missing values)
# replace the path below with your local path and filename

g _ ggobi("C:/JUE/Papers/2002_sp_ws/data/2002_tao-nomiss.xml", args= "-noinit")

# get varnames and data from ggobi

gvarnam _ getVariableNames.ggobi(.data = g[1])
gdata _ getData.ggobi(g[1])

gvarnam

# do some EDA for "Sea Surface Temp"

summary(gdata[,6])
sqrt(var(gdata[,6]))
boxplot(gdata[,6], xlab = gvarnam[6])

hist(gdata[,6], xlab = gvarnam[6], main = paste(gvarnam[6]))

#
# do some ESDA in GGobi: look at SST & Humidity, the 2 years, locations
# where data is only available for 1 year (jitter latitude and longitude), 
# the time series components, etc.
#
# in particular - note the differences for 1993 and 1997
#

# create subsets of "Sea Surface Temp" for 1993 and 1997 

gsst93 _ gdata[,6][gdata[,1] == 1993]
gsst97 _ gdata[,6][gdata[,1] == 1997]

# do some EDA for subsets of "Sea Surface Temp"

summary(gsst93)
sqrt(var(gsst93))
summary(gsst97)
sqrt(var(gsst97))

par(mfrow = c(2,2))
hist(gsst93, xlab = gvarnam[6], main = paste(gvarnam[6], "(1993)"))
hist(gsst97, xlab = gvarnam[6], main = paste(gvarnam[6], "(1997)"))
boxplot(gsst93, gsst97, xlab = gvarnam[6])

# Q-Q-Plots

par(mfrow = c(1,2))
qqnorm(gsst93, main = paste("Normal Q-Q Plot for SST (1993)"),
         xlab = "Theoretical Quantiles",
         ylab = "Sample Quantiles")
qqnorm(gsst97, main = paste("Normal Q-Q Plot for SST (1997)"),
         xlab = "Theoretical Quantiles",
         ylab = "Sample Quantiles")

# so are we done now - does the data really belong to two normal distributions ??? 
# return to GGobi to answer this yourself


### demonstrate how to use additional spatial libraries in R


## use Splancs library

library(splancs)

gplancs _ as.points(gdata[,3], gdata[,2])
pdense(gplancs, bbox(gplancs))

# plot point locations and kernel estimate

par(mfrow = c(1,2))
pointmap(gplancs, main = "Point Locations")
image(kernel2d(gplancs, sbox(gplancs, .1, .8),
  h0 = 1, nx = 50, ny = 50), main = "Kernel Estimate")



## use sgeostat library

library(sgeostat)

ggeo _ point(as.data.frame(cbind(gdata[,6], gdata[,3], gdata[,2])),
         x = "V2", y = "V3")
gpairs _ pair(ggeo, maxdist = 5)

# plot variogram cloud plot and fit trend surface
# (does this surface make any sense - check yourself in GGobi)

par(mfrow = c(1,2))
spacecloud(ggeo, gpairs, 'V1')
gbeta _ fit.trend(ggeo, at = 'V1', np = 1)

# return residuals to GGobi

addVariable.ggobi(gbeta$residuals, "Residuals")


#
# do some further ESDA in GGobi, in particular of the residuals
# (it should be easy to determine whether the fitted surface made any sense)
#


# close GGobi

close(g)


