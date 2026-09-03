### trilpr and trillr functions for local polynomial regression estimates
### Written by Mike Minnotte

###################################################################
#                                                                 #
# Functions for calculating and plotting trivariate local         #
# polynomial regression estimates.                                #
#                                                                 #
# Save as text, then source into R                                #
#                                                                 #
# trilpr - local polynomial regression of arbitrary order         #
# trillr - local linear regression, much faster than trilpr       #
#                                                                 #
###################################################################

trilpr<-function(x,y,z,xh,yh,p=1,xlist=NULL,ylist=NULL,extendx=.1,nx=51,
	extendy=.1,ny=51,doplot=T,xlab="x",ylab="y",zlab="m(x,y)",phi=30,...)

{# trivariate local polynomial regression (loess) estimate
# x, y - data (explanatory variables)
# z - response variable
# xh, yh - bandwidth (smoothing parameters; standard deviation of normal kernel)
# p - order of locally fitted polynomials (default - linear)
# xlist, ylist - points of evaluation
# extendx, extendy - if xlist (ylist) NULL, how far beyond the range of 
#   the data to calculate estimate
# nx, ny - number of points of evaluation
# doplot - if T, plot perspective plot of results, else return (x,y) list for
#   later plotting
# xlab, ylab, zlab - axis labels
if (length(x)!=length(y) | length(x)!=length(z))
	stop("Lengths of x, y, and z must be equal")
if (is.null(xlist))
	{xr<-range(x)
	xd<-(xr[2]-xr[1])*extendx
	xlist<-seq(xr[1]-xd,xr[2]+xd,length=nx)}
else
	nx<-length(xlist)
if (is.null(ylist))
	{yr<-range(y)
	yd<-(yr[2]-yr[1])*extendy
	ylist<-seq(yr[1]-yd,yr[2]+yd,length=ny)}
else
	ny<-length(ylist)

par(err=-1)
mhat<-matrix(0,nx,ny)
n<-length(x)
Y<-matrix(z,n,1)

for (i in 1:nx) for (j in 1:ny)
	{W<-dnorm(x,xlist[i],xh)*dnorm(y,ylist[j],yh)
	X<-matrix(rep(1,n),ncol=1)
	if (p > 0) for (k in 1:p) for (m in 0:k)
		X<-cbind(X,(x-xlist[i])^(k-m)*(y-ylist[j])^m)
	betas<-lsfit(X,Y,wt=W,intercept=F)$coef
	mhat[i,j]<-betas[1]}

if (doplot) {
	persp(xlist,ylist,mhat,phi=phi,...)
	return()}
else {
	fitted.values<-rep(0,n)
	residuals<-rep(0,n)
	for (i in 1:n) 
		{W<-dnorm(x,x[i],xh)*dnorm(y,y[i],yh)
		X<-matrix(rep(1,n),ncol=1)
		if (p > 0) for (k in 1:p) for (m in 0:k)
			X<-cbind(X,(x-x[i])^(k-m)*(y-y[i])^m)
		betas<-lsfit(X,Y,wt=W,intercept=F)$coef
		fitted.values[i]<-betas[1]
		residuals[i]<-z[i]-fitted.values[i]}
	return(list(x=xlist,y=ylist,z=mhat,fitted.values=fitted.values,
			residuals=residuals))}
}

#######################################################################

trillr<-function(x,y,z,xh,yh,xlist=NULL,ylist=NULL,extendx=.1,nx=51,
	extendy=.1,ny=51,doplot=T,xlab="x",ylab="y",zlab="m(x,y)",phi=30,...)

{# trivariate local linear regression (loess) estimate
# x, y - data (explanatory variables)
# z - response variable
# xh, yh - bandwidth (smoothing parameters; standard deviation of normal kernel)
# xlist, ylist - points of evaluation
# extendx, extendy - if xlist (ylist) NULL, how far beyond the range of 
#   the data to calculate estimate
# nx, ny - number of points of evaluation
# doplot - if T, plot perspective plot of results, else return (x,y) list for
#   later plotting
# xlab, ylab, zlab - axis labels
if (length(x)!=length(y) | length(x)!=length(z))
	stop("Lengths of x, y, and z must be equal")
if (is.null(xlist))
	{xr<-range(x)
	xd<-(xr[2]-xr[1])*extendx
	xlist<-seq(xr[1]-xd,xr[2]+xd,length=nx)}
else
	nx<-length(xlist)
if (is.null(ylist))
	{yr<-range(y)
	yd<-(yr[2]-yr[1])*extendy
	ylist<-seq(yr[1]-yd,yr[2]+yd,length=ny)}
else
	ny<-length(ylist)

par(err=-1)
mhat<-matrix(0,nx,ny)
n<-length(x)
Y<-matrix(z,n,1)

for (i in 1:nx) 
	{Kx<-dnorm(x,xlist[i],xh)
	dx<-x-xlist[i]
	dx2<-dx^2
	for (j in 1:ny)
		{K<-Kx*dnorm(y,ylist[j],yh)
		dy<-y-ylist[j]
		T0<-sum(K)
		Tx<-sum(K*dx)
		Txx<-sum(K*dx2)
		Ty<-sum(K*dy)
		Tyy<-sum(K*dy^2)
		Txy<-sum(K*dx*dy)
		Tz<-sum(K*z)
		Txz<-sum(K*dx*z)
		Tyz<-sum(K*dy*z)
		Sxxyy<-Txx*Tyy-Txy^2
		Sxyy<-Ty*Txy-Tx*Tyy
		Sxxy<-Tx*Txy-Ty*Txx
		mhat[i,j]<-(Tz*Sxxyy+Txz*Sxyy+Tyz*Sxxy)/
			(T0*Sxxyy+Tx*Sxyy+Ty*Sxxy)}}
if (doplot) {
	persp(xlist,ylist,mhat,phi=phi,...)
	return()}
else {
	fitted.values<-rep(0,n)
	residuals<-rep(0,n)
	for (i in 1:n) 
		{K<-dnorm(x,x[i],xh)*dnorm(y,y[i],yh)
		dx<-x-x[i]
		dy<-y-y[i]
		T0<-sum(K)
		Tx<-sum(K*dx)
		Txx<-sum(K*dx^2)
		Ty<-sum(K*dy)
		Tyy<-sum(K*dy^2)
		Txy<-sum(K*dx*dy)
		Tz<-sum(K*z)
		Txz<-sum(K*dx*z)
		Tyz<-sum(K*dy*z)
		Sxxyy<-Txx*Tyy-Txy^2
		Sxyy<-Ty*Txy-Tx*Tyy
		Sxxy<-Tx*Txy-Ty*Txx
		fitted.values[i]<-(Tz*Sxxyy+Txz*Sxyy+Tyz*Sxxy)/
			(T0*Sxxyy+Tx*Sxyy+Ty*Sxxy)
		residuals[i]<-z[i]-fitted.values[i]}
	return(list(x=xlist,y=ylist,z=mhat,fitted.values=fitted.values,
			residuals=residuals))}
}

