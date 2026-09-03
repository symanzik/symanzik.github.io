#######################################################################
#                                                                     #
# Data Image R Functions                                              #
#                                                                     #
# Save as text, then source into R  - use library(mva) for distance calcs #
#                                                                     #
# Copyright 1998, 2000, Michael C. Minnotte                           #
#                                                                     #
# For assistance, or to report bugs, please contact:                  #
#                                                                     #
# <a href="mailto:minnotte@math.usu.edu">minnotte@math.usu.edu</a>                                               #
#                                                                     #
# Last updated, October 29, 2002                                      #
#                                                                     #
# A data image is a way to look at moderately high-dimensional data   #
# sets for structure across many variables.  It was developed by Mike #
# Minnotte and <a href="http://www.stat.sc.edu/~west">Webster West</a>, and owes a lot to the color histogram    #
# ideas of <a href="http://www.galaxy.gmu.edu/stats/faculty/wegman.html">Ed Wegman</a>.                                                 #
#                                                                     #
# For more information about data images, see:                        #
#                                                                     #
# <a href="http://math.usu.edu/~minnotte/research/pubs.html#DataImage">"The Data Image: A Tool for Exploring High Dimensional Data"</a>        #
#                                                                     #
# Functions include:                                                  #
#                                                                     #
# dataimage - main function; calculates (and optionally plots)        #
#    data image based on any of several sorting schemes, for both     #
#    observations and variables                                       #
# diplot - data image plotting function; usually called automatically #
#    from dataimage                                                   #
# distmat - calculate a distance matrix                               #
# hco - calculate a heirarchical clustering ordering                  #
# isto - calculate an ordering based on spanning tours using furthest #
#    or nearest insertion                                             #
#                                                                     #
#######################################################################

dataimage<-function(data,obs.sort="complete",var.sort="complete",std=T,
	obs.met="euclidean",var.met="euclidean",doplot=T,col=heat(20),
        maxv=apply(data,2,max),minv=apply(data,2,min),var.l=T,obs.l=T,
	lab.l=dimnames(data)[[2]],lab.r=dimnames(data)[[2]],
	lab.t=dimnames(data)[[1]],lab.b=dimnames(data)[[1]],
	spc=rep(1,4),marscale=3)
{# calculate (and optionally plot) sortings for dataimage (color histogram)
# data - matrix or data frame of observations (rows) and variables (columns)
# obs.sort - method of sorting observations.  One of:
#	"none" - leave in original ordering
#	"complete" - heirarchical clustering, where cluster distances are
#		measured as max of point distances
#       "single" - heirarchical clustering, where cluster distances are
#		measured as min of point distances
#       "average" - heirarchical clustering, where cluster distances are
#		measured as average of point distances
#       "farthest" - farthest insertion spanning tour
#       "nearest" - nearest insertion spanning tour
#	"prcomp" - sort on first principal component
#	"mds" - sort by 1-D multidimensional scaling
#       k (numeric) - sort on variable k
# var.sort - method of sorting variables, as obs.sort
# std - if T, standardize all variables before sorting
# obs.met - distance metric for observations.  One of:
#	"euclidean" - L2
#       "manhattan" - L1
#       "maximum" - L-Infinity
# var.met - distance metric for variables, as obs.met
# doplot - if T, plot data image.  If false, return list consisting of
#	obs.ord: vector of observation orderings
#       var.ord: vector of variable orderings
#	data: original data matrix
# maxv - vector of maximums for each variable
# minv - vector of minimums for each variable
#   maxv, minv may be passed to keep color scale the same between images
# var.l - if T, label variables in plot
# obs.l - if T, label observations in plot
# lab.l - character vector for variable labels (left side)
# lab.r - character vector for variable labels (right side)
# lab.t - character vector for observation labels (top)
# lab.b - character vector for observation labels (bottom)

no<-nrow(data)
nv<-ncol(data)

dat2<-data
if (std)
	{means<-apply(data,2,mean)
	sds<-sqrt(apply(data,2,var))
	for (i in 1:nv)
		if (sds[i] > 0)
			{dat2[,i]<-(dat2[,i]-means[i])/sds[i]}
		else
			{dat2[,i]<-rep(0,no)}
	}

om<-charmatch(obs.met,c("euclidean","maximum","manhattan"),nomatch=-1)
if (om<1)
	{cat("obs.met not matched.  Using Euclidean distances.\n")
	obs.met<-"euclidean"}

if (is.numeric(obs.sort) & obs.sort>0 & obs.sort<=nv)
		{os<-9
		obs.sort<-ceiling(obs.sort)}
else
	{os<-charmatch(as.character(obs.sort),c("none","complete","single",
		"average","farthest","nearest","prcomp","mds"),nomatch=-1)
	if (os < 1)
		{cat("obs.sort not matched.  Using complete linkage clustering.\n")
		os<-2}
	}

if (os > 1 & os < 9) dm<-distmat(dat2,obs.met)

obs.ord<-switch(os,1:no,hco(dm,"c"),hco(dm,"s"),hco(dm,"a"),
	isto(dm,"f"),isto(dm,"n"),
	order(prcomp(dat2,center=F,scale=F)$x[,1]),
	order(cmdscale(dm,)[,1]),
	order(dat2[,obs.sort]))

vm<-charmatch(var.met,c("euclidean","maximum","manhattan"),nomatch=-1)
if (vm<1)
	{cat("var.met not matched.  Using Euclidean distances.\n")
	var.met<-"euclidean"}

if (is.numeric(var.sort) & var.sort>0 & var.sort<=no)
		{vs<-9
		var.sort<-ceiling(var.sort)}
else
	{vs<-charmatch(var.sort,c("none","complete","single","average",
		"farthest","nearest","prcomp","mds"),nomatch=-1)
	if (vs < 1)
		{cat("var.sort not matched.  Using complete linkage clustering.\n")
		vs<-2}
	}

if (vs > 1 & vs < 9) dm<-distmat(t(dat2),var.met)

var.ord<-switch(vs,1:nv,hco(dm,"c"),hco(dm,"s"),hco(dm,"a"),
	isto(dm,"f"),isto(dm,"n"),
	order(prcomp(t(dat2),center=F,scale=F)$x[,1]),
	order(cmdscale(dm,)[,1]),
	order(dat2[var.sort,]))

if (doplot)
	{diplot(list(obs.ord=obs.ord,var.ord=var.ord,data=data),
		maxv,minv,col,var.l,obs.l,lab.l,lab.r,lab.t,lab.b,
		spc,marscale)
	return()}
else
	return(obs.ord=obs.ord,var.ord=var.ord,data=data)
}

