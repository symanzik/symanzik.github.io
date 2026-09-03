library(rggobi)

#################################################
#  Read in Data                                 #
#################################################

data_url<-"http://www.math.usu.edu/~symanzik/teaching/2009_stat6560/RDataAndScripts/xia_rong_project1_laser.txt"

laser = read.table(url(data_url))

colnames = c("Current 1","Current 2","Energy","Wave Length")

names(laser)=colnames

#################################################
#    Activiate GGobi                            #
#################################################

las <- ggobi(laser)

####################################################
# Draw the Scatterplot between Current 1 and Energy#
####################################################

ce = display(las[1], vars=list(X="Current 1", Y="Energy"))

#################################################
#     Interactive  with Brushing                #
#################################################

imode(ce) <- "Brush"

####################################################
# Draw the Scatterplot between Current 2 and Energy#
####################################################

display(las[1], vars=list(X="Current 2", Y="Energy"))

########################################################
# Draw the Scatterplot between Current 1 and Wavelength#
########################################################

cw = display(las[1], vars=list(X="Current 1", Y="Wave Length"))

imode(cw) <- "Brush"

########################################################
# Draw the Scatterplot between Current 2 and Wavelength#
########################################################

display(las[1], vars=list(X="Current 2", Y="Wave Length"))

