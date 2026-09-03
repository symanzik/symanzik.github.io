source("http://bioconductor.org/biocLite.R")  ### INSTALL THE bioDist R PACKAGE FROM BIOCONDUCTOR WEB-SERVER
biocLite("bioDist")
source("http://bioconductor.org/biocLite.R")  ### INSTALL THE hopach R PACKAGE FROM BIOCONDUCTOR WEB-SERVER
biocLite("hopach")
install.packages(c("gplots","RColorBrewer"))

#library(affy)
library(RColorBrewer)
#library(affyPLM)
#library(geneplotter)
#library(hexbin)
#library(cluster)
library(bioDist)
library(hopach)
#setwd("c:/cels")
library(gplots)

data_url<-"http://www.math.usu.edu/~symanzik/teaching/2009_stat6560/RDataAndScripts/welbourn_william_project2_genetics.txt"
source("http://www.math.usu.edu/~symanzik/teaching/2009_stat6560/RDataAndScripts/welbourn_william_project2_bootplot.R")   ##### MODIFIED VERSION OF BOOTPLOT FUNCTION -- ADJUSTS COLORS


#####  CREATE THE AFFYBATCH OBJECT FOR THE GSE5245 DATA #####
#############################################################
#list.celfiles()  #### LIST THE .CEL FILES FOR THE ROOT DIRECTORY OF THE C DRIVE
#data.0 <- ReadAffy()  #### READ IN THE .CEL FILES
##############################################################


################### RMA PREPROCESSING ################
######################################################
#rma.dat<-rma(data.0)
#rma.expr<-exprs(rma.dat)
########################################################


################# QUALITY CONTROL IMAGES ###################
############################################################
#PLM.ar1<-rmaPLM(data.0)
#png(filename = "welbourn_william_project2_fig2.png", width = 800, height = 600,
#    units = "px", pointsize = 12, bg = "white",restoreConsole = TRUE)
#n<-3
#image(PLM.ar1,type="sign.resids",which=n,main="PLM signed residual plot for microrray three")
#dev.off()

#png(filename = "welbourn_william_project2_fig1.png", width = 800, height = 600,
#    units = "px", pointsize = 12, bg = "white",restoreConsole = TRUE)
#par(mfrow=c(3,2))
#MAplot(data.0,cex=0.75,which=c(1:6))  ### TAKES A FEW MINUTES TO GENERATE

#dev.off()
##############################################################


####################### GENE NAMES FOR 25 IMPORTANT GENES #########################
####################################################################################
#g1<-c("1449925_at","1434451_at","1426112_a_at","1416910_at","1426918_at")
#g2<-c("1450070_s_at","1425084_at","1427084_a_at","1449507_a_at","1434914_at")
#g3<-c("1429265_a_at","1457198_at","1418449_at","1454894_at","1457410_at")
#g4<-c("1418301_at","1427040_at","1453636_at","1416554_at","1435456_at")
#g5<-c("1460688_s_at","1430558_at","1427484_at","1450641_at","1426662_at")
#gene.names<-c(g1,g2,g3,g4,g5)

#gnnames<-featureNames(data.0)
#t.f.gn<-is.element(gnnames,gene.names)
#expr25<-rma.expr[t.f.gn,]
#write.table(expr25,"welbourn_william_project2_genetics.txt",sep="\t",row.names=T,col.names=T,quote=F)
##########################################################################################################

############## READ IN THE DATA FILE #################################################
#####################################################################
expr25<-as.matrix(read.table(url(data_url),sep="\t",header=T))

