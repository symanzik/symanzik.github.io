library(rggobi)

#################################################
#    Read in the data                           #
#################################################

data_url<-"http://www.math.usu.edu/~symanzik/teaching/2009_stat6560/RDataAndScripts/xia_rong_project1_flea.csv"

flea = read.csv(url(data_url))

#################################################
#    Activiate GGobi                            #
#################################################
fl <- ggobi(flea)

#################################################
#    Draw the Scatterplot Matrix                #
#################################################

display(fl[1], "Scatterplot Matrix",list(X=c(2,3,4,5,6,7)))

#################################################
#     Brushing                                  #
#################################################

glyph_color(fl[1]) = c(8,5,7)[flea$species]
