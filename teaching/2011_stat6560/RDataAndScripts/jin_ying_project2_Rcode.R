#########################################################################
###                                                                   ###
### the following code are modified based on the R documentation for  ###
###                           animation package                       ###
###                                                                   ###
#########################################################################



#### install the package #####
library(animation)



######## example 1: buffon's needle ################

oopt = ani.options(nmax = 500, interval = 0)
opar = par(mar = c(3, 2.5, 0.5, 0.2), pch = 20, mgp = c(1.5, 0.5, 0))

par(mfrow=c(1,2))

buffon.needle(l = 0.8, d = 1, redraw = TRUE, mat = matrix(c(1, 3, 2, 3), 2),
heights = c(3, 2), col = c("lightgray", "red", "gray", "red", "blue",
"black", "red"), expand = 0.4)


######## example 2: estimating natual base e ################

mat = matrix(1,1)
widths = rep(1, ncol(mat))
heights = rep(1,nrow(mat))
nmax=100
obs=c(1:100)
{
layout(mat, widths, heights)
x=matrix(obs,nrow=nmax,ncol=1)
for (i in 1:nmax){
x[i,]=(1+1/obs[i])^obs[i]
e=x[,1]
plot(e[1:i], xlim = c(1, nmax), ylim = c(2.5,2.75), 
            xlab = "i", ylab = "e",col="red")
legend("bottomright", legend = paste("e:", format(round(e[i], 
            3), nsmall = 3)), bty = "n")
Sys.sleep(0.1)
}
}

######## error rate of random forest ################


data_url1 <- "http://www.math.usu.edu/~symanzik/teaching/2009_stat6560/RDataAndScripts/jin_ying_project2_swans.txt"
swans=read.table(data_url1,header=T)

library(MASS)
library(randomForest)
class1=select=(swans[,6]==0)
class2=select=(swans[,6]==1)
length(class1)
length(class2)
classes=swans[class1|class2,]
swans.class=swans[,6]

swannoclass=swans[,-6]
swans$spec=as.factor(swans$spec)
intrain=sample(1:nrow(swans),90,replace=F)
train=swans[intrain,]
test=swans[-intrain,]


mat = matrix(1,1)
widths = rep(1, ncol(mat))
heights = rep(1,nrow(mat))
n=50
ntree=c(1:50)
{
layout(mat, widths, heights)
x=matrix(ntree,nrow=n,ncol=1)
for (i in 1:n){
rf.fit=randomForest(spec~.,data=train,ntree=ntree[i])
rf.pred=predict(rf.fit,newdata=test,type="class")
x[i]=mean(rf.pred!=test$spec)
plot(x[1:i], xlim = c(1, n), ylim = c(0,0.2), 
            xlab = i, ylab = "error_rate",col="red")
legend("bottomright", legend = paste("error_rate:", format(round(x[i], 
            3), nsmall = 3)), bty = "n")
Sys.sleep(0.1)
}
}



##############swans data to apply for the k-means (given in the animation package) cluster analysis#######

swan=swans[,c(1,3)]
oopt = ani.options(interval = 2, nmax = 1000)
op = par(mar = c(3, 3, 1, 1.5), mgp = c(1.5, 0.5, 0))
kmeans.ani(swan,centers=2,pch=1:2,col=1:2)





