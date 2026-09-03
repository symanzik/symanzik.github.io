#Assignment  a6_Linked micromap plots
#By          Daniel B. Carr
#             
#Purpose     Example using panelLayout()
#            and related functions
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
#
#Due         1 Turn in plot as is.  
#            2 Modify script as indicated by the directions below.
#              Turn both the revised script (with changes in red) and
#              the revised plot.
#
#              Assume the audience will recognize state abbreviations.  
#              Replace the full names with state abbreviations.  
#              Decrease the horizontal space allocation to state names
#              Increase the size of the statistial panels to take up the
#                  space made available. That is, in the panel layouts
#                  decrease the column 2 width increase in the column 3
#                  and 4 widths equally,keeping the total sum of column sizes constant. 
#              Don't forget to similarly modify the panelBlock
#                     layout for outlines
#
#              Increase the dot size to make it easier to identify colors.
#		   
#              Some people object to lines connecting dots for different states.
#              Remove the lines in the two statistical panels.
#
#              Add confidence bounds to the last counts panel.  This
#              will involve rescaling, new grids and new tick marks.  			                      
#              
#              Make the confidence interval line a little thicker  
#
#
#Notes:        Parts of the story
#                 What  =  Unemployment Rates
#                          Tricky because of groups EXCLUDES:
#					  Millions in prison
#				       Those taken off the roles of people actively
#                              seeking work based on a certain definition  
#                 Where    =  States with locations show in maps                   
#                 When     =  1995 in the title 
#                 Who      =  not stated, one of my old plots of data 
#                             from the Bureau of Labor Statistics
#                             suggest sample bias in some regions. 
#                 Why      =  Not stated, reporting is required by Congress
#                 How      =  Not stated, sampling in states
#                 How well =  Shown as confidence intervals  
#                 How important = The number unemployed is
#                                 practically and politically important
#                                 Increased military funding was a condidate
#                                 solution in California which was very
#                                 important politically. 
#
#            Geospatial patterns for unemployment rates above the median
#                 Above in the West, except Oregon
#                 Above along the southern border except Arizona
#                 Above along the east side of the Mississippi river
#                 Above in many of the Northeastern states
   
# 1. Import needed functions and data_______________________________________

# 1.1 Panel functions should already be installed
# source('panelFunctions.r')

# 1.2  Read unemployment data from the Bureau of Labor Statistics

##Run  
#stateUnemploy95 = read.csv('stateUnemployment95.csv',row.names=1,header=T)
names(stateUnemploy95) # [1] "rate"  "count"  "etpr" "lfpr" and standard errors
##End

# 1.3  Read file with state names, Fips codes abbreviations

##Run  
#stateNamesFips = read.csv('stateNamesFips.csv',row.names=1,header=T)
##End

# 1.4  Read polygons files used for state boundaries and for US. outline

# Mark Monmonier created and published State Visibility maps
# For example See "Mapping It Out."  On request he sent his coordinates
# to your instructor who adapted them for use in micromaps. 

##Run
#stateVBorders = read.csv('stateVisibilityBorders.csv',row.names=NULL,header=T)
#nationVBorders = read.csv('nationVisibilityBorders.csv',
#                 blank.lines.skip=F,row.names=NULL,header=T)
names(stateVBorders)   # st= state ids, x and y are polygon coordinates  
names(nationVBorders)   # 
##End

# 2. Sort the unemployment data.frame by the unemployment rate and
#    extract the state abbreviations for later use_____________________________________________________

##Run
ord = rev(order(stateUnemploy95$rate))   #rev() reverses the order to be descending
stateUnemploy95=stateUnemploy95[ord,]
stateDataId = row.names(stateUnemploy95)
##End

# 3. Start Graphics Device and Define Colors__________________________________________________________

##Run
#windows(width=7.5,height=10)

wgray = rgb(.82,.82,.82)  #white gray

rgbColors = matrix(c(
 1.00, .30, .30,
 1.00, .50, .00,
  .25,1.00, .25,
  .10, .65,1.00,
  .80, .45,1.00,
  .35, .35, .35,
  .85, .85, .85,
  .50, .50, .50,
 1.00,1.00, .85,
  .85, .85, .85),ncol=3,byrow=T)
hdColors=rgb(rgbColors[,1],rgbColors[,2],rgbColors[,3])
##End

#4. Define panel layouts________________________________________

