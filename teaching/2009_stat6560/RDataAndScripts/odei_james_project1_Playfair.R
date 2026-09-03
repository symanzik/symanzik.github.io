

##################################################################################################################
###                                                                                                            ###
### The following code is written to recreate William Playfair's 1786 Bar Chart for Exports and Imports of     ### 
### SCOTLAND to and from different parts for one year from Christmas 1780 to Christmas 1781.                   ###                           
###                                                                                                            ###
###                                       Author: JAMES B. ODEI 	                                           ###			
###                                                                                                            ###
###                                        Date: Feb. 03, 2009                                                 ###  
###                                                                                                            ###
##################################################################################################################


data_url<-"http://www.math.usu.edu/~symanzik/teaching/2009_stat6560/RDataAndScripts/odei_james_project1_Playfair.csv"
playfair<-read.table(url(data_url), header=TRUE, sep=",")
pf = data.frame(rbind(playfair[,2],playfair[,3]))



#data<-read.csv("odei_james_project1_Playfair.csv", header=TRUE, sep=",")
#colnames = data[,1]
#pf = data.frame(rbind(data[,2],data[,3]))
#names(pf) = colnames
#col.names = c("Import", "Export")



xvalues = seq(-4, 376, by=10)
yvalues = seq(-2, 78.8, by=5)


barplot(as.matrix(pf), space=c(0.4,1), density=c(250,62), horiz=TRUE, beside=TRUE, xlim = range(xvalues), 
		ylim=range(yvalues), axes=FALSE, axisnames=FALSE, col=1 )

axis(side=3, line=-5, at=c(10,20,30,40,50,60,70,80,90,100,110,130,150,170,200,220,240,260,280,301), 
     labels=c("10","20","30","40","50","60","70","80","90","100","110","130","150","170","200","220",
	 "240","260","280", "L 300 000"), cex.axis=0.8, font=4, lwd=1.5, col="white")




# box()
#abline(v=seq(10,300,10), col="lightgray")
#lines(c(10,10), c(70.7, 75.4), col="white")
#abline(v=seq(100,300,100), col="black", lwd=2)



abline(h =0.4)
abline(h =4)
abline(h =7.3)
abline(h =10.7)
abline(h =14.1)
abline(h =17.5)
abline(h =20.9)
abline(h =24.3)
abline(h =27.7)
abline(h =31.15)
abline(h =34.5)
abline(h =37.9)
abline(h =41.3)
abline(h =44.7)
abline(h =48.1)
abline(h =51.5)
abline(h =54.9)
abline(h =58.3)
abline(h =61.9)
abline(h =66)
abline(h =70.7)
abline(h =75.5)


rect(xleft=-3.9, ybottom=-0.8, xright=0.4, ytop=76.8, border=NA, col = "white")
rect(xleft=368.5, ybottom=-0.8, xright=377, ytop=76.8, border=NA, col = "white")


segments(0.25, 0.4, 0.25, 75.5)

for (i in 1:30){
segments(10*i, 0.4, 10*i, 70.7)
}

segments(100, 0.4, 100, 75.5, lwd=2)
segments(200, 0.4, 200, 75.5, lwd=2)
segments(300, 0.4, 300, 75.5, lwd=2)

segments(368.5, 0.4, 368.5, 75.5)

segments(-2.8, -0.8, -2.5, 76.5, lwd=6)
segments(371,-0.8, 371, 76.5, lwd=6)

segments(-2.6, -0.8, 371, -0.8, lwd=6)
segments(-2.6, 76.8, 371, 76.8, lwd=6)



text(x=1.5, y=55.8, "0", cex=0.8, font=4)
text(x=1.5, y=52.4, "0", cex=0.8, font=4)
text(x=1.5, y=42.3, "0", cex=0.8, font=4)
text(x=1.5, y=32.0, "0", cex=0.8, font=4)


text(x=335, y=63.8, "Names of Places", cex=1, font=4)
text(x=335, y=56.4, "Jersey &c.", cex=1, font=4)
text(x=334, y=53.34, "Iceland", cex=1, font=4)
text(x=334, y=49.52, "Poland", cex=1, font=4)
text(x=335, y=46.5, "Isle of Man", cex=1, font=4)
text(x=335, y=43.0, "Greenland", cex=1, font=4)
text(x=335, y=39.5, "Prussia", cex=1, font=4)
text(x=335, y=36.0, "Portugal", cex=1, font=4)
text(x=335, y=32.8, "Holland", cex=1, font=4)
text(x=335, y=29.5, "Sweden", cex=1, font=4)
text(x=335, y=25.8, "Guernsey", cex=1, font=4)
text(x=334.6, y=22.5, "Germany", cex=1, font=4)
text(x=335, y=19.0, "Denmark and Norway", cex=1, font=4)
text(x=335, y=15.7, "Flanders", cex=1, font=4)
text(x=335, y=12.4, "West Indies", cex=1, font=4)
text(x=335, y=9.0, "America", cex=1, font=4)
text(x=335, y=5.5, "Russia", cex=1, font=4)
text(x=335, y=2.25, "Ireland", cex=1, font=4)



#title(main = "Exports and Imports of SCOTLAND to and from different parts for one Year from Christmas 1780 to Christmas 1781",font.main=2)

mtext("Exports and Imports of SCOTLAND to and from different parts for one Year from Christmas 1780 to Christmas 1781",
       side=3, at=185, line=-1.25, cex=1.5, font=3)

mtext("The Upright divisions are Ten Thousand Pounds each.", side=1, at=85, line=-0.4, cex=1.2, font=3) 

mtext("The Black Lines are Exports, the Ribbed lines, Imports.", side=1, at=280, line=-0.4, cex=1.2, font=3) 

mtext(side=1, at=48, line=0.8, cex=0.7, font=3, expression(paste("Published as the Act directs June ", 7^th, " 1786 by ", W^m, " Playfair", sep="")))

mtext(side=1, at=310, line=0.8, cex=0.7, font=3, expression(paste("Neele ", sculp^t, " 352 Strand London", sep="")))


