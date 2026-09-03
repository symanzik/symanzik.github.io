### 
### R Code in Support of:
### 
### 
### Jürgen Symanzik & Daniel B. Carr
### 
### Linked Micromap Plots in R
###
###
### Presentation given at:
### 
###    IASC Satellite Conference, Seoul, Korea -- August 22, 2013
### 


setwd("C://JUE//Teaching//Stat5410_Fa2013_SpatialStats//LectureNotes//R_Data_Micromaps//")


###############################################################################
###
### Part 1: Stand-Alone Approaches
###
###############################################################################

### Simplified micromap with one statistical panel
### Developed for teaching purposes
###
### Mike Minnotte (~2006/2007)
###
###############################################################################

library("RColorBrewer")
library("maps")

pal <- brewer.pal(6, "Set1")
pal[6] <- "#DDDDDD"
data(state)
murder <- state.x77[,5]
murder.name <- state.name[order(murder, decreasing = T)]
murder.name
murder <- sort(murder, decreasing = T)

#pdf("Ch9_micromap_Ex1.pdf", width = 7.5, height = 10)

layout(matrix(1:36, nrow = 12, byrow = T), widths = c(1, 1, 2),
       heights = c(rep(4, 5), 1, rep(4, 5), 3))

#layout.show(36)

for (i in 1:10)
{
  # compute colors, plot map (column 1)
  
  par(mex = 0.1, mar = rep(.01, 4))
  if (i <= 5) m.col <- c(rep(pal[6], 25), rep(0, 25))
  else m.col <- c(rep(0, 25), rep(pal[6], 25))
  m.col[(i-1)*5+1:5] <- pal[1:5]
  map.m.col <- m.col[match.map("state", murder.name)]
  map("state", fill = T, col = map.m.col, border = 0,
      xlim = c(-125, -65), ylim = c(25, 50))
  
  # plot labels (column 2)
  
  par(mar = rep(.1, 4))
  plot(0, 0, xlim = c(0, 1), ylim = c(0, 1), type = "n", bty = "n",
       xaxt = "n", yaxt = "n", xlab = "", ylab = "")
  points(rep(.1, 5), seq(.9, .1, by = -.2), pch = 21, bg = pal[1:5], cex = 2)
  text(rep(.18, 5), seq(.9, .1, by = -.2), murder.name[(i-1)*5+1:5], pos = 4, cex = 1.5)
  
  # plot dotplot of values (column 3)
  
  par(mar = rep(.1, 4))
  if (i == 10) plot(0, 0, xlim = range(murder), ylim = c(0, 1), type = "n",
                    yaxt = "n", xlab = "", ylab = "")
  else plot(0, 0, xlim = range(murder), ylim = c(0, 1), type = "n", xaxt = "n",
            yaxt = "n", xlab = "", ylab = "")
  abline(h = seq(.9, .1, by = -.2), lty = 3, col = "grey")
  points(murder[(i-1)*5+1:5], seq(.9, .1, by = -.2),pch = 21, bg = pal[1:5], cex = 2)
  
  # separate states above and below median
  
  if (i == 5) {for (j in 1:3){
    plot(0, 0, xlim = c(0, 1), ylim = c(0, 1), type = "n", bty = "n",
         xaxt = "n", yaxt = "n", xlab = "", ylab = "")
    abline(h = .5, lwd = 3, col = pal[6])
  }}
  
  # Plot through remaining (empty) cells
  if (i == 10) for (j in 1:3)
    plot(0, 0, xlim = c(0, 1), ylim = c(0, 1), type = "n", bty = "n",
         xaxt = "n", yaxt = "n", xlab = "", ylab = "")
}

# Label for dot plots

text(0.5, 0.25, "Murders per 100K Population", cex = 1.5)

# dev.off()


###############################################################################

### Basic Example via R package ggplot2


### Brian S. Diggs, PhD
### Senior Research Associate, Department of Surgery
### Oregon Health & Science University
###
### 7/11/2011
###
### from https://groups.google.com/forum/?fromgroups#!topic/ggplot2/djLY7AeCd7Y
###
### 8/20/2013 Update: Juergen Symanzik
###
###############################################################################

library("ggplot2")
library("maps")
library("plyr")
library("gridExtra")

# Get Maryland county shapes
data(countyMapEnv)
md <- map_data(map="county", region="maryland")
md.counties <- unique(md$subregion)

# Create some fake data for the ranking of counties
md.df <- data.frame(county=md.counties,
                    rate=sample(40:80, length(md.counties), replace=TRUE))
md.df <- md.df[rev(order(md.df$rate)),]
md.df$rank <- 1:nrow(md.df)

#group by 5's
md.df <- transform(md.df,
                   grouping = ((rank-1) %/% 5) + 1,
                   in.group.pos = ((rank-1) %% 5) + 1,
                   county = factor(county, levels=rev(county)))

# Make the rate plot; colour is controlled by the position in group
# variable, so the colors get recycled across facets.
ranks.plot <-
  ggplot(md.df) +
  geom_point(aes(x=rate, y=county, colour=factor(in.group.pos))) +
  facet_wrap(~grouping, ncol=1, scales="free_y") +
  scale_colour_manual(values=c("red", "orange", "green", "blue",
                               "purple"), legend = FALSE) +
  opts(strip.background = theme_blank(), strip.text.x = theme_blank())

# Make the data needed for the micromaps
md2 <- merge(md, md.df, by.x="subregion", by.y="county")
md2 <- md2[order(md2$order),]

