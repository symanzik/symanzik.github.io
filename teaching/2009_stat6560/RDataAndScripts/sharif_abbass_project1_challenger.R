###################################################################################################################################
### The following code is written to analyze visually the data relating to the Challenger Disaster.                             ###
### Author: Abbass Al Sharif 																        ###
### Date: Jan 29, 2009                                                                                                          ###
### Part of this code was adopted from Coryn A.L. Bailer-Jones' analysis code for the Challenger data                           ###
### For more information, please refer to http://www.mpia-hd.mpg.de/homes/calj/ss2007_mlpr/course/linear_methods_part2_Rscripts ###
### Note that the graphics part of the code was developed by me.                                                                ###
###################################################################################################################################

### Read data from the web
data_url<-"http://www.math.usu.edu/~symanzik/teaching/2009_stat6560/RDataAndScripts/sharif_abbass_project1_challenger.csv"
challenger<-read.table(url(data_url), header=TRUE, sep=",")

m<-challenger[,1]
r<-challenger[,2]
temperature<-challenger[,3]

### plot all data
par(xaxs="i", yaxs="i")
x.at <- seq(20, 80, by=5)
y.at <- seq(0, 6, by=1)
plot(temperature, r, xlim=range(x.at), ylim=range(y.at), xlab='Joint temperature / F', ylab='No. of O-ring failures', pch= 19,type="p",axes=FALSE)
axis(1, at= x.at, lwd.ticks = 0)
axis(2, at= y.at, lwd.ticks = 0)
abline(v=31, col='blue')
abline(h=6, col="black")
abline(v=80, col="black")


### original misleading plot!
par(xaxs="i", yaxs="i")
x.at <- seq(45, 80, by=5)
y.at <- seq(0, 3, by=1)
failures <- which(r!=0) ## selects failure cases
plot(temperature[failures], r[failures],xlim = range(x.at), ylim= range(y.at), pch= 19,type= "p", xlab='Calculated Joint Temperature F', ylab='Number of Incidents', axes=FALSE)
axis(1, at= x.at, lwd.ticks = -1)
axis(2, at= y.at, lwd.ticks = -1)
grid(ny=3, col="black", lty="solid");
abline(h=3, col="black")

### plot all data
par(xaxs="i", yaxs="i")
x.at <- seq(20, 80, by=5)
y.at <- seq(0, 6, by=1)
plot(temperature, r, main = "Scatterplot of all Data", xlim=range(x.at), ylim=range(y.at), xlab='Joint temperature / F', ylab='No. of O-ring failures', pch= 19,type= "p",axes=FALSE)
axis(1, at= x.at, lwd.ticks = 0)
axis(2, at= y.at, lwd.ticks = 0)
abline(v=31, col='blue')
abline(h=6, col="black")
abline(v=80, col="black")
legend("topright", inset=.05,c("Fitted Curve","Temp at 31 F"), fill=c("red", "blue"))
### Fit and plot a curve using all data
fit.glm <- glm(cbind(r,m-r) ~ temperature, data=challenger, family=binomial)
# predict probability of failure of a single O-ring joint at the following temperature
testtemp <- seq(10,100,1)  
pred.glm <- predict(fit.glm, data.frame(temperature=testtemp), type="response" )
lines(testtemp, 6*pred.glm, col="red")


### plot only launches with at least one failure and their fitted curve
failures <- which(r!=0)
par(xaxs="i", yaxs="i")
x.at <- seq(20, 80, by=5)
y.at <- seq(0, 3, by=1)
plot(temperature[failures], r[failures], xlim=range(x.at), ylim=range(y.at), xlab='Joint temperature / F', ylab='No. O-ring failures',pch= 19,type= "p", axes = F)
axis(1, at= x.at, lwd.ticks = 0)
axis(2, at= y.at, lwd.ticks = 0)
grid(ny=3, col="black", lty="solid");
abline(h=3, col="black")
### Fit and plot only data with failures
fit2.glm <- glm(cbind(r,m-r) ~ temperature, data=challenger, subset=which(r!=0), family=binomial) 
lines(testtemp, 6*predict(fit2.glm, data.frame(temperature=testtemp), type="response"), col="red")

