
#########################################################################
###                                                                   ###
###                                                                   ###
###                                                                   ###
###                                                                   ###
###                       Author: Ying Jin                            ###
###   Rotating images of figures derived from Rensink's movies        ###
### from http://www.psych.ubc.ca/~rensink/flicker/download/index.html ###
###                           Date: 2/20/2009                         ###
###                                                                   ###
###                                                                   ###
#########################################################################


#
# pnm images currently cannot be loaded directly from a Web page
#
# download the files
#     http://www.math.usu.edu/~symanzik/teaching/2009_stat6560/RDataAndScripts/
#       jin_ying_project1_fig6.pnm
#     http://www.math.usu.edu/~symanzik/teaching/2009_stat6560/RDataAndScripts/
#       jin_ying_project1_fig6_2.pnm
# manually into your R working directory
#
# then read these files from this working directory
#


library(pixmap)

x1 <- read.pnm("jin_ying_project1_fig6.pnm")
x2 <- read.pnm("jin_ying_project1_fig6_2.pnm")

for (i in 1:10)
{
plot(x1)
Sys.sleep(0.4)

plot(c(0,1), c(0,1), type = "n", 
xlab = "", ylab = "", 
axes = FALSE)
Sys.sleep(0.2)

plot(x2)
Sys.sleep(0.4)

plot(c(0,1), c(0,1), type = "n", 
xlab = "", ylab = "", 
axes = FALSE)
Sys.sleep(0.2)
}