# Coloring the counties that appeared previously was tricky;
# this dataset associates with each grouping all the counties
# that are in a smaller numbered group.
md2.lesser <- ddply(data.frame(grouping=unique(md2$grouping)),
                    .(grouping),
                    function(x) {
                      ttt <- md2[md2$grouping < x$grouping,]
                      ttt$grouping <- NULL
                      ttt
                    })

# The micromaps plot
counties.plot <-
  ggplot(md2, aes(x=long, y=lat, group=group)) +
  geom_polygon(fill=NA, colour="black", data=transform(md2,
                                                       grouping=NULL, in.group.pos=NULL)) +
  geom_polygon(fill="gray80", colour="black", data=md2.lesser) +
  geom_polygon(aes(fill=factor(in.group.pos)), colour="black") +
  scale_fill_manual(values=c("red", "orange", "green", "blue",
                             "purple"), guide = "none") +
  facet_wrap(~grouping, ncol=1) +
  coord_map() +
  theme(strip.background = element_blank(), strip.text.x = element_blank(),
        panel.background = element_blank(), panel.grid.major =
          element_blank(),
        panel.grid.minor = element_blank(), axis.text.x = element_blank(),
        axis.text.y = element_blank(), axis.title.x = element_blank(),
        axis.title.y = element_blank(), axis.line = element_blank(),
        axis.ticks = element_blank()
  )

# These two plots are disjoint; they can't be faceted because they are
# not the same type.  Using ideas from ggExtra::align.plots to compose
# these next to each other.

grid.newpage()
vp <- viewport(layout = grid.layout(ncol = 2))
pushViewport(vp)
pushViewport(viewport(layout.pos.col = 1))
grid.draw(ggplotGrob(counties.plot))
upViewport(1)
pushViewport(viewport(layout.pos.col = 2))
grid.draw(ggplotGrob(ranks.plot))
upViewport(1)


###############################################################################

# Linked micromap plots (two statistical panels)
# By         Daniel B. Carr (revised for current data by Nathan Voge)
#             
#
#            1 Import functions and data
#            2 Sort data and extract abbreviations
#            3 Colors and Graphics Device
#            4 Define panel layouts 
#
#            5 Define graphics parameters
#            6 Set up for processing in loops
#            7 Draw maps
#            8 Draw linking dots and state names
#
#            9 Draw estimates and confidence bounds
#           10 Draw counts
#           11 Draw title and legend
#           12 Outline groups of panels
###############################################################################

# 1. Import needed functions and data_______________________________________

# read in data
fvsmk = read.csv("fvsmk_DC.csv", row.names = 1, header = TRUE)  # row.names = 1 makes row numbers go away

load("panelLayout.Rdata")  # workspace that has all the panel layout functions

# read in polygon shapes for map 
stateVBorders = read.csv("stateVisibilityBorders.txt", row.names = NULL, 
                         header = TRUE)  # "st" = state IDs, "x" and "y" are 
# polygon coordinates   
nationVBorders = read.csv("nationVisibilityBorders.txt", 
                          blank.lines.skip = FALSE, row.names = NULL, 
                          header = TRUE)

# get Fips codes which are numbers the government uses to identify states 
stateNamesFips = read.csv("stateNamesFips.txt", row.names = 1, header = TRUE)

# save it as a .pdf (looks better)
pdf("fvsmk_22Jul_map.pdf", width = 7.5, height = 10)


# 2. Sort the data.frame by fruit and veg consumption (high to low) and
#    extract the state abbreviations for later use____________________________

ord = rev(order(fvsmk$Fruit_Vegs))
fvsmk = fvsmk[ord, ]
stateDataId = row.names(fvsmk)


# 3. Start Graphics Device and Define Colors____________________________________

wgray = rgb(.82, .82, .82)  #white gray

rgbColors = matrix(c(
  1.00, .30, .30,
  1.00, .50, .00,
  .25,1.00, .25,
  .10, .65, 1.00,
  .80, .45, 1.00,
  .35, .35, .35,
  .85, .85, .85,
  .50, .50, .50,
  1.00, 1.00, .85,
  .85, .85, .85), ncol = 3, byrow = TRUE)
hdColors = rgb(rgbColors[, 1], rgbColors[, 2], rgbColors[, 3])


# 4. Define panel layouts______________________________________________________

bot = .77
top = .73
left = 0
right = 0
panels = panelLayout(nrow = 11, ncol = 4,
                     topMar = top, bottomMar = bot,
                     leftMar = left, rightMar = right,
                     rowSep = c(0, 0, 0, 0, 0, .07, .07, 0, 0, 0, 0, 0),
                     rowSize = c(7, 7, 7, 7, 7, 1.5, 7, 7, 7, 7, 7),
                     colSize = c(2.5, 2.2, 2.90, 2.90),
                     colSep = c(0, 0, 0, 0, 0))

panelBlock = panelLayout(nrow = 3, ncol = 3,
                         topMar = top, bottomMar = bot,
                         leftMar = left, rightMar = right,
                         rowSep = c(0, .07, .07, 0),
                         rowSize = c(35, 1.5, 35),
                         colSize = c(4.7, 2.90, 2.90),
                         colSep = c(0, 0, 0, 0))


# 5. Define graphics parameters_______________________________________________

dcex = .95
tCex = 1.08
cex = .65
fontsize = 12
font = 1
line1 = .2
line2 = 1.0
line3 = .2
ypad = .65
nameShift = .12


# 6. Set up indices for perceptual groups of states___________________________

iBegin = c(1, 6, 11, 16, 21, 26, 27, 32, 37, 42, 47)  # group beg subscript
iEnd   = c(5, 10, 15, 20, 25, 26, 31, 36, 41, 46, 51)  # group ending subscript
nGroups = length(iEnd)


# 7. Plot maps________________________________________________________________

