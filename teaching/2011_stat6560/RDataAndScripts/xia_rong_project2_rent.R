#########################################################################
###                             Input data                           ####
#########################################################################

data_url <- "http://www.interactivegraphics.org/Datasets_files/rent.txt"

rents <- read.table(url(data_url), head=TRUE, sep="\t")

head(rents)

##########################################################################
##                         Activiate Iplots                           ####
##########################################################################

library(iplots)

attach(rents)

iplot(Size, Rent)

iset.col(Num..Rooms)

iabline(lm(Rent~Size))

ibar(Num..Rooms)

iset.col()

ibar(Built,isSpine=TRUE)

ihist(Rent)

iset.select(Rent>855.6)

iset.selectNone()

ibox(Rent, Good.Neighborhood)

ibox(Rent, Best.Neighborhood)

ibox(Rent, Warm.Water)

ibox(Rent, Central.Heating)

ibox(Rent, Tiled.Bath)

ibox(Rent, Extra.Bath)

ibox(Rent, Premium.Kitchen)

iplot(Size, Rent)
d <- iplot.data()
iabline(lm(d$y ~ d$x), col = "black")
ilines(lowess(d$x,d$y), col="#0000c0")
ilines(c(0,0),c(0,0), col = "marked", visible = FALSE)
cat("Select 'Break' from the menu of any plot to return back to R.\n")
while (!is.null(ievent.wait())) {
if (iset.sel.changed()) {
s <- iset.selected()
if (length(s) > 1)
iobj.opt(x=lowess(d$x[s],d$y[s]),visible = TRUE)
else iobj.opt(visible = FALSE)
}
}
for(i in 1:3) iobj.rm()
iplot.off()
