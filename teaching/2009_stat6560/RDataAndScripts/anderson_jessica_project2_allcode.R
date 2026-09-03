#install maps and splancs
library(splancs)

#plots of csr, clustered, and regular point processes
area=4*4
lambda=5
N=rpois(1,lambda*area)
u=runif(N,-2,2)
v=runif(N,0,4)
sq.poly=matrix(c(-2,2,2,-2,-2,0,0,4,4,0),5,2)
csr.pts=as.points(u,v)
b=2
lamnx=40
lamny=40
lamest=kernel2d(csr.pts,sq.poly,b,lamnx,lamny)
image(lamest$x,lamest$y,lamest$z,col=topo.colors(100),asp=1)
polymap(sq.poly,add=TRUE)
pointmap(csr.pts,add=TRUE)
title("Example of CSR Data")
#calculate khat
h=seq(.1,3,.1)
kpts=khat(csr.pts,sq.poly,h)
plot(h,kpts,type="l")
#calculate lhat
lpts=sqrt(kpts/pi)-h
plot(h,lpts,type="l")
abline(h=0,col=2)
title("L-Function for CSR Process")
#simulate a bunch of k and l's
nsim=99
sim=matrix(0,nsim,length(h))
for(i in 1:nsim){
sim[i,]=sqrt(khat(csr(sq.poly,N),sq.poly,h)/pi)-h
}
#get the range of simulations
env=apply(sim,2,range)
#plot range with l of interest
matplot(h,t(env),type="l",lty=2,col=3,ylab="L")
lines(h,lpts)
abline(h=0,col=2)
title("L-Function with C.I.")

sq.poly=matrix(c(0,1,1,0,0,0,0,1,1,0),5,2)
pcp.pts=pcp.sim(10,10,.001,sq.poly)
b=.15
lamnx=40
lamny=40
lamest=kernel2d(pcp.pts,sq.poly,b,lamnx,lamny)
image(lamest$x,lamest$y,lamest$z,col=topo.colors(100),asp=1)
polymap(sq.poly,add=TRUE)
pointmap(pcp.pts,add=TRUE)
title("Example of Poisson Cluster Process")
#calculate khat
h=seq(.1,1,.1)
kpts=khat(pcp.pts,sq.poly,h)
plot(h,kpts,type="l")
#calculate lhat
lpts=sqrt(kpts/pi)-h
plot(h,lpts,type="l")
abline(h=0,col=2)
title("L-Function for Cluster Process")
#simulate a bunch of k and l's
nsim=99
sim=matrix(0,nsim,length(h))
for(i in 1:nsim){
sim[i,]=sqrt(khat(csr(sq.poly,N),sq.poly,h)/pi)-h
}
#get the range of simulations
env=apply(sim,2,range)
#plot range with l of interest
matplot(h,t(env),type="l",lty=2,col=3,ylab="L")
lines(h,lpts)
abline(h=0,col=2)
title("L-Function with C.I.")

reg.pts=expand.grid(seq(0,1,.2),seq(0,1,.2))
reg.pts=as.points(reg.pts[,1],reg.pts[,2])
reg.pts[,1]=jitter(reg.pts[,1],.5)
reg.pts[,2]=jitter(reg.pts[,2],.5)
b=.1
lamnx=40
lamny=40
lamest=kernel2d(reg.pts,sq.poly,b,lamnx,lamny)
image(lamest$x,lamest$y,lamest$z,col=topo.colors(100),asp=1)
polymap(sq.poly,add=TRUE)
pointmap(reg.pts,add=TRUE)
title("Example of a Regular Point Process")
#calculate khat
h=seq(.05,1,.05)
kpts=khat(pts.csr,squarepoly,h)
plot(h,kpts,type="l")
#calculate lhat
lpts=sqrt(kpts/pi)-h
plot(h,lpts,type="l")
abline(h=0,col=2)
title("L-Function for Regular Process")
#simulate a bunch of k and l's
nsim=99
sim=matrix(0,nsim,length(h))
for(i in 1:nsim){
sim[i,]=sqrt(khat(csr(squarepoly,N),squarepoly,h)/pi)-h
}
#get the range of simulations
env=apply(sim,2,range)
#plot range with l of interest
matplot(h,t(env),type="l",lty=2,col=3,ylab="L")
lines(h,lpts)
abline(h=0,col=2)
title("L-Function with C.I.")



# Example 1 - Simulated process
#sample from h.p.s.p.p. in rectangle
set.seed(1234)
area=4*4
lambda=5
N=rpois(1,lambda*area)
polyx=c(-2,2,2,-2,-2)
polyy=c(0,0,4,4,0)
squarepoly=as.points(polyx,polyy)
pts.csr=csr(squarepoly,N)
b=5
lamnx=40
lamny=40
lamest=kernel2d(pts.csr,sq.poly,b,lamnx,lamny)
image(lamest$x,lamest$y,lamest$z,col=topo.colors(100),asp=1)
polymap(squarepoly,add=TRUE)
pointmap(pts.csr,add=TRUE)