# range for scale the polygon panels
rxpoly = range(stateVBorders$x, na.rm = TRUE)
rypoly = range(stateVBorders$y, na.rm = TRUE)

# polygon IDs, one per polygon 
polygonId = stateVBorders$st[is.na(stateVBorders$x)]

# panel titles
panelSelect(panels, 1, 1)
panelScale()
mtext(side = 3, line = line1, "Above Median States", cex = cex)
mtext(side = 3, line = line2, "Micromaps", cex = cex)

panelSelect(panels, 11, 1)
panelScale()
mtext(side = 1, line = line3, "Below Median States", cex = cex)

# drawing the maps
for (i in 1:nGroups) {
  if (i == 6) {    #map not drawn, median state in adjacent panels
    panelSelect(panels, 6, 1)
    panelScale()
    panelFill(col = wgray)
    panelOutline(col = "black")
    text(.5, .55, "Median", cex = cex)
    next  #  "next" halts the processing of the current iteration and advances 
    # the looping index.
  }
  panelSelect(panels, i, 1)
  panelScale(rxpoly, rypoly)
  gsubs = iBegin[i]:iEnd[i]
  if (i == 5) 
    gsubs = c(gsubs, 26)   # median state added here
  if (i == 7) 
    gsubs = c(gsubs, 26)   # median state added here
  if (i < 6) 
    cont = stateDataId[1:26] 
  else 
    cont = stateDataId[26:51]
  # cont means above or below median contour
  panelNames = stateDataId[gsubs]
  
  # plot background (out of contour) states in gray with white outlines 
  back = is.na(match(stateVBorders$st, cont))
  polygon(stateVBorders$x[back], stateVBorders$y[back], col = wgray, 
          border = FALSE)  
  polygon(stateVBorders$x[back], stateVBorders$y[back], col = "white",
          density = 0) 
  # outline states
  
  # plot foreground states for the panel in their special colors pens 1:5
  # and other in contour states in light yellow pen 9
  fore = !back
  pen = match(polygonId, panelNames, nomatch = 9)[!is.na(match(polygonId, cont))]
  polygon(stateVBorders$x[fore], stateVBorders$y[fore], col = hdColors[pen], 
          border = FALSE) # outline states
  polygon(stateVBorders$x[fore], stateVBorders$y[fore], col = "black", 
          density = 0, lwd = 1) # outline states
  
  # outline U.S.
  polygon(nationVBorders$x, nationVBorders$y, col = "black", density = 0, 
          lwd = 1) 
  # outside boundary
}


# 8. Plot labels_______________________________________________________________

# get full state names in rate order
ord = match(stateDataId, stateNamesFips$ab)  # match state names  
stateNames = row.names(stateNamesFips)[ord]  # get the full state names except 
# D.C.
cbind(stateDataId, stateNames)               # check that the matching has 
# worked
# title column
panelSelect(panels, 1, 2)
panelScale()
mtext(side = 3, line = line1, "", cex = cex)
mtext(side = 3, line = line2, "States", cex = cex)

# draw state names
for (i in 1:nGroups) {
  gsubs = iBegin[i]:iEnd[i]
  gnams = stateNames[gsubs]
  nsubs = length(gnams)
  pen = 1:nsubs
  laby = nsubs:1
  panelSelect(panels, i, 2)
  panelScale(c(0, 1), c(1-ypad, nsubs + ypad))
  
  if (i == 6) {
    pen = 6
    panelFill(col = wgray)
    panelOutline()
  }  
  
  for (j in 1:length(pen)) {
    points(.1,laby[j], pch = 16, col = hdColors[pen[j]], cex = dcex)
    points(.1,laby[j], pch = 1, col = "black", cex = dcex)	
    text(.18, laby[j] + nameShift, gnams[j], cex = cex ,adj = 0, 
         col = "black", font = font)
  }
}


# 9. Plot rates with confidence bounds_________________________________________

countRange1 = range(fvsmk$Fruit_Vegs)
countRange1 = mean(countRange1) + 1.10 * diff(countRange1) * c(-.5, .5)
countGrid1 = panelInbounds(countRange1) # used pretty values that are in bounds

panelSelect(panels, 1, 3)
panelScale()
mtext(side = 3, line = line1, "(at least 5 times a day)", cex = cex)
mtext(side = 3, line = line2, "Fruit and Vegs Consumption", cex = cex)

for (i in 1:nGroups) {
  gsubs = iBegin[i]:iEnd[i]
  nsubs = length(gsubs)
  pen = 1:nsubs
  laby = nsubs:1
  panelSelect(panels, i, 3)
  panelScale(countRange1, c(1-ypad, nsubs + ypad))
  panelFill(col = wgray)
  panelGrid(x = countGrid1, col = "white", lwd = 1)
  panelGrid(x = 5.6, col = "black", lty = 2)  # hard code U.S. average
  panelOutline(col = "white")
  
  if (i == nGroups) {
    axis(side = 1, at = countGrid1, labels = as.character(countGrid1),
         col = "black", mgp = c(1, 0, 0), tck = -.04, cex.axis = cex)
    mtext(side = 1, line = .7, "Percent", cex = cex)
  }
  
  if (i == 6) 
    pen = 6
  
  lines(fvsmk$Fruit_Vegs[gsubs], laby, col = "black", lwd = 1)
  
  for (j in 1:length(pen)) {
    points(fvsmk$Fruit_Vegs[gsubs[j]], laby[j], pch = 16,
           cex = dcex, col = hdColors[pen[j]])
    points(fvsmk$Fruit_Vegs[gsubs[j]], laby[j], pch = 1,
           cex = dcex, col = "black")
  } 
}


# 10. Plot counts____________________________________________________________

