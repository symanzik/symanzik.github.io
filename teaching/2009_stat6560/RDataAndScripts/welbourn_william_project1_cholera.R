#setwd("f:/USUS2009/STAT6560/Project1")


################## time - series plot  ###################

augmat<-as.data.frame(matrix(1,31-18,3))
names(augmat)<-c("Day","Fatal Incident Cases","Deaths")

augmat[,1]<-c(1,2,3,4,5,6,7,8,9,10,11,12,13)
augmat[,2]<-c(1,1,1,0,1,1,0,1,1,1,1,8,56)
augmat[,3]<-c(1,0,2,0,0,2,0,0,1,0,1,2,3)
septmat<-as.data.frame(matrix(c(1:30),30,3))
names(septmat)<-c("Day","Fatal Incident Cases","Deaths")

septmat[,2]<-c(143,116,54,46,36,20,28,12,11,5,5,1,3,0,1,4,2,3,0,0,2,1,1,1,1,1,1,0,0,0)
septmat[,3]<-c(70,127,76,71,45,37,32,30,24,18,15,6,13,6,8,6,5,2,3,0,0,2,3,0,0,2,0,2,1,0)	

plot(c(augmat[,1]-1,septmat[,1]+12),c(augmat[,2],septmat[,2]),type="l",axes=F,col="red",xlab="",
main="Temporal Distribution of Cholera Incidence/Death",ylab="Incident Cases of Cholera / Deaths from Cholera")
box()
lines(c(augmat[,1]-1,septmat[,1]+12),c(augmat[,3],septmat[,3]),type="l",col="black")
points(c(augmat[,1]-1,septmat[,1]+12),c(augmat[,2],septmat[,2]),pch=22,col="red",cex=0.8)
points(c(augmat[,1]-1,septmat[,1]+12),c(augmat[,3],septmat[,3]),pch=24,col="black",cex=0.8)
axis(side=1,at=augmat[-13,1],labels=augmat[-13,1]+19)
axis(side=1,at=augmat[1,1]-1,labels=F)
#axis(side=1,at=septmat[,1]+12,labels=seq(1,30,by=2,))
axis(side=1,at=septmat[,1]+12,labels=F,tick=T)
axis(side=1,at=seq(13,12+30,by=2,),labels=seq(1,30,by=2,))
mtext(text="August",side=1,at=5,line=3)
mtext(text="September",side=1,at=28,line=3)
axis(side=2,at=seq(0,140,by=20,))
lines(c(8+12,8+12),y=c(0,30),col="blue",lty=2)
legend(x=30,y=140,legend=c("Incident cases of cholera","Deaths from cholera","Broad Street Pump Handle Removed"),
pch=c(22,24,NA),col=c("red","black","blue"),lty=c(1,1,2))


########################   FIGURE 3  #################


par(mar=c(5, 4, 2, 1) + 0.1)
library(splancs)
text1<-"http://www.math.usu.edu/~symanzik/teaching/2009_stat6560/RDataAndScripts/welbourn_william_project1_deaths_cholera.txt"
text2<-"http://www.math.usu.edu/~symanzik/teaching/2009_stat6560/RDataAndScripts/welbourn_william_project1_pumps_cholera.txt"

r<-read.table(url(text1))
x1<-range(r[,1])
y1<-range(r[,2])
pumps<-read.table(url(text2))
bsp<-pumps[7,]
x2<-range(pumps[,1])
y2<-range(pumps[,2])
minx<-min(x1[1],x2[1])
maxx<-max(x1[2],x2[2])
miny<-min(y1[1],y2[1])
maxy<-max(y1[2],y2[2])
#plot(r[-7,1],r[-7,2],xlim=c(minx,maxx),ylim=c(miny,maxy),type="p",pch=19,col="red")
deaths<-read.table(url(text1))
#points(r[,1],r[,2],pch=19)
dist<-matrix(0,dim(deaths)[1],dim(pumps)[1]+1)

for(i in 1:dim(dist)[1]){
for(j in 1:dim(dist)[2]){
dist[i,j]<-sqrt((deaths[i,1]-pumps[j,1])**2+(deaths[i,2]-pumps[j,2])**2)
}}
for(i in 1:dim(dist)[1]){
if(dist[i,7]==min(dist[i,1:dim(pumps)[1]])) dist[i,dim(dist)[2]]<-1
else dist[i,dim(dist)[2]]<-0
}


######  DISTANCE GRID
#meshgrid<-function(a,b){
#list(xgrid=outer(b*0,a,FUN="+"),
#ygrid=outer(b,a*0,FUN="+"))}
#xg<-seq(minx,maxx,,1000)
#nxg<-length(xg)
#yg<-seq(miny,maxy,,1000)
#nyg<-length(yg)
#GRD<-meshgrid(xg,yg)
#plot(GRD$xgrid,GRD$ygrid,pch="+")
#Xgrid.vec<-as.vector(GRD$xgrid)
#Ygrid.vec<-as.vector(GRD$ygrid)
#Xp<-cbind(matrix(1,length(Xgrid.vec),1),Xgrid.vec,Ygrid.vec)

#Xp[,1]<-sqrt((Xp[,2]-bsp[1,1])**2+(Xp[,3]-bsp[1,2])**2)

#Zpmat<-t(matrix(Xp[,1],nyg,nxg))
u<-r[dist[,dim(dist)[2]]==1,1]
v<-r[dist[,dim(dist)[2]]==1,2]
h<-chull(u,v)
h<-c(h,h[1])
plot(u[h],v[h],type="l",ylim=c(miny-0.5,maxy+0.5),xlim=c(minx-0.5,maxx+0.5),axes=F,ylab="",xlab="",
main="Relative Locations of Cholera Deaths from Pumps")
points(u,v,pch=19,cex=0.8,col="black")


u<-r[dist[,dim(dist)[2]]==0,1]
v<-r[dist[,dim(dist)[2]]==0,2]
points(u,v,type="p",col="red",cex=0.8,pch=19)
points(pumps[-7,1],pumps[-7,2],pch=8,cex=2)
points(bsp[,1],bsp[,2],pch=3,cex=2,col="red")

legend(x=22,y=19,c("Broad Street Pump","Other Pumps","Death Nearer Broad Street Pump","Death Nearer Other Pump"),
pch=c(3,8,19,19),
pt.cex=c(1,1,0.8,0.8),cex=0.8,col=c("red","black","black","red"),xjust=1,yjust=1)
box()

axis(side=1,at=seq(min(min(x1),min(x2)),max(max(x1),max(x2)),by=2,),labels=seq(0,10,by=2,))
mtext(text="Distance (scaled meters)",side=1,line=3)
axis(side=2,at=seq(min(min(y1),min(y2)),max(max(y1),max(y2)),by=2,),labels=seq(0,12,by=2,))
mtext(text="Distance (scaled meters)",side=2,line=3)