#######################################################################

diplot<-function(dimage,maxv=apply(dimage$data,2,max),
	minv=apply(dimage$data,2,min),col=red.cyan(20),
	var.l=T,obs.l=T,lab.l=NULL,lab.r=NULL,lab.t=NULL,
	lab.b=NULL,spc=rep(1,4),marscale=3)
{# plot dataimage (color histogram)
# dimage - output from dataimage function
# maxv - vector of maximums for each variable
# minv - vector of minimums for each variable
#   maxv, minv may be passed to keep color scale the same between images
# var.l - if T, label variables in plot
# obs.l - if T, label observations in plot
# lab.l - character vector for variable labels (left side)
# lab.r - character vector for variable labels (right side)
# lab.t - character vector for observation labels (top)
# lab.b - character vector for observation labels (bottom)
# spc - vector of space to leave on each side of labels on (bottom, left, top,
#     right)
# marscale - scale reducing factor for margins (larger -> smaller margins)

arrangex<-dimage$obs.ord
arrangev<-dimage$var.ord
data<-dimage$data

if (is.null(lab.t))
        lab.t<-dimnames(data)[[1]]
if (is.null(lab.b))
        lab.b<-dimnames(data)[[1]]
if (is.null(lab.l))
        lab.l<-dimnames(data)[[2]]
if (is.null(lab.r))
        lab.r<-dimnames(data)[[2]]

nx<-nrow(data)
nv<-ncol(data)

if (length(lab.t)< 1) lab.t<-1:nx
if (length(lab.b)< 1) lab.b<-1:nx
if (length(lab.l)< 1) lab.l<-1:nv
if (length(lab.r)< 1) lab.r<-1:nv

if (!var.l)
	{lab.l<-rep("",nv)
	lab.r<-rep("",nv)}
if (!obs.l)
	{lab.t<-rep("",nx)
	lab.b<-rep("",nx)}

if (spc[1]>0)
	{add<-NULL
	for (i in 1:spc[1]) add<-paste(add," ",sep="")
	lab.b<-paste(add,lab.b,add,sep="")
	}
if (spc[2]>0)
	{add<-NULL
	for (i in 1:spc[2]) add<-paste(add," ",sep="")
	lab.l<-paste(add,lab.l,add,sep="")
	}
if (spc[3]>0)
	{add<-NULL
	for (i in 1:spc[3]) add<-paste(add," ",sep="")
	lab.t<-paste(add,lab.t,add,sep="")
	}
if (spc[4]>0)
	{add<-NULL
	for (i in 1:spc[4]) add<-paste(add," ",sep="")
	lab.r<-paste(add,lab.r,add,sep="")
	}

lab.t<-as.character(lab.t)
ltf<-(nchar(lab.t))
ltn<-max(ltf)

#for (i in 1:length(lab.t))
#        lab.t[i]<-paste(substring(lab.t[i],1:nchar(lab.t[i]),1:nchar(lab.t[i])),collapse="\n")

lab.b<-as.character(lab.b)
lbf<-(nchar(lab.b))
lbn<-max(lbf)

#for (i in 1:length(lab.b))
#        lab.b[i]<-paste(substring(lab.b[i],1:nchar(lab.b[i]),1:nchar(lab.b[i])),collapse="\n")

lab.l<-as.character(lab.l)
lln<-max(nchar(lab.l))
lab.r<-as.character(lab.r)
lrn<-max(nchar(lab.r))

for (i in 1:nv) 
	if (maxv[i]!=minv[i])
		{data[,i]<-(data[,i]-minv[i])/(maxv[i]-minv[i])}
	else
                {only<-(data[,i]==maxv[i])
		data[,i]<-rep(2,nx)
                data[only,i]<-0.5}

par(mar=c(lbn/marscale,lln/marscale,ltn/marscale,lrn/marscale),xaxs="i",yaxs="i",las=2)

image(x=0:nx,y=0:nv,z=data[arrangex,arrangev],bty="n",axes=F,zlim=c(0,1),col=col,xlab="",ylab="")
#image(x=0:nx,y=0:nv,z=data[arrangex,arrangev],lab=c(0,0,0),bty="n",axes=F,zlim=c(0,1),col=col,xlab="",ylab="")
mtext(lab.l[arrangev],2,at=1:nv-.5,adj=1)
mtext(lab.r[arrangev],4,at=1:nv-.5,adj=0)

#for (i in 1:nx)
#	mtext(lab.b[arrangex[i]],1,at=i-.5,line=lbf[arrangex[i]]-1,adj=0.5)

mtext(lab.b[arrangex],1,at=1:nx-.5,line=0,adj=1)

#mtext(lab.b[arrangex],1,at=1:nx-.5,line=lbn-1)
#for (i in 1:nx)
#        mtext(lab.t[arrangex[i]],3,at=i-.5,line=ltf[arrangex[i]]-1)
#mtext(lab.t[arrangex],3,at=1:nx-.5,adj=.5)
mtext(lab.t[arrangex],3,at=1:nx-.5,adj=0,line=0)
}

