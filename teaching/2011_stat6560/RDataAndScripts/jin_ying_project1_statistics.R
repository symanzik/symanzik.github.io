#########################################################################
###                                                                   ###
###                                                                   ###
###                                                                   ###
###                                                                   ###
###                       Author: Ying Jin                            ###
###                Rotating images from statistical graphs            ###
###                        Date: 2/20/2009                            ###
###                                                                   ###
###                                                                   ###
#########################################################################


############example 1#############################

library(pixmap)

x = rnorm(100,0,1)


for (i in 1:10)
{
  hist(x,col="red",ylab="FREQUENCY")
  Sys.sleep(0.4)

  plot(c(0,1), c(0,1), type = "n", 
    xlab = "", ylab = "", 
    axes = FALSE)
  Sys.sleep(0.5)

  hist(x,col="red",ylab="frequency")
  Sys.sleep(0.4)

  plot(c(0,1), c(0,1), type = "n", 
    xlab = "", ylab = "", 
    axes = FALSE)
  Sys.sleep(0.5)
}


############example 2############################

airdata=read.table(url("http://www.math.usu.edu/~adele/s5600/data/airpol.dat"),header=F)
colnames(airdata) = c("old","pop_hse","educ","gdhse","nonw","wcol","poor","mort",
"popden","hc","nox","so2","smsa","state","rain","jan","july","humid","case")

air=airdata[,c(8,12)]

outlier=air[c(-37),]
#plot(air)
#plot(outlier)


for (i in 1:10)
{
  plot(air, xlim = c(800, 1200))
  Sys.sleep(0.4)

  plot(c(0,1), c(0,1), type = "n", 
    xlab = "", ylab = "", 
    axes = FALSE)
  Sys.sleep(0.2)

  plot(outlier, xlim = c(800, 1200))
  Sys.sleep(0.4)

  plot(c(0,1), c(0,1), type = "n", 
    xlab = "", ylab = "", 
    axes = FALSE)
  Sys.sleep(0.2)
}