##Run
bot = .77
top = .73
left = 0
right = 0
panels = panelLayout(nrow=11,ncol=4,
	       topMar=top,bottomMar=bot,
	       leftMar=left,rightMar=right,
          rowSep=c(0,0,0,0,0,.07,.07,0,0,0,0,0),
          rowSize=c(7,7,7,7,7,1.5,7,7,7,7,7),
          colSize=c(2.5,2.2,2.90,2.90),
          colSep=c(0,0,0,0,0))

panelBlock = panelLayout(nrow=3,ncol=3,
 	       topMar=top,bottomMar=bot,
	       leftMar=left,rightMar=right,
             rowSep=c(0,.07,.07,0),
             rowSize=c(35,1.5,35),
             colSize=c(4.7,2.90,2.90),
             colSep=c(0,0,0,0))
##End 
   
#5.  Define graphics parameters____________________________

##Run
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
##End

#6.  Set up indices for perceptual groups of states______________________________________

##Run
iBegin = c(1, 6,11,16,21,26,27,32,37,42,47)  #group beginning  subscript
iEnd   = c(5,10,15,20,25,26,31,36,41,46,51)  #group ending     subscript
nGroups = length(iEnd)
##End

#7.  Plot maps_________________________________________________________

##Run
# range for scale the polygon panels
rxpoly = range(stateVBorders$x,na.rm=T)
rypoly = range(stateVBorders$y,na.rm=T)

# polygon id's one per polygon 
polygonId = stateVBorders$st[is.na(stateVBorders$x)]

# panel titles
panelSelect(panels,1,1)
panelScale()
mtext(side=3,line=line1,'Above Median States',cex=cex)
mtext(side=3,line=line2,'Micromaps',cex=cex)

panelSelect(panels,11,1)
panelScale()
mtext(side=1,line=line3,'Below Median States',cex=cex)

# drawing the maps
for (i in 1:nGroups){
if(i==6){    #map not drawn, median state in adjacent panel
   panelSelect(panels,6,1)
   panelScale()
   panelFill(col=wgray)
   panelOutline(col="black")
   text(.5,.55,'Median',cex=cex)
   next
}
panelSelect(panels,i,1)
panelScale(rxpoly,rypoly)
gsubs = iBegin[i]:iEnd[i]
if(i==5)gsubs = c(gsubs,26)   #median state added here
if(i==7)gsubs = c(gsubs,26)   #median state added here
if(i < 6) cont = stateDataId[1:26] else cont = stateDataId[26:51]
          # cont means above or below median contour
panelNames = stateDataId[gsubs]

# plot background (out of contour) states in gray with white outlines 
back = is.na(match(stateVBorders$st,cont))
polygon(stateVBorders$x[back], stateVBorders$y[back],col=wgray,border=F) # 
polygon(stateVBorders$x[back], stateVBorders$y[back],col="white",density=0) # outline states

# plot foreground states for the panel in their special colors pens 1:5
# and other in contour states in light yellow pen 9
fore = !back
pen = match(polygonId,panelNames,nomatch=9)[!is.na(match(polygonId,cont))]
polygon(stateVBorders$x[fore], stateVBorders$y[fore],col=hdColors[pen],border=F) # outline states
polygon(stateVBorders$x[fore], stateVBorders$y[fore],col="black",density=0,lwd=1) # outline states

# outline U.S.
polygon(nationVBorders$x,nationVBorders$y,col="black",density=0,lwd=1) # outside boundary
}

##End

#8. Plot labels____________________________________________________________

##Run
# get full state names in rate order
ord = match(stateDataId,stateNamesFips$ab)   # match abbreviations  
stateNames = row.names(stateNamesFips)[ord]  # get the full state names except D.C.
cbind(stateDataId,stateNames)                # check that the matching has worked

# title column
panelSelect(panels,1,2)
panelScale()
mtext(side=3,line=line1,'',cex=cex)
mtext(side=3,line=line2,'States',cex=cex)

# draw state names
for (i in 1:nGroups){
   gsubs = iBegin[i]:iEnd[i]
   gnams = stateNames[gsubs]
   nsubs = length(gnams)
   pen = 1:nsubs
   laby = nsubs:1

   panelSelect(panels,i,2)
   panelScale(c(0,1),c(1-ypad,nsubs+ypad))
   if(i==6){pen = 6;panelFill(col=wgray);panelOutline()}
   for(j in 1:length(pen)){
      points(.1,laby[j],pch=16,col=hdColors[pen[j]],cex=dcex)
      points(.1,laby[j],pch=1,col="black",cex=dcex)	
      text(.18,laby[j]+nameShift,gnams[j],cex=cex,adj=0,col="black",font=font)
   }
}
##End

#9  Plot rates with confidence bounds___________________________________


