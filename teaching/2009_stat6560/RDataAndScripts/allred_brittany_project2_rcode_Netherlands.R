########################## Data Found at:
# http://vlado.fmf.uni-lj.si/pub/networks/data/UciNet/UciData.htm#kazalo
# STOKMAN-ZIEGLER CORPORATE INTERLOCKS
#"BACKGROUND These data come from a six-year research project, concluded in 1976,
#on corporate power in nine European countries and the United States. Each matrix
#represents corporate interlocks among the major business entities of two 
#countries - the Netherlands (SZCID) and West Germany (SZCIG)."

#REFERENCES
#    * Ziegler R., Bender R. and Biehler H. (1985). Industry and banking in the German corporate network. In F. Stokman, R. Ziegler & J. Scott (eds), Networks of corporate power. Cambridge: Polity Press, 1985.
#    * Stokman F., Wasseur F. and Elsas D. (1985). The Dutch network: Types of interlocks and network structure. In F. Stokman, R. Ziegler & J. Scott (eds), Networks of corporate power. Cambridge: Polity Press, 1985. 


data_url<-"http://www.math.usu.edu/~symanzik/teaching/2009_stat6560/RDataAndScripts/allred_brittany_project2_Netherlands.txt"
Netherlands<-read.table(url(data_url), header=TRUE)

library(diagram)

plotweb(Netherlands,lab.size=1, main="Corporate Interlocks", sub="Business connections in the Netherlands")