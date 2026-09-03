#install splancs
library(splancs)

#Coyote Example

data_url1 <- "http://www.math.usu.edu/~symanzik/teaching/2009_stat6560/RDataAndScripts/anderson_jessica_project2_female.txt"
data_url2 <- "http://www.math.usu.edu/~symanzik/teaching/2009_stat6560/RDataAndScripts/anderson_jessica_project2_male.txt"
female <- read.table(url(data_url1), header=T)
male <- read.table(url(data_url2), header=T)
#female <- read.table("anderson_jessica_project2_female.txt",header=TRUE,skip=1)
#male <- read.table("anderson_jessica_project2_male.txt",header=TRUE,skip=1)

female = as.points(female)
male = as.points(male)
comb = cbind(c(female[,1],male[,1]),c(female[,2],male[,2]))
comb = as.points(comb)
femalepoly = as.points(c(656800,660200,660200,656800),c(3109650,3109650,3113100,3113100))
malepoly = as.points(c(653200,656750,656750,653200),c(3109600,3109600,3111700,3111700))
combpoly = as.points(c(653200,660200,660200,653200),c(3109600,3109600,3113100,3113100))

#plot density of data, with points
#combined male and female coyotes
b=700
lamnx=100
lamny=100
lamest=kernel2d(comb,combpoly,b,lamnx,lamny)
image(lamest$x,lamest$y,lamest$z,col=topo.colors(100),asp=1)
polymap(combpoly,xlab="Longitude",ylab="Latitude",add=TRUE)
pointmap(male,pch=1,add=TRUE)
pointmap(female,pch=2,add=TRUE)
title("Male and Female Coyote Locations")
legend("topright",c("Male","Female"),pch=c(1,2))
#female coyotes
b=500
lamnx=100
lamny=100
lamest=kernel2d(female,femalepoly,b,lamnx,lamny)
image(lamest$x,lamest$y,lamest$z,col=topo.colors(100),asp=1)
polymap(femalepoly,xlab="Longitude",ylab="Latitude",add=TRUE)
pointmap(female,add=TRUE)
title("Female Coyote Locations")
#male coyotes
b=400
lamnx=100
lamny=100
lamest=kernel2d(male,malepoly,b,lamnx,lamny)
image(lamest$x,lamest$y,lamest$z,col=topo.colors(100),asp=1)
polymap(malepoly,xlab="Longitude",ylab="Latitude",add=TRUE)
pointmap(male,add=TRUE)
title("Male Coyote Locations")

#FIRST FOR FEMALE COYOTES
#calculate khat
h=seq(1,2000,1)
kpts=khat(female,femalepoly,h)
plot(h,kpts,type="l")

#calculate lhat
lpts=sqrt(kpts/pi)-h
plot(h,lpts,type="l")
abline(h=0,col=2)

#simulate a bunch of k and l's
nsim=99 #999 would be preferred, but 99 for sake of time
sim=matrix(0,nsim,length(h))
for(i in 1:nsim){
sim[i,]=sqrt(khat(csr(femalepoly,dim(female)[1]),femalepoly,h)/pi)-h
}

#get the range of simulations
env=apply(sim,2,range)

#plot range with l of interest
matplot(h,t(env),type="l",lty=2,col=3,ylab="L",ylim=range(lpts))
lines(h,lpts)
abline(h=0,col=2)

#find p-value for clustering at 1500
test=(h==1500)
testvals=c(lpts[test],sim[,test])
rnk=rank(testvals)[1]
testpeak.pval=((nsim+1)+1-rnk)/(nsim+1)
testpeak.pval

#find p-value for regularity at 2000
test=(h==2000)
testvals=c(lpts[test],sim[,test])
rnk=rank(testvals)[1]
testtrough.pval=(rnk)/(nsim+1)
testtrough.pval

#NEXT FOR MALE COYOTES
#calculate khat
h=seq(1,2000,1)
kpts=khat(male,malepoly,h)
plot(h,kpts,type="l")

#calculate lhat
lpts=sqrt(kpts/pi)-h
plot(h,lpts,type="l")
abline(h=0,col=2)

#simulate a bunch of k and l's
nsim=99
sim=matrix(0,nsim,length(h))
for(i in 1:nsim){
sim[i,]=sqrt(khat(csr(malepoly,dim(male)[1]),malepoly,h)/pi)-h
}

#get the range of simulations
env=apply(sim,2,range)

#plot range with l of interest
matplot(h,t(env),type="l",lty=2,col=3,ylab="L",ylim=range(lpts))
lines(h,lpts)
abline(h=0,col=2)

#find p-value for clustering at 100
test=(h==100)
testvals=c(lpts[test],sim[,test])
rnk=rank(testvals)[1]
testpeak.pval=((nsim+1)+1-rnk)/(nsim+1)
testpeak.pval

#find p-value for regularity at 2000
test=(h==2000)
testvals=c(lpts[test],sim[,test])
rnk=rank(testvals)[1]
testtrough.pval=(rnk)/(nsim+1)
testtrough.pval