#######################################################################


distmat<-function(data,met="euclidean")
{# use function dist to compute nrow(data)*nrow(data) matrix of interpoint
# distances.
distvec<-dist(data,method=met)
n <- attr(distvec, "Size")
full <- matrix(0, n, n)
full[lower.tri(full)] <- distvec
return(full + t(full))}

#######################################################################


hco<-function(dm,method="complete")
{#heirarchical clustering ordering for points with distance matrix dm
# method should be one of "complete", "single", or "average"
# see dataimage for differences

meth<-charmatch(method,c("single","average","complete"),nomatch=-1)
if (meth < 1) meth <- 3

maxdist<-2*max(dm)
pointdist<-dm
clustdist<-dm
n<-ncol(dm)
clustdist[cbind(1:n,1:n)]<-maxdist
height<-NULL

clust<-as.list(1:n)

for (i in 1:(n-1))
	{
	lt<-clustdist[lower.tri(clustdist)]

	mindist<-min(lt)

	newmerge<-cbind(row(clustdist)[clustdist==mindist],
		col(clustdist)[clustdist==mindist])[1,]

	height<-c(height,mindist)

	# merge clusters newmerge[1], newmerge[2]

	oldclust1<-clust[[newmerge[1]]]
	oldclust2<-clust[[newmerge[2]]]
	len1<-length(oldclust1)
	len2<-length(oldclust2)

	linkdist<-pointdist[c(oldclust1[1],oldclust1[len1]),
		c(oldclust2[1],oldclust2[len2])]
	minlink<-min(linkdist)
	if (linkdist[1,1]==minlink)
		newclust<-c(rev(oldclust1),oldclust2)
	else if (linkdist[2,1]==minlink)
		newclust<-c(oldclust1,oldclust2)
	else if (linkdist[1,2]==minlink)
		newclust<-c(rev(oldclust1),rev(oldclust2))
	else
		newclust<-c(oldclust1,rev(oldclust2))

	clust<-c(clust[-newmerge],list(newclust))

	if(i<(n-2))
		{oldclustdist<-clustdist[-newmerge,-newmerge]
		if (meth==1)
		    newclustdist<-apply(clustdist[-newmerge,newmerge],1,min)
		else if (meth==3)
		    newclustdist<-apply(clustdist[-newmerge,newmerge],1,max)
		else
		    {newclustdist<-rep(0,n-i-1) 
		    for (j in 1:(n-i-1))
		       newclustdist[j]<-mean(pointdist[newclust,clust[[j]]])}
		clustdist<-rbind(cbind(oldclustdist,newclustdist),
			cbind(t(newclustdist),maxdist))}
	else if(i==(n-2))
		{if (meth==1)
			newclustdist<-min(clustdist[-newmerge,newmerge])
		else if (meth==3)
			newclustdist<-max(clustdist[-newmerge,newmerge])
		else
			newclustdist<-mean(pointdist[newclust,-newclust])
		clustdist<-matrix(c(maxdist,rep(newclustdist,2),maxdist),2,2)}

	}

return(clust[[1]])}