countRange = range(fvsmk$Smoke)
countRange = mean(countRange) + 1.10 * diff(countRange) * c(-.5, .5)
countGrid = panelInbounds(countRange) # used pretty values that are in bounds

panelSelect(panels, 1, 4)
panelScale()
mtext(side = 3, line = line1, "Smoking", cex = cex)
mtext(side = 3, line = line2, "Daily", cex = cex)

for (i in 1:nGroups) {
  gsubs = iBegin[i]:iEnd[i]
  nsubs = length(gsubs)
  pen = 1:nsubs
  laby = nsubs:1
  panelSelect(panels, i, 4)
  panelScale(countRange, c(1 - ypad, nsubs + ypad))
  panelFill(col = wgray)
  panelGrid(x = countGrid, col = "white")
  panelOutline(col = "white")
  
  if (i == nGroups) {
    axis(side = 1, at = countGrid, labels = as.character(countGrid),
         col = "black", mgp = c(1, 0, 0), tck = -.04, cex.axis = cex)
    mtext(side = 1, line = .7, "Percent", cex = cex)
  }
  
  if(i == 6)
    pen = 6
  
  lines(fvsmk$Smoke[gsubs], laby, col = "black", lwd = 1)
  
  for (j in 1:length(pen)) {
    points(fvsmk$Smoke[gsubs[j]], laby[j], pch = 16,
           cex = dcex, col = hdColors[pen[j]])
    points(fvsmk$Smoke[gsubs[j]], laby[j], pch = 1,
           cex = dcex, col = "black")
  } 
}


# 11  Add Title and Legend _____________________________________________________

panelSelect(panels, margin = "top")
panelScale()
text(.5, .85, "Fruit and Vegetable Consumption and Smoking Statistics By State",
     cex = 1)

panelSelect(panels, margin = "bottom")
panelScale(inches = TRUE)
xs = 2.8
ys = -.42
# text(.01 + xs, .70 + ys, "U.S. Average", cex = cex, adj = 0, font = 1)
# lines(c(.78, 1.50) + xs, c(.70, .70) + ys, lty = 2, col = "black")
# text(.01 + xs, .53 + ys, "90% Confidence Interval", cex = cex, adj = 0, 
#      font = 1)
# lines(c(1.35, 1.61) + xs, c(.53, .53) + ys, lwd = 2, col = hdColors[1])


# 12. Outline groups of Panels__________________________________________________

for (i in 1:3) {
  for (j in 2:3) {
    panelSelect(panelBlock, i, j)
    panelScale()
    panelOutline(col = "black")
  }
}

panelSelect(panelBlock, 2, 1)
panelScale()
panelOutline(col = "black")

dev.off()


###############################################################################
###
### Part 2: Templates in Support of Carr & Pickle (2010)
###
###############################################################################

###############################################################################
# File   Fig4_15_Iowa
# By     Dan Carr
#
#        1.  Graphics Device
#        2.  Read migration Data
#        3.  Percent calculations
#        4.  Read state centroids
#        5.  Panel Layouts and Graphics Parameters
#
#        6. and 7.  Maps in columns 1 and 4
#        8. State abbreviation columns 2 and 5
#        9. Percent dots column 3 and 6
#        10. Used title and outlines

# Scripts assume panelFunctions
source("panelFunctions.r")

# Many scripts assume State Boundary Files
stateVBorders = read.csv('stateVisibilityBorders.csv',
                         row.names=NULL,header=TRUE,as.is=TRUE)
nationVBorders = read.csv('nationVisibilityBorders.csv',
                          blank.lines.skip=F,row.names=NULL,header=TRUE,as.is=TRUE)   

# 1.  Graphics device and colors

# pdf(width=6.3,height=7.5,file='Fig4_15Iowa.pdf')
# windows(width=6.5,height=7.5)


wgray=rgb(.78,.78,.78)
wmgray=rgb(.77,.77,.77)

mgray=rgb(.69,.69,.69)
mgray = wgray
wyellow = rgb(242,242,180,max=256)
wgreen=rgb(.85,1.00,.85)
rgbcolors=matrix(c(
  1.00, 0.10, 0.10,
  1.00, 0.50, 0.00,
  0.00, 0.76, 0.00,
  0.00, 0.50, 1.00,
  0.70, 0.35, 1.00,
  0.35, 0.35, 0.35,
  0.85, 0.85, 0.85,
  0.50, 0.50, 0.50,
  1.00, 1.00, 0.85,
  0.85, 0.85, 0.85),ncol=3,byrow=T)
hdColors=rgb(rgbcolors[,1],rgbcolors[,2],rgbcolors[,3])


# 2. Read migration data and check on meaning  

mig = read.csv("stateToStateMigration19952000.csv",row.names=1,as.is=TRUE)

head(mig)

# column 1 total at the end
# column 2 did not move
# other columns moved into Iowa
# the Iowa column moved within iowa so I want to exclude it from
#  the moving into iowa total.
# check
mig[,1] == apply(mig[,2:53],1,sum,na.rm=TRUE)  # Note" ND row has a missing value for RI   

# 3. Calculate percents for Iowa and sort in descenting order

pick = 16 # row number of Iowa

totIn = mig[pick,1]-mig[pick,2]-mig[pick,pick+2]
moveInPer = 100*mig[pick,-c(1,2,pick+2)]/totIn  # nicely labeled
sum(moveInPer)

moveOut = mig[-pick,pick+2]
totOut = sum(moveOut)
moveOutPer = 100*moveOut/totOut
sum(moveOutPer) 
names(moveOutPer) = rownames(mig)[-pick]  