##Run
# compute upper and lower confidence bounds
conf = qnorm(.95)     # 90% confidence interval
lower = stateUnemploy95$rate-conf*stateUnemploy95$rate.se
upper = stateUnemploy95$rate+conf*stateUnemploy95$rate.se

# find the range of the confidence bounds
rateRange = range(lower,upper)

# expand the range by 4%
rateRange = mean(rateRange) +1.06*diff(rateRange)*c(-.5,.5)
rateGrid = c(3,5,7,9)   # empirical determination

panelSelect(panels,1,3)
panelScale()
mtext(side=3,line=line1,'Ratio',cex=cex)
mtext(side=3,line=line2,'Unemployment',cex=cex)

for (i in 1:nGroups){
   gsubs = iBegin[i]:iEnd[i]
   nsubs = length(gsubs)
   pen = 1:nsubs
   laby = nsubs:1
   panelSelect(panels,i,3)
   panelScale(rateRange,c(1-ypad,nsubs+ypad))
   panelFill(col=wgray)
   panelGrid(x=rateGrid,col="white",lwd=1)
   panelGrid(x=5.6,col="black",lty=2)  # hard code U.S. average
   panelOutline(col="white")

   if(i==nGroups){axis(side=1,at=rateGrid,
             labels=as.character(rateGrid),
             col="black",mgp=c(1,0,0),tck=-.04,cex.axis=cex)
	     mtext(side=1,line=.7,'Percent',font=font,cex=cex)
   }
 
   if(i==6)pen = 6 
  lines(stateUnemploy95$rate[gsubs],laby,col="black",lwd=1)
   for(j in 1:length(pen)){
	   m = gsubs[j]
      lines(c(lower[m],upper[m]),rep(laby[j],2),lwd=2,col=hdColors[pen[j]])
      points(stateUnemploy95$rate[m],laby[j],pch=16,
         cex=dcex,col=hdColors[pen[j]])
      points(stateUnemploy95$rate[m],laby[j],pch=1,
         cex=dcex,col="black")
   }	   
}
##End

#10.   Plot counts___________________________________________________

## Run
countRange = range(stateUnemploy95$count)
countRange = mean(countRange)+1.10*diff(countRange)*c(-.5,.5)
countGrid = panelInbounds(countRange) # used pretty values that are in bounds

panelSelect(panels,1,4)
panelScale()
mtext(side=3,line=line1,'Number',cex=cex)
mtext(side=3,line=line2,'Unemployed',cex=cex)

for (i in 1:nGroups){
   gsubs = iBegin[i]:iEnd[i]
   nsubs = length(gsubs)
   pen = 1:nsubs
   laby = nsubs:1
   panelSelect(panels,i,4)
   panelScale(countRange,c(1-ypad,nsubs+ypad))
   panelFill(col=wgray)
   panelGrid(x=countGrid,col="white")
   panelOutline(col="white")
   if(i==nGroups){axis(side=1,at=countGrid,
         labels=as.character(countGrid),
         col="black",mgp=c(1,0,0),tck=-.04,cex.axis=cex)
	   mtext(side=1,line=.7,"100,000 People",cex=cex)
   }
   if(i==6)pen = 6
   lines(stateUnemploy95$count[gsubs],laby,col="black",lwd=1)
   for(j in 1:length(pen)){
       points(stateUnemploy95$count[gsubs[j]],laby[j],pch=16,
         cex=dcex,col=hdColors[pen[j]])
       points(stateUnemploy95$count[gsubs[j]],laby[j],pch=1,
         cex=dcex,col="black")
   } 
}
##End

#11 Add Title and Legend _____________________________________________

##Run
panelSelect(panels,margin='top')
panelScale()
text(.5,.9,'Labor Force Statistics By State, 1995 Average Values',
     cex=tCex)

panelSelect(panels,margin='bottom')
panelScale(inches=T)
xs = 2.8
ys = -.42
text(.01+xs,.70+ys,"U.S. Average",cex=cex,adj=0,font=1)
lines(c(.78,1.50)+xs,c(.70,.70)+ys,lty=2,col="black")
text(.01+xs,.53+ys,"90% Confidence Interval",cex=cex,adj=0,font=1)
lines(c(1.35,1.61)+xs,c(.53,.53)+ys,lwd=2,col=hdColors[1])
##End

#12 Outline groups of Panels________________________________________

##Run
for (i in 1:3){
for (j in 2:3){
   panelSelect(panelBlock,i,j)
   panelScale()
   panelOutline(col="black")
}}

panelSelect(panelBlock,2,1)
panelScale()
panelOutline(col="black")
##End