#######################################################################

isto<-function(dm,method="farthest")

{# spanning tour orderings for points with distance matrix dm
# based on furthest or nearest insertion method
# method should be one of "farthest" or "nearest"
# see dataimage for differences

meth<-charmatch(method,c("farthest", "nearest"),nomatch=-1)
if (meth < 1) meth <- 1

n<-nrow(dm)
dist0<-sqrt(apply(dm^2,1,sum))
arrange<-min((1:n)[dist0==max(dist0)])
for (i in 1:(n-1))
	{if (meth==2)
	new<-min((1:n)[-arrange][apply(matrix(dm[arrange,-arrange],nrow=i),
		2,min)==min(apply(matrix(dm[arrange,-arrange],nrow=i),2,min))])
	else
	new<-min((1:n)[-arrange][apply(matrix(dm[arrange,-arrange],nrow=i),
		2,min)==max(apply(matrix(dm[arrange,-arrange],nrow=i),2,min))])
	if (i > 1)
		{distadd<-dm[new,arrange]+dm[new,arrange[c(i,1:(i-1))]]-
			dm[cbind(arrange,arrange[c(i,1:i-1)])]
		place<-min((1:i)[distadd==min(distadd)])
		if (place==1)
			arrange<-c(new,arrange)
		else 
			arrange<-c(arrange[1:(place-1)],new,arrange[place:i])
		}
	else
		arrange<-c(arrange,new)
	}
dist<-dm[cbind(arrange,arrange[c(n,1:(n-1))])]
big<-(1:n)[dist==max(dist)]
if (big > 1)
	arrange<-arrange[c(big:n,1:(big-1))]
return(arrange)
}

#######################################################################

red.cyan<-function(n)

{return(rgb(seq(1,0,length=n),seq(0,1,length=n),seq(0,1,length=n)))}

#######################################################################

heat<-function(n)

{m<-round((n-4)/4)
return(rgb(c(seq(0,1,length=(m+2)),rep(1,n-(m+2))),
	c(rep(0,m+1),seq(0,1,length=(n-2*m-2)),rep(1,m+1)),
	c(rep(0,n-(m+2)),seq(0,1,length=(m+2)))))}