hmcol<-colorRampPalette(brewer.pal(10,"RdBu"))(256)         #### OBTAIN A COLOR PALETTE BASED ON COLORBREWER PACKAGE
colnames(expr25)
x1<-c("GSM118665.CEL","GSM118666.CEL","GSM118667.CEL","GSM118668.CEL","GSM118669.CEL")  ### ARRAYS CORRESP. TO CONTROL GROUP
x2<-c("GSM118671.CEL","GSM118673.CEL","GSM118674.CEL","GSM118677.CEL","GSM118679.CEL")  ### ARRAYS CORRESP. TO SHORT ANTIGEN EXPOSURE GROUP
x3<-c("GSM118681.CEL","GSM118682.CEL","GSM118684.CEL","GSM118686.CEL","GSM118687.CEL","GSM118689.CEL")  ### ARRAYS CORRESP. TO LONG ANTIGEN EXPOS. GROUP
for(i in 1:dim(expr25)[2]){
if(sum(colnames(expr25)[i]==x1)>0){colnames(expr25)[i]<-"none"
}else if(sum(colnames(expr25)[i]==x2)>0){colnames(expr25)[i]<-"short"
}else {colnames(expr25)[i]<-"long"
}}
x<-colnames(expr25)
csc<-rep(hmcol[50],ncol(expr25))        ### ASSIGN COLORS TO THE DIFFERENT GROUPS.  THIS WILL ALLOW IDENTIFICATION OF GROUPS WITHIN HEATMAPS
csc[x=="short"]<-hmcol[125]
csc[x=="long"]<-hmcol[200]

head(expr25)                            ### EXAMINE THE FIRST FEW ENTRIES OF THE DATA FRAME

par(cex.main=0.9)

############### ROW-SCALED HEATMAP ########################
heatmap.2(expr25,scale="row",col=hmcol,ColSideColors=csc,margin=c(5,8),
main="Heatmap of 25 Differentially Expressed Genes Across the 16 Arrays (ROW SCALED)",
keysize=1,ylab="Gene Label",xlab="Antigen Exposure (Array)")

############## COL-SCALED HEATMAP ##########################
heatmap.2(expr25,scale="column",col=hmcol,ColSideColors=csc,margin=c(5,8),
main="Heatmap of 25 Differentially Expressed Genes Across the 16 Arrays (ROW SCALED)",
keysize=1,ylab="Gene Label",xlab="Antigen Exposure (Array)")


################ PREPARE DATA FOR dplot FUNCTION #################
array.hop<-hopach(t(expr25),d='cor')

gene.hop<-hopach(expr25,d='cor')
array.hop$clust$k  ###  7 CLUSTERS
gene.hop$clust$k  ###  13 CLUSTERS

d.array.cor<-as.matrix(cor.dist(t(expr25)))
d.gene.cor<-as.matrix(cor.dist(expr25))

########### PEARSON DISTANCE BY ARRAY ###############
#####################################################

dplot(d.array.cor,array.hop,lab=colnames(expr25), showclust=T,
col=hmcol,main="Cluster Plot of Pearson Distance (Arrays)",xlab="Antigen Exposure")
x11()
par(cex.main=0.9)
heatmap.2(d.array.cor,col=hmcol,dendrogram="row",key=T,density.info="none",trace="none",
main="Heatmap of Pearson Distance (Arrays)",xlab="Antigen Exposure")

############## PEARSON DISTANCE BY GENES ######################
###################################################################

dplot(d.gene.cor,gene.hop,lab=colnames(t(expr25)), showclust=T,
col=hmcol,main="Cluster Plot of Pearson Distance (Genes)")
x11()
par(cex.main=0.9)
heatmap.2(d.gene.cor,col=hmcol,dendrogram="row",key=T,density.info="none",
main="Heatmap of Pearson Distance (Genes)",xlab="Gene Label",margins=c(7,6),trace="none")

###################  OBTAIN BOOTSTRAP CLUSTER MEMBERSHIP ################
boot1<-boothopach(t(expr25),B=5000,array.hop)
boot2<-boothopach(expr25,B=5000,gene.hop)

hmcolarray<-colorRampPalette(brewer.pal(10,"RdBu"))(array.hop$clust$k)
bootplotmod(boot1,array.hop,ord="bootp",showclusters=T,
main="Bootstrapping Array Clusters (B=10,000)",colr=hmcolarray)
x11()
par(mar=c(5,5,4,2)+0.1)
hmcolgene<-colorRampPalette(brewer.pal(10,"RdBu"))(gene.hop$clust$k)
bootplotmod(boot2,gene.hop,ord="bootp",showclusters=T,
main="Bootstrapping Gene Clusters (B=10,000)",colr=hmcolgene)


