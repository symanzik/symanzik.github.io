library(diagram)
library(graph)
library(RColorBrewer)
############## diagram --Demos, demonsterating the various features of the packages
demo("flowchart") 	# creating flow charts

demo("plotmat")   	# plotting diagrams inputted as a SQUARE matrix
	example(plotmat) 	# Flow chart oriented

demo("plotweb")   	# plotting webs inputted as a SQUARE matrix

### Family Tree Social Network Example
par(mar=c(1,1,1,1))
openplotmat()

##  Where each node of the chart will be placed
text(coordinates(pos=c(1,1,2,4,8)),lab=letters[1:16],cex=1.2, main="Shell of flowchart")
openplotmat() #give a new screen
# How many blocks and how many on each level in the chart - creates a matrix
elpos<-coordinates (c(1,1,2,4,8)) 
fromto <- matrix(ncol=2,byrow=TRUE,data=c(2,3,2,4,3,5,3,6,4,7,4,8,5,9,5,10,6,11,6,12,7,13,7,14,8,15,8,16))
nr     <-nrow(fromto)
# creates the direction of the arrows
arrpos <- matrix(ncol=2,nrow=nr)
for (i in 1:nr) 
    arrpos[i,]<- straightarrow (to=elpos[fromto[i,2],],from=elpos[fromto[i,1],]
        ,lwd=2,arr.pos=0.6,arr.length=0.5)
#label the boxes, indicate length and width of the boxes
textempty  (elpos[1,],0.45,0.05,lab="Family Tree Social Network",cex=1.8)
textellipse(elpos[2,],0.1,0.05,lab="Brittany", box.col="purple",cex=1.5)
textmulti   (elpos[3,],0.15,0.05,lab="Karl (dad)",box.col="blue",shadow.col="darkblue",shadow.size=0.005,cex=1.2)
textmulti   (elpos[4,],0.15,0.05,lab="Jill (mom)",box.col="blue",shadow.col="darkblue",shadow.size=0.005,cex=1.2)
textrect   (elpos[5,],0.1,0.05,lab="Dan",box.col="red",cex=1)
textrect  (elpos[6,],0.1,0.05,lab="Deanna",box.col="red",cex=1)
textrect  (elpos[7,],0.1,0.05,lab="Carl",box.col="purple",cex=1)
textrect  (elpos[8,],0.1,0.05,lab="Barb",box.col="purple",cex=1)
textdiamond(elpos[9,],0.09,0.05,lab="Clay",box.col="yellow",cex=.8)
textdiamond(elpos[10,],0.09,0.05,lab="Millie",box.col="yellow",cex=.8)
textdiamond(elpos[11,],0.09,0.05,lab="Golden",box.col="light blue",cex=.8)
textdiamond(elpos[12,],0.09,0.05,lab="Erma",box.col="light blue",cex=.8)
textdiamond(elpos[13,],0.09,0.05,lab="Carl",box.col="pink",cex=.8)
textdiamond(elpos[14,],0.09,0.05,lab="Ila",box.col="pink",cex=.8)
textdiamond(elpos[15,],0.09,0.05,lab="Owen",box.col="green",cex=.8)
textdiamond(elpos[16,],0.09,0.05,lab="Blanch",box.col="green",cex=.8)


