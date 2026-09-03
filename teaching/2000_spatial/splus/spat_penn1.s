# File:         penn1.s
# Programmer:   Dan Carr
# Date:         Revised June 6, 1999
# Purpose       Pennsylvania LM dot plot for benzene

# The data: penn.ben
# and boundary files: penn.bnd
# are in a dump file

data.restore('/home/symanzik/splus/penn1_panel.dmp')
data.restore('/home/symanzik/splus/penn1.dmp')

#data.restore('penn1_panel.dmp')
#data.restore('penn1.dmp')


# History of data file creation
# benzene data
#penn.ben <- read.table(file='penn_benzene.txt',sep=',')
#names(penn.ben) <- c('Tracts', 'Mean', 'Median', 'Min', 'P25', 'P75', 'Max')

vals <- penn.ben$Median
tnams <- row.names(penn.ben)
nams <- penn.bnd$countyid[tnams]


#sorting
ord <- order(vals)
ord <- rev(ord)
vals <- vals[ord]
nams <- nams[ord]
tnams <- tnams[ord]

# scaling
rx <- range(vals)
rx <- mean(rx) + .57*diff(rx)*c(-1,1)
ry <- c(0,1)
a <- .25
grid.x <- inbounds(rx)


id <- penn.bnd$id
bnd.rx <- penn.bnd$rx
bnd.rx <- mean(bnd.rx)+ 1.04*diff(bnd.rx)*c(-.5,.5)

bnd.ry <- penn.bnd$ry
bnd.ry <- mean(bnd.ry)+ 1.04*diff(bnd.ry)*c(-.5,.5)


micolors <- matrix(c(
  .00, .00, .00,
 1.00,1.00,1.00,
  .78, .78, .78,
 1.00, .1, .1 ,
 1.00, .50, .00,
  .10,1.00, .00,
  .10, .50,1.00,
  .70, .40,1.00,
  .20, .20, .20,
 1.00,1.00, .80,
  .78, .78, .78,
  .50, .50, .50,
  .80, .50,1.00),ncol=3,byrow=T)
ps.options(black.and.white="false",rasters=600)
#postscript(file='penn1.ps',colors=micolors,hori=F,width=8.5,height=10)

motif("hpage")
par(xpd=T)



if(names(dev.cur())=='postscript'){
   pch<- 183
   outline <- T
} else {
   pch<- 16
   outline <- F
}

panels <- panel.layout(nrow=8,ncol=6,
                        col.size=c(1.5,1.0,1.3,1.5,1.0,1.3),
                        col.sep=c(0,0,0,.15,0,0,0),
                        row.sep=c(0,0,0,0,.15,0,0,0,0),bottom.mar=.2,
                        left.mar=0,top.mar=.7,borders=c(.25,.25,.25,.25))

pan.outline <- panel.layout(nrow=2,ncol=6,
                        col.size=c(1.5,1.0,1.3,1.5,1.0,1.3),
                        col.sep=c(0,0,0,.15,0,0,0),
                        row.sep=c(0,.15,0),bottom.mar=.2,
                        left.mar=0,top.mar=.7,borders=c(.25,.25,.25,.25))

pan.title <- panel.layout(nrow=1,ncol=1,bottom.mar=.2,
                        left.mar=0,top.mar=.7,borders=c(.25,.25,.25,.25))


ie <- cumsum(c(rep(c(4,4,4,5),3),c(4,4,4,4)))
npanel <- length(ie)
ib <- c(1,ie[-npanel]+1)

for (i in 1:length(ib)){
   subs <- seq(ib[i],ie[i])
   gnams <- nams[subs]
   txtnams <- tnams[subs]
   if(i <= 8){
     pan.r <- i
     pan.c1 <- 1
     pan.c2 <- 2
     pan.c3 <- 3
     if(i<=4)cont <- nams[ib[1]:ie[4]] else
             cont <- nams[ib[5]:ie[8]]
   } else {
     pan.r <- i-8
     pan.c1 <- 4
     pan.c2 <- 5
     pan.c3 <- 6
     if(i <= 12) cont <- nams[ib[9]:ie[12]] else
                 cont <- nams[ib[13]:ie[16]] 
   }
#plot maps
   panel.select(panels,pan.r,pan.c1)
   panel.scale(bnd.rx,bnd.ry)

#  background
   back <- is.na(match(penn.bnd$fid,cont))
   tx <- penn.bnd$x[back]
   ty <- penn.bnd$y[back]
   polygon(tx,ty,col=11,border=F)
   polygon(tx,ty,col=2,density=0,lwd=0)

#  midground
   tx <- penn.bnd$x[!back]
   ty <- penn.bnd$y[!back]
   polygon(tx,ty,col=10,border=F)
   polygon(tx,ty,col=1,density=0,lwd=0)

#  highlight
   good <- !is.na(match(penn.bnd$fid,gnams))
   tx <- penn.bnd$x[good]
   ty <- penn.bnd$y[good]
   pen <- match(penn.bnd$id,gnams,0)
   pen <- pen[pen>0]+3
   polygon(tx,ty,col=pen,border=F)
   polygon(tx,ty,col=1,density=0)

#  final outline
  polygon(penn.bnd$out.x,penn.bnd$out.y,density=0,lwd=0)
                
# _________________ plot id's____________________
   panel.select(panels,pan.r,pan.c2)
   panel.scale(c(0,1),ry)
   nums <- rev(seq(along=subs))
   n <- length(nums)
   y <- (nums-a)/(n+1-2*a)
   text(rep(.025,n),y,txtnams,adj=0,cex=.65)

# plot dots
   panel.select(panels,pan.r,pan.c3)
   panel.scale(rx,ry)
   panel.fill(col=3)
   panel.mygrid(x=grid.x,col=2)
   panel.outline(col=2)
   if(pan.r==8){
      axis(side=1,at=grid.x,labels=as.character(grid.x),cex=.7,mgp=c(2,.2,0))
      text(mean(rx),-.3," g/m ",adj=.5,cex=.7)
      points(mean(rx)-.12*diff(rx),-.34,pch=109,font=13,cex=.7)
      text(mean(rx)+.13*diff(rx),-.27,"3",adj=.5,cex=.5)
   }
   nums <- rev(seq(along=subs))
   n <- length(nums)+1
   y <- (nums-a)/(n-2*a)
   for (j in 1:length(nums)){
      points(vals[subs[j]],y[j],col=1,cex=1.9,pch=pch)
      points(vals[subs[j]],y[j],col=j+3,cex=1.6,pch=pch)
   }
} 
   panel.select(pan.outline,1,3)
   panel.scale(rx,ry)
   panel.outline()

   panel.select(pan.outline,2,3)
   panel.scale(rx,ry)
   panel.outline()
   panel.select(pan.outline,1,6)
   panel.scale(rx,ry)
   panel.outline()
   panel.select(pan.outline,2,6)
   panel.scale(rx,ry)
   panel.outline()

   panel.select(pan.title,margin='top')
   panel.scale()
   text(.5,.9,'Pennslyvania: Median of Modeled 1990 Census Tract Benzene Concentrations',adj=.5)
   text(.25,.3,'Above County Median',cex=.9)
   text(.75,.3,'Below County Median',cex=.9)