moveInPerSort = sort(moveInPer,decreasing=TRUE)
moveInId = names(moveInPerSort)

moveOutPerSort = sort(moveOutPer,decreasing=TRUE)
moveOutId = names(moveOutPerSort)

# 4. Read in state centroids as set map scale ________________
#    The states and nation boundardies should be available

centroids=read.csv('stateCenteroid.csv',row.names=NULL,header=T,
                   stringsAsFactors=FALSE)

rxpoly=range(stateVBorders$x,na.rm=T)
rypoly=range(stateVBorders$y,na.rm=T)

polygonId=stateVBorders$st[is.na(stateVBorders$x)]

# 4. Colors _______________________________

# 5. Panel Layout and graphis parameters____________________________________________
bot=0.2
top=0.3
left=0
right=0
font=1

panels=panelLayout(nrow=10,ncol=6,borders=rep(.2,4),
                   topMar=top,bottomMar=bot,
                   leftMar=left,rightMar=right,
                   rowSep=c(rep(0,5),.07,rep(0,5)),
                   rowSize=c(7,7,7,7,7,7,7,7,7,7),
                   colSize=c(2.5,1.0,2.3,2.3,1.0,2.5),
                   colSep=c(0,.02,0,0.3,.02,0,0))

panelBlock=panelLayout(nrow=1,ncol=4,
                       topMar=top,bottomMar=bot,
                       leftMar=left,rightMar=right,
                       rowSep=c(0,0),
                       colSize=c(3.6,3.5,3.6,2.5),colSep=c(0,0,.5,0,0))

dcex=1.03
tcex=1.08
cex=0.72
fontsize=12
line1=.2
line2=1.0
line3=.2
ypad=.65
nameShift=0

iBeg=c(1,6,11,16,21,26,31,36,41,46)
iEnd=c(5,10,15,20,25,30,35,40,45,50)
nGroups=length(iEnd)

# 6.  Column 1 Moving Into Iowa maps

regionId = moveInId

panelSelect(panels,1,1)
panelScale()
mtext(side=3,line=line2,'Iowa Welcomes',cex=cex,font=2)
mtext(side=3,line=line1,'214,841',cex=cex,font=1)


for (i in 1:nGroups){
  panelSelect(panels,i,1)
  panelScale(rxpoly,rypoly)
  gsubs = iBeg[i]:iEnd[i]
  gnams = regionId[gsubs]
  front = regionId[1:iEnd[i]] 
  
  back = is.na(match(stateVBorders$st,front))
  polygon(stateVBorders$x[back], stateVBorders$y[back],col="white",border=wgray) 
  highlight = !is.na(match(stateVBorders$st,gnams))
  pen= match(polygonId,gnams)
  pen=pen[!is.na(pen)]
  fore = !back
  previous = fore & !highlight
  if(any(previous))polygon(stateVBorders$x[previous],stateVBorders$y[previous],
                           col=wgreen,border=mgray)
  polygon(nationVBorders$x,nationVBorders$y,col="#909090",density=0,lwd=1) 
  polygon(stateVBorders$x[highlight], stateVBorders$y[highlight],col=hdColors[pen],border='black') 
  
  
  pen=match(centroids$st,gnams)
  draw=!is.na(pen)
  pen=pen[draw]
  segments(centroids$x[draw],centroids$y[draw],72.5,64,col=hdColors[pen],lwd=2)
  
  draw=!is.na(match(stateVBorders$st,"IA"))
  polygon(stateVBorders$x[draw],stateVBorders$y[draw],col="#FFFF00",border=T,lwd=1)
}

# 7.  Column 4 Moving Out Iowa maps

panelSelect(panels,1,4)
panelScale()
mtext(side=3,line=line2,'Iowa Will Miss',cex=cex,font=2)
mtext(side=3,line=line1,'247,853',cex=cex,font=1)

regionId = moveOutId

for (i in 1:nGroups){
  panelSelect(panels,i,4)
  panelScale(rxpoly,rypoly)
  gsubs = iBeg[i]:iEnd[i]
  gnams = regionId[gsubs]
  front = regionId[1:iEnd[i]] 
  
  back = is.na(match(stateVBorders$st,front))
  polygon(stateVBorders$x[back], stateVBorders$y[back],col="white",border=wgray) 
  highlight = !is.na(match(stateVBorders$st,gnams))
  pen= match(polygonId,gnams)
  pen=pen[!is.na(pen)]
  fore = !back
  previous = fore & !highlight
  if(any(previous))polygon(stateVBorders$x[previous],stateVBorders$y[previous],
                           col=wgreen,border=mgray)
  polygon(nationVBorders$x,nationVBorders$y,col="#909090",density=0,lwd=1) 
  polygon(stateVBorders$x[highlight], stateVBorders$y[highlight],col=hdColors[pen],border='black') 
  
  
  pen=match(centroids$st,gnams)
  draw=!is.na(pen)
  pen=pen[draw]
  segments(centroids$x[draw],centroids$y[draw],72.5,64,col=hdColors[pen],lwd=2)
  
  draw=!is.na(match(stateVBorders$st,"IA"))
  polygon(stateVBorders$x[draw],stateVBorders$y[draw],col="#FFFF00",border=T)
}

# 8. State names for columns 2 and 5

# title
panelSelect(panels,1,2)
panelScale()
mtext(side=3,line=line1,'From',cex=cex)
mtext(side=3,line=line2,'Coming',cex=cex)