#calculate khat
h=seq(.1,2.5,.1)
kpts=khat(pts.csr,squarepoly,h)
plot(h,kpts,type="l")

#calculate lhat
lpts=sqrt(kpts/pi)-h
plot(h,lpts,type="l")
abline(h=0,col=2)

#simulate a bunch of k and l's
nsim=99
sim=matrix(0,nsim,length(h))
for(i in 1:nsim){
sim[i,]=sqrt(khat(csr(squarepoly,N),squarepoly,h)/pi)-h
}

#get the range of simulations
env=apply(sim,2,range)

#plot range with l of interest
matplot(h,t(env),type="l",lty=2,col=3,ylab="L")
lines(h,lpts)
abline(h=0,col=2)

#another option for range (envelope)
env2=Kenv.csr(N,squarepoly,nsim,h,quiet=TRUE)

#plot the envelopes together
matplot(h,t(env),type="l",lty=2,col=3,ylab="L")
matplot(h,sqrt(cbind(env2$lower,env2$upper)/pi)-h,
type="l",lty=1,col=3,add=TRUE)
lines(h,lpts)
abline(h=0,col=2)

#find p-value for clustering at 0.2
test=(h==0.2)
testvals=c(lpts[test],sim[,test])
rnk=rank(testvals)[1]
testpeak.pval=((nsim+1)+1-rnk)/(nsim+1)
testpeak.pval

#find p-value for regularity at 0.9
test=(h==0.9)
testvals=c(lpts[test],sim[,test])
rnk=rank(testvals)[1]
testtrough.pval=(rnk)/(nsim+1)
testtrough.pval



#Example 2
female = read.table("female.txt",header=TRUE,skip=1)
female = as.points(female)
male = read.table("male.txt",header=TRUE,skip=1)
male = as.points(male)
comb = cbind(c(female[,1],male[,1]),c(female[,2],male[,2]))
comb = as.points(comb)
femalepoly = as.points(c(656800,660200,660200,656800),c(3109650,3109650,3113100,3113100))
malepoly = as.points(c(653200,656750,656750,653200),c(3109600,3109600,3111700,3111700))
combpoly = as.points(c(653200,660200,660200,653200),c(3109600,3109600,3113100,3113100))

polymap(combpoly,xlab="Longitude",ylab="Latitude")
pointmap(comb,add=TRUE)
polymap(femalepoly,xlab="Longitude",ylab="Latitude")
pointmap(female,add=TRUE)
polymap(malepoly,xlab="Longitude",ylab="Latitude")
pointmap(male,add=TRUE)

#FIRST FOR FEMALE COYOTES
#calculate khat
h=seq(1,2900,1)
kpts=khat(female,femalepoly,h)
plot(h,kpts,type="l")

#calculate lhat
lpts=sqrt(kpts/pi)-h
plot(h,lpts,type="l")
abline(h=0,col=2)

#simulate a bunch of k and l's
nsim=999
sim=matrix(0,nsim,length(h))
for(i in 1:nsim){
sim[i,]=sqrt(khat(csr(femalepoly,dim(female)[1]),femalepoly,h)/pi)-h
}

#get the range of simulations
env=apply(sim,2,range)

#plot range with l of interest
matplot(h,t(env),type="l",lty=2,col=3,ylab="L")
lines(h,lpts)
abline(h=0,col=2)

#find p-value for clustering at 1500
test=(h==1500)
testvals=c(lpts[test],sim[,test])
rnk=rank(testvals)[1]
testpeak.pval=((nsim+1)+1-rnk)/(nsim+1)
testpeak.pval

#find p-value for regularity at 2750
test=(h==2750)
testvals=c(lpts[test],sim[,test])
rnk=rank(testvals)[1]
testtrough.pval=(rnk)/(nsim+1)
testtrough.pval

#NEXT FOR MALE COYOTES
#calculate khat
h=seq(1,2300,1)
kpts=khat(male,malepoly,h)
plot(h,kpts,type="l")

#calculate lhat
lpts=sqrt(kpts/pi)-h
plot(h,lpts,type="l")
abline(h=0,col=2)

#simulate a bunch of k and l's
nsim=999
sim=matrix(0,nsim,length(h))
for(i in 1:nsim){
sim[i,]=sqrt(khat(csr(malepoly,dim(male)[1]),malepoly,h)/pi)-h
}

#get the range of simulations
env=apply(sim,2,range)

#plot range with l of interest
matplot(h,t(env),type="l",lty=2,col=3,ylab="L")
lines(h,lpts)
abline(h=0,col=2)

#find p-value for clustering at 100
test=(h==100)
testvals=c(lpts[test],sim[,test])
rnk=rank(testvals)[1]
testpeak.pval=((nsim+1)+1-rnk)/(nsim+1)
testpeak.pval

#find p-value for regularity at 2100
test=(h==2100)
testvals=c(lpts[test],sim[,test])
rnk=rank(testvals)[1]
testtrough.pval=(rnk)/(nsim+1)
testtrough.pval

#