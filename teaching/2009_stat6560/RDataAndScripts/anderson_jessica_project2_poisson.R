#install splancs
library(splancs)

#sample from homogeneous poisson point process in rectangle
set.seed(1234)
area=4*4
lambda=5
N=rpois(1,lambda*area)
polyx=c(-2,2,2,-2,-2)
polyy=c(0,0,4,4,0)
squarepoly=as.points(polyx,polyy)
pts.csr=csr(squarepoly,N) #simulates N csr points over region squarepoly
polymap(squarepoly)
pointmap(pts.csr,add=TRUE)

#to look at the plot in more detail, we look at a density plot
b=.5
lamnx=50
lamny=50
lamest=kernel2d(pts.csr,squarepoly,b,lamnx,lamny)
image(lamest$x,lamest$y,lamest$z,col=topo.colors(100),asp=1)
polymap(squarepoly,add=TRUE)
pointmap(pts.csr,pch=20,cex=2,add=TRUE)

#calculate khat to test for clustering/regularity
h=seq(.1,2.5,.1)
kpts=khat(pts.csr,squarepoly,h)
plot(h,kpts,type="l")

#calculate lhat
lpts=sqrt(kpts/pi)-h
plot(h,lpts,type="l")
abline(h=0,col=2)

#simulate many k and l's
nsim=99 #999 would be preferred, but 99 for sake of time here
sim=matrix(0,nsim,length(h))
for(i in 1:nsim){
sim[i,]=sqrt(khat(csr(squarepoly,N),squarepoly,h)/pi)-h
}

#get the range of simulations
env=apply(sim,2,range)

#plot range with l
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