stateId = moveInId
for(i in 1:nGroups){
  gsubs=iBeg[i]:iEnd[i]
  gnams=stateId[gsubs]
  nsubs=length(gnams)
  pen=1:nsubs
  lady=nsubs:1
  panelSelect(panels,i,2)
  panelScale(c(0,1),c(1-ypad,nsubs+ypad))
  points(rep(.3,nsubs),lady,pch=21,bg=hdColors[pen],col='black',cex=dcex)
  text(.45,lady+nameShift,gnams,cex=cex-.02,col='black',font=font,adj=c(0,.5))
}


# title
panelSelect(panels,1,5)
panelScale()
mtext(side=3,line=line1,'To',cex=cex)
mtext(side=3,line=line2,'Going',cex=cex)

stateId=moveOutId    
for(i in 1:nGroups){
  gsubs=iBeg[i]:iEnd[i]
  gnams=stateId[gsubs]
  nsubs=length(gnams)
  pen=1:nsubs
  lady=nsubs:1
  panelSelect(panels,i,5)
  panelScale(c(0,1),c(1-ypad,nsubs+ypad))
  points(rep(.3,nsubs),lady,pch=21,bg=hdColors[pen],col='black',cex=dcex)
  text(.45,lady+nameShift,gnams,cex=cex-.02,col='black',font=font,adj=c(0,.5))
}

# 9. Dots plots for Columns 3 and 6

panelSelect(panels,1,3)
panelScale()
mtext(side=3,line=line1,'Total Coming',cex=cex)
mtext(side=3,line=line2,'Percent of',cex=cex)

panVal =moveInPerSort
panRx=range(panVal)
panRx = mean(panRx)+1.12*diff(panRx)*c(-.5,.5)
panRx = c(-1,16)
panGrid=c(0,4,8,12,16)

for(i in 1:nGroups){
  gsubs=iBeg[i]:iEnd[i]
  nsubs=length(gsubs)
  pen=1:nsubs
  laby=nsubs:1
  panelSelect(panels,i,3)
  panelScale(panRx,c(1-ypad,nsubs+ypad))
  panelFill(col="#E0E0E0")
  panelGrid(x=panGrid,col='white',lwd=1)
  panelOutline(col='black')
  
  if(i==nGroups){
    axis(side=1,at=panGrid,
         labels=TRUE,
         col='black',mgp=c(1.0,-0.1,0),tck=FALSE,cex.axis=cex)
  }
  #    lines(panVal[gsubs],laby,col='black',lwd=1)
  points(panVal[gsubs],laby,pch=21,
         bg=hdColors[pen],cex=dcex,col='black')
}

panelSelect(panels,1,6)
panelScale()
mtext(side=3,line=line1,'Total Going',cex=cex)
mtext(side=3,line=line2,'Percent of',cex=cex)

panVal = moveOutPerSort
panRx=range(panVal)
panRx=mean(panRx)+1.12*diff(panRx)*c(-.5,.5)
panRx[1] = -1
panGrid=c(0,4,8,12)

for(i in 1:nGroups){
  gsubs=iBeg[i]:iEnd[i]
  nsubs=length(gsubs)
  pen=1:nsubs
  laby=nsubs:1
  panelSelect(panels,i,6)
  panelScale(panRx,c(1-ypad,nsubs+ypad))
  panelFill(col="#E0E0E0")
  panelGrid(x=panGrid,col='white',lwd=1)
  panelOutline(col='black')   
  if(i==nGroups){axis(side=1,at=panGrid,
                      labels=TRUE,col='black',mgp=c(1.0,-0.1,0),
                      tck=FALSE,cex.axis=cex)
  }
  #   lines(panVal[gsubs],laby,col='black',lwd=1)
  points(panVal[gsubs],laby,pch=21,
         cex=dcex,bg=hdColors[pen],col='black')
}

# 10.  Unused title and outlines
#panelSelect(panels,margin='top')
#panelScale()
#text(.5,.8,'Iowa Migration from 1995 to 2000',cex=1.15)

#for(i in c(3,5)){
#panelSelect(panelBlock,1,i)
#panelScale()
#panelOutline(col='black') #}

if(names(dev.cur())=="pdf")
  dev.off()


###############################################################################
###
### Part 3: R Package micromap
###
###############################################################################


### Produces Fig 1 from Symanzik & Carr (2013)
###
### Intended as a close reproduction (in R) of the LM plot from
###
###   Samson Y. Gebreab, Robert R. Gillies, Ronald G. Munger and Juergen Symanzik
###   Visualization and Interpretation of Birth Defects Data Using Linked Micromap Plots
###   Birth Defects Research (Part A) 82:110-119 (2008)
###
###   Fig 2: Oral Cleft Occurrence by State, 1998-2002
###
### Juergen Symanzik, 5/30/2013
###
### Additional functionality and help provided by the developers of the
### R package micromap (Payton, McManus, Weber, Olsen, and Kincaid)
###
###############################################################################

library("micromap")

### Helper functions for micromap package

connected_dot_att <- function (show = FALSE){
  tmp.att <- append(standard_att(), 
                    list(point.size = as.numeric(1), 
                         point.type = as.numeric(19), 
                         point.border = as.logical(TRUE), 
                         line.col = gray(.6), 
                         line.typ = "solid", 
                         line.size = as.numeric(.5), 
                         add.line = NA, 
                         add.line.col = "red", 
                         add.line.typ = "solid", 
                         add.line.size = as.numeric(1)))
  tmp.att
}

