#########################################################################
###                                                                   ###
### The following data is written to recreate Charles Joseph Minard's ###
###        flow map of Napolean's Russian Campaign of 1812.           ###
###                                                                   ###
###                       Author: Hadley Wickham                      ###
###   Taken from http://www.math.yorku.ca/SCS/Gallery/re-minard.html  ###
###                           Date: 2/1/2009                          ###
###    Modified by Jessica Anderson to work with the presentation.    ###
###                                                                   ###
#########################################################################

data_url1 <- "http://www.math.usu.edu/~symanzik/teaching/2009_stat6560/RDataAndScripts/anderson_jessica_project1_minard_cities.txt"
data_url2 <- "http://www.math.usu.edu/~symanzik/teaching/2009_stat6560/RDataAndScripts/anderson_jessica_project1_minard_troops.txt"
data_url3 <- "http://www.math.usu.edu/~symanzik/teaching/2009_stat6560/RDataAndScripts/anderson_jessica_project1_minard_temps.txt"
cities <- read.table(url(data_url1), header=T)
troops <- read.table(url(data_url2), header=T)
temps <- read.table(url(data_url3), header=T)

#troops <- read.table("anderson_jessica_project1_minard_troops.txt", header=T)
#cities <- read.table("anderson_jessica_project1_minard_cities.txt", header=T)
#temps <- read.table("anderson_jessica_project1_minard_temps.txt", header=T)

temps$date <- as.Date(strptime(temps$date,"%d%b%Y"))

library(ggplot2)
library(maps)
borders <- data.frame(map("world", xlim=c(10,50), ylim=c(40, 80), plot=F)[c("x","y")])

xlim <- scale_x_continuous(limits = c(24, 39))

ggplot(cities, aes(x = long, y = lat)) + 
geom_path(
  aes(size = survivors, colour = direction, group = group), 
  data=troops
) + 
geom_point() + 
geom_text(aes(label = city), hjust=0, vjust=1, size=4) + 
scale_size(to = c(1, 10)) + 
scale_colour_manual(values = c("grey50","red")) +
xlim




ggsave(file = "march.pdf", width=16, height=4)

qplot(long, temp, data=temps, geom="line") + 
geom_text(aes(label = paste(day, month)), vjust=1) + xlim

ggsave(file = "temps.pdf", width=16, height=4)