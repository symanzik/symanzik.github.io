
#########################################################################
###                                                                   ###
###                                                                   ###
###                                                                   ###
###                                                                   ###
###                       Author: Ying Jin                            ###
###   parallel images of two different graphs to show the difference  ###
###                       Date: 2/20/2009                             ###
###                                                                   ###
###                                                                   ###
#########################################################################





##############example 1############################

par(mfrow = c(1, 2))


x = rnorm(100,0,1)

hist(x,col="red",ylab="FREQUENCY")


hist(x,col="red",ylab="frequency")



############example 2############################

airdata=read.table(url("http://www.math.usu.edu/~adele/s5600/data/airpol.dat"),header=F)
colnames(airdata) = c("old","pop_hse","educ","gdhse","nonw","wcol","poor","mort",
"popden","hc","nox","so2","smsa","state","rain","jan","july","humid","case")

air=airdata[,c(8,12)]

par(mfrow=c(1,2))
outlier=air[c(-37),]
plot(air, xlim = c(800, 1200))
plot(outlier, xlim = c(800, 1200))