connected_dot_build <- function(myPanel, myNumber, myNewStats, myAtts){
  myColors <- myAtts$colors 			
  myColumns <- myAtts[[myNumber]]$panel.data 	
  
  myLineSize <- myAtts[[myNumber]]$line.size	
  myLineType <- myAtts[[myNumber]]$line.typ	
  myLineColor <- myAtts[[myNumber]]$line.col	
  
  myAddLine <- myAtts[[myNumber]]$add.line
  myAddLineSize <- myAtts[[myNumber]]$add.line.size
  myAddLineType <- myAtts[[myNumber]]$add.line.typ	
  myAddLineColor <- myAtts[[myNumber]]$add.line.col	
  
  myPointBorder <- myAtts[[myNumber]]$point.border
  myPointType <- myAtts[[myNumber]]$point.type	
  myPointSize <- myAtts[[myNumber]]$point.size	
  
  
  myNewStats$data1 <- myNewStats[, myColumns]
  myNewStats$data2 <- c(0, myNewStats$data1[-nrow(myNewStats)])
  myNewStats$data3 <- myNewStats$pGrpOrd - 1
  
  myNewStats <- alterForMedian(myNewStats, myAtts)
  
  myPanel  <- ggplot(myNewStats)
  
  if (!is.na(myAddLine)) myPanel  <- myPanel  + geom_vline(xintercept = myAddLine, 
                                                           colour = myAddLineColor, 
                                                           size = myAddLineSize, 
                                                           linetype = myAddLineType)
  
  myPanel  <- myPanel  + geom_segment(aes(x = data1, y = -pGrpOrd,
                                          xend = data2, yend = -data3),
                                      data = subset(myNewStats, pGrpOrd>1), 
                                      colour = myLineColor, 
                                      size = myLineSize, 
                                      linetype = myLineType)   
  
  if (myPointBorder) 
    myPanel  <- myPanel  + geom_point(aes(x = data1, y = -pGrpOrd), 
                                      colour = "black", 
                                      size = myPointSize * 2.5, 
                                      pch = myPointType)
  
  myPanel  <- myPanel + geom_point(aes(x = data1, y = -pGrpOrd, 
                                       colour = factor(color)), 
                                   size = myPointSize * 2, 
                                   pch = myPointType) 
  
  myPanel  <- myPanel + 
    facet_grid(pGrp ~ ., scales = "free_y", space = "free") 
  
  
  myXlimits <- range(myNewStats$data1, na.rm = T)
  if (any(!is.na(myAtts[[myNumber]]$xaxis.ticks))) 
    myXlimits <- range(c(myXlimits, myAtts[[myNumber]]$xaxis.ticks))
  myXlimits <- myXlimits + c(-1, 1) * diff(myXlimits) * 0.05
  
  myYlimits <- -(range(myNewStats$pGrpOrd) + c(-1, 1) * 0.5)
  
  myPanel <- assimilatePlot(myPanel, myNumber, myAtts, myXlimits, myYlimits) 
  
  myPanel
}


### Main example

uscases = read.table("statebd.csv", header = T, sep = ",")

NTDrate = uscases$NTDRate
OCrate = uscases$TOCRate
usorder = order(-OCrate)
uscasessort = cbind(uscases[usorder, ], OCrate[usorder], OCrate[usorder])

data("USstates")
statePolys = create_map_table(USstates, "ST")

uscasessort$points = 0
uscasessort$logTOCRate = log10(uscasessort$TOCRate)
uscasessort$logSM02 = log10(uscasessort$SM02)
uscasessort$logAIANOLNY = log10(uscasessort$AIANOLNY)

### Basic figure (test)

lmplot(stat.data = uscasessort,
       map.data = statePolys,
       panel.types = c("labels", "dot", "dot", "dot", "dot", "map"),
       panel.data = list("STATE", "points", "logTOCRate", "logSM02", "logAIANOLNY", NA),
       ord.by = "logTOCRate",
       rev.ord = TRUE,
       grouping = 5, 
       median.row = TRUE,
       map.link = c("ID", "ID"))


### Advanced figure

myPlot <- lmplot(stat.data = uscasessort, 
                 map.data = statePolys,
                 panel.types = c("map", "dot", "labels", 
                                 "connected_dot", "connected_dot", "connected_dot"),  ### new graph type
                 panel.data = list(NA, "points", "STATE", "logTOCRate", "logSM02", "logAIANOLNY"),
                 map.link = c("ID", "ID"),
                 ord.by = "TOCRate",
                 rev.ord = TRUE,
                 
                 grouping = 5,
                 median.row = TRUE,
                 plot.height = 9,
                 colors = c("red", "orange", "green", "blue", "purple"),
                 two.ended.maps = TRUE,
                 map.all = TRUE,
                 map.color2 = "lightgray",
                 
                 plot.header = "Oral Cleft Occurrence by State\n 1998-2002",
                 plot.header.size = 2,
                 plot.header.color = "black",
                 plot.panel.spacing = 0,
                 panel.att = list(list(2, panel.width = .15, 
                                       point.type = 20,
                                       point.size = 1.4,
                                       graph.border.color = "white",
                                       xaxis.text.display = FALSE, 
                                       xaxis.line.display = FALSE,
                                       graph.grid.major = FALSE),
                                  list(3, header = "States", 
                                       panel.width = .9,
                                       align = "left", 
                                       text.size = .8),
                                  list(4, header = "Occurrence",
                                       graph.bgcolor = "lightgray", 
                                       point.size = 1,
                                       xaxis.ticks = list(seq(1.0, 1.4, by = 0.2)), 
                                       xaxis.labels = list(seq(1.0, 1.4, by = 0.2)),
                                       xaxis.title = "log10(Cases per 10,000)",
                                       add.line = log(17.7, 10), 	### add meanline
                                       add.line.size = .5,		### add meanline
                                       add.line.col = "red"),		### add meanline
                                  list(5, header = "Smoking",
                                       graph.bgcolor = "lightgray", 
                                       point.size = 1,
                                       xaxis.ticks = list(seq(0.7, 1.6, by = 0.2)), 
                                       xaxis.labels = list(seq(0.7, 1.6, by = 0.2)),
                                       xaxis.title = "log10(Percent)",
                                       add.line = log(16, 10),	### add meanline
                                       add.line.size = .5,		### add meanline
                                       add.line.typ = "dashed",	### add meanline
                                       add.line.col = "red"),		### add meanline
                                  list(6, header = "AIAN",
                                       graph.bgcolor = "lightgray", 
                                       point.size = 1,
                                       xaxis.ticks = list(seq(-0.5, 1.5, by = 1.0)), 
                                       xaxis.labels = list(seq(-0.5, 1.5, by = 1.0)),
                                       xaxis.title = "log10(Percent)",
                                       add.line = log(1.3, 10),	### add meanline	
                                       add.line.size = .5,		### add meanline
                                       add.line.typ = "longdash",	### add meanline
                                       add.line.col = "red"),	### add meanline
                                  list(1, header = "Maps",
                                       inactive.border.color = gray(.7), 
                                       inactive.border.size = 1,
                                       panel.width = 1.0)))


