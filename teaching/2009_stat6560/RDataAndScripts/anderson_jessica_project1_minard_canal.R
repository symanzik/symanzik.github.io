##########################################################################
### This code was written to recreate Minard's graph "Canal du Centre" ###
###                                                                    ###
###                  By Jessica Anderson on 2/16/2009                  ###
##########################################################################

width = c(8,10,3,3,2,2,4,3,2,2,5,6,7,5,8,1,6,9,3,4,5,1,3,14,6,8,3,5)
h1 = c(6,1,1,1,0,5,2.5,14,16,23)
h2 = c(6,1,1,1,0,4.5,2,14,17,23)
h3 = c(6,1,1,1,0,4.5,2,14,17,23)
h4 = c(6,1,1,1,0,4.5,2,14,17,23)
h5 = c(6,1,1,2,0,5,2.5,14,8,25)
h6 = c(6,1,1,2,0,5,2.5,14,1,25)
h7 = c(6,1,1,2,0,5,2.5,14,.5,24.5)
h8 = c(6,1,1,2,0,5,2,14,1,24)
h9 = c(6,1,1,2,0,5,2,12,1,24.5)
h10 = c(6,1,1,2,0,5,1.5,9,1,24.5)
h11 = c(6,1,1,1.5,3,5,1,3.5,1,27)
h12 = c(6,1,1,1.5,3,4,1,3,1,27)
h13 = c(6,1,1,1.5,3.5,4,1.5,3.5,1,27)
h14 = c(6,1,1,1.5,3,4,1,2,1.5,25.5)
h15 = c(6,1,1,2,9.5,3.5,1,3,1,24)
h16 = c(6,1,1,2,9.5,3.5,1,3,1,22.5)
h17 = c(6,1,1,2,9.5,2.5,.5,3,1,19.5)
h18 = c(6,1,1,2,9.5,2.5,.5,3,1,17)
h19 = c(6,1,0,2,9.5,2.5,.5,3,1,16.5)
h20 = c(6,1,0,2,9.5,2.5,.5,3,1,16.5)
h21 = c(6,1,0,2,9.5,2,.5,3,1.5,16)
h22 = c(6,.5,0,2,9.5,1,.5,3,12,7)
h23 = c(6,.5,0,2,9.5,1,.5,3,11,11)
h24 = c(6,.5,0,2,9.5,1,.5,3,12,11)
h25 = c(6,.5,0,2,9.5,1,.5,2.5,11.5,10.5)
h26 = c(6,.5,0,2,9.5,.5,.5,3,9.5,10)
h27 = c(6,0,0,2,0,0,0,0,1,6)
h28 = c(6,0,0,2.5,0,0,0,0,.5,6)

height = matrix(cbind(h1,h2,h3,h4,h5,h6,h7,h8,h9,h10,h11,h12,h13,h14,
h15,h16,h17,h18,h19,h20,h21,h22,h23,h24,h25,h26,h27,h28),10,28)

colors = c("tan","red","pink","lightblue","wheat","yellow","darkblue",
"lightgreen","grey66","lightgrey")

names = c("Fragnes","Fontaines","Champforgeuil","Chagny","Remigny","Santenay",
"Cheilly","St. Gilles","Dennevy","St. Leger","St. Berain","Fangey","Bondilly",
"Montchanin","Marigny","Blanzy","Montceau","LeForge","Ciry","Valteuse",
"Genelard","Montet","Palinges","Passange","Paray","Canal Latiral","Pouilly","Digoin")

goods = c("Different Merchandise for Transit","Unknown","Bricks",
"Cast Iron and Iron","Unknown","Wood","Seed and Clay","Plaster","Roughstone","Coal")

add = 0
i = 0
nwidth = 0
for(i in 1:28)
{
nwidth[i] = add+width[i]
add = nwidth[i]
}

par(las=3,mar=c(6.5,4.1,4.1,2.1))
barplot(width=width,height=height,beside=FALSE,col=colors,space=0,axes=FALSE,names.arg=names,cex.names=.75)
legend(x=87,y=70,legend=goods,fill=colors,cex=.73,bty="n")
title("Figurative Table of Commercial Movement on the Canal du Centre in 1844")
par(las=0)
mtext("Drawn up by Mr. Minard from the information of Mr. Comoy")