# printLMPlot(myPlot, name = "Example_Redone_Juergen1.6.jpeg", res = 300)


###############################################################################
###
### Part 4: R Package micromapST
###
###############################################################################

### Produces Fig 2 from Symanzik & Carr (2013)
###
### Daniel B. Carr, June 2013
###
###############################################################################

library("micromapST")

m4np <- read.csv('Math 4th grade 2011.csv', header = TRUE, 
                 as.is = TRUE, row.names = 1)

np <- m4np[1, ] # National public
stateData <- m4np[-1, ]

head(stateData )
stateData[, 7] <- -stateData[, 7]
stateData$lower <- stateData[, 7] - qnorm(.975) * stateData[, 8]
stateData$upper <- stateData [, 7] + qnorm(.975) * stateData[, 8]

panelDesc <- data.frame(
  type = c('mapmedian', 'id', 'arrow', 'dotconf'),
  col1 = c(NA, NA, 3, 7),
  col2 = c(NA, NA, 5, 9),
  col3 = c(NA, NA, NA, 10),
  lab1 = c('', '', 'From Eligible', 'Non-Eligible - Eligible'),
  lab2 = c('', '', 'To Non-Eligible', '95% Confidence Intervals'),
  lab3 = c('', '', 'Group Average Scores', 'Difference of Averages')
)

pdf(width = 7.5, height = 10, file = 'MapMedianB.pdf')

micromapST(stateData, panelDesc, rowNames = 'full', sortVar = 3,
           title = c("NAEP Average Mathematics Scores: 4th Grade 2011",
                     "School Lunch Program Eligible Versus Non-Eligible Students")
)

dev.off()


###############################################################################

###
#   micromapST - Example # 1 - map with no cumulative shading,
#     2 columns of statistics: dot with 95% confidence interval, boxplot
#     sorted in descending order by state rates
###

###############################################################################

# load sample data, compute boxplot
data(wflung00and95,wflung00and95US,wflung00cnty) 
wfboxlist = boxplot(split(wflung00cnty$rate,wflung00cnty$stabr),plot=FALSE)  

# set up 4 column page layout
panelDesc <- data.frame(
  type=c('map','id','dotconf','boxplot'),    
  lab1=c('','','State Rate','County Rates'),  
  lab2=c('','','and 95% CI','(suppressed if 1-9 deaths)'), 
  lab3=c('','','Deaths per 100,000','Deaths per 100,000'), 
  col1=c(NA,NA,1,NA),col2=c(NA,NA,3,NA),col3=c(NA,NA,4,NA),     
  refVals=c(NA,NA,wflung00and95US[1,1],NA),   
  refTexts=c(NA,NA,'US Rate 2000-4',NA),       
  panelData= c('','','','wfboxlist')          
) 

# set up PDF output file, call package
FDir = getwd()         
FName = paste(FDir,"/EX1-WFLung-2000-2004-State-Dot-County-Box.pdf",sep="")

pdf(file=FName,width=7.5,height=10)
micromapST(wflung00and95,panelDesc,sortVar=1,ascend=FALSE,
           title=c("White Female Lung Cancer Mortality, 2000-2004",
                   "State Rates & County Boxplots"))  
dev.off()


###############################################################################

###
#   micromapST - Example 6 - centered (diverging) stacked bars
#
#     National 8th grade Math Proficiency NAEP Test Scores Data for 2011
#     source: National Center for Education Statistics, 
#     http://nces.ed.gov/nationsreportcard/naepdata/
#     bar segment values - % in each of 4 categories: 
#           % < Basic, % at Basic, % Proficient, % Advanced
###

###############################################################################

data(Educ8thData)  
# columns = State abbrev, State name, Avg Score, %s \<basic, 
#           basic, proficient, advanced

panelDesc = data.frame(                 
  type=c('map','id','dot','ctrbar'),
  lab1=c('','','Avg. Scores','Math Proficiency'),         
  lab2=c('','','','<Basic, Basic, Proficient, Advanced'),  
  lab3=c('','','','% to Left of 0           |    % to Right'),  
  col1=c(NA,NA,3,4),col2=c(NA,NA,NA,7)   
)
ExTitle = c("Stacked Bars: Educational Progress (NAEP) in Math, 2011, 8th Grade",
            "Centered at Not Proficient vs. Proficient")
ExFile  = "/EX6-Educ-Centered-Bar"
FDir = getwd()          	
FName = paste(FDir,ExFile,".pdf",sep="")

pdf(file=FName,width=7.5,height=10)
micromapST(Educ8thData,panelDesc,sortVar=3, title=ExTitle)  
dev.off()

