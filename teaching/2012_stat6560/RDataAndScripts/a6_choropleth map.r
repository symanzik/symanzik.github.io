Assignment  a6_choropleth map
By          Daniel B. Carr

Topics:      1. Region boundary files		
             2. Polygons, color control,and map aspect ratio
             3. Function to expand the range of a vector
             4. Using match() to select boundaries for
                specific states
             5. Color fill and outlines example  
             6. Putting states into classes based on rates
             7. Producing approximate quintile classes
             8. Reordering class numbers and colors to be in 
                polygon plotting order using match()
             9. Define colors for the five classes and plot 
            10. Add a title and a legend
            11. Use locator() and to labels by Alaska,Hawaii and DC

Due:        The two state maps from 5
            The map resulting from 9, 10, and 11 combined

Assumes:    Uses the panelFunctions from week 2
            Uses boundaries and data from a6_linked micromaps
                 State and national borders
                 Unemployment data

1. Region boundary files

We use region boundaries obtained from files
in order to draw polygons representing regions.

For this example the boundaries are simplified
state boundaries adapted from the state
visibility maps of Mark Monmonier.

##Run
stateVBorders[1:12,]
##End

Boundaries may come in different formats
In this case the boundaries are in a data.frame
called stateVBorders

The columns are labeled st, x, and y,. 

The st column contains standard two-letter state
abbreviations with DC for the District of Columbia.  

The x and y vectors contain sequences of polygon
vertices separated by the missing data code, NA.  

There are two polygons for Michigan.  This
is not a problem.     

2.  The R polygon command

When the polygon(x,y,col=myColor) function
sees an NA in either or both of corresponding
elements in the x and y vectors, it knows
that the previous x and y elements were the
last vertex of a polygon.  

polygon() then closes the polygon by connecting
last vertex to the first vertex in the most recent
uninterrupted sequence of vertices.

Additional arguments and defaults in polygon() include
density=NULL and border=NULL, col=NA.
  
density = 0 indicate no color fill.
density = NULL means no shading lines are drawn.
         -1 and other negative values enable color fill.

For polygon borders, 
border=NULL uses the fg (foreground) color from par(). 
border = "blue"  will use blue for the border. 
border = NA will not draw the border

For color fill
col=NA    will prohibit color fill.  
col=myCol polygon() fills the polygon with a color determined
          by myColor[1] for the first polygon. The implicit
          subscript advances for each new polygon. If myCol
          only has one element that element is repeated as necessary. 
                                 
##Run plot the polygon outlines

windows()

# obtain the range of values for x and y
rx = range(stateVBorders$x,na.rm=T)   # note na.rm removes missing values
ry = range(stateVBorders$y,na.rm=T)

plot(rx,ry,type='n',axes=F,xlab='',ylab='')          # set up the scaling
polygon(stateVBorders$x,stateVBorders$y,density=0)   # draw the outline
##End

Map projection x and y units are often meant to imply physical distance
on the map up to common scale factor.  If so we can calculate the
width of the window for a given height that will lead to a plotting
region with the desired aspect ratio. The lattice package functions
has an argument aspect="iso" that will force the x and y scales to have
the same physical units per data unit. This option is included for
such situations.  

The aspect ratio is usually defined as the ratio of the width to the height.
For analog TV it is 4/3.  For digital TV it is 16/9.  Some projectors may
support both. These two aspect ratios bracket the gold ratio (1+sqrt(5))/2
which appears commonly in nature and artistic design   

There are many instances in this class when I am not particular about
map aspect ratios or the selection of map projection. If the map or 
map caricature meets the basic communication object, it is good enough. 
However be warned that in cartography and geography communities the failure
to pay attention the choice of map projection and aspect ratio is a sign
of ignorance.  Further people that care can often spot flawed maps
at a glance.

There are times when I do care. Some contexts call for equal area maps.
If points on a map are to convey density (we don't assess density well
in the best of circumstances)it helps if the points don't overplot
and if earth surface area per square units in the plot is the same for all
locations in the plot.  I am continually distressed by NASA's equal
angle grid plots for the globe. Some statistics plots also call for
equal units in the x and y directions. I will like comment on the
Fiji earth quake example in other assignments.  This became
a redesign project last year.  

   

if rx and ry give our plot limits in data units then we want

diff(rx)/diff(ry) = (width-xSpace)/(height-ySpace)

were xSpace and ySpace are margins, borders, and reserved window
ares. For R graphics windows makes use of about.5 inches at the top
of the window. 

## Run

height=7
ySpace = 1 + .5   # margin total + top window space
xSpace = 1
width= diff(rx)*(height-ySpace)/diff(ry) + xSpace
windows(width=width,height=height)
par(mai=c(.5,.5,.5,.5))
plot(rx,ry,type='n',axes=F,xlab='',ylab='')  # set up the scaling
polygon(stateVBorders$x,stateVBorders$y,density=0)     # draw the outline

##End

This look a lot closer to what Mark Monmonier intended.  
See for example "Mapping It Out" 1993, p238.  
He also plots the two letter designations for Alaska
Hawaii, and the District of Columbia by those polygons.
This clarifies the intended meaning.     


3.  A function to find and expand the range of a vector

##Run
extendScale = function(x,f=1.05){
	 rx = range(x,na.rm=T)
    return(mean(rx) + f*diff(rx)*c(-.5,.5))
} 
##End

##Run
x = rnorm(100)
range(x)
extendScale(x,f=1.04)
##End

4. Using match() to find subsets in vectors  

##Run
select = c('VA','NC','MD','SC')
bad = is.na(match(stateVBorders$st,select))
good = !bad    # ! means not
                 # the two lines can be combined 
x = stateVBorders$x[good]
y = stateVBorders$y[good]
st = stateVBorders$st[good]

# obtain the range of values for x and y
rx = extendScale(range(x,na.rm=T))   # note removing the missing values
ry = extendScale(range(y,na.rm=T))

plot(rx,ry,type='n',axes=F,xlab='',ylab='')  # set up the scaling
polygon(x,y,col="skyblue")     # draw the outline
##End


Both arguments to match() are vectors.  
For each element in the first vector
match() returns the position of first element from the
        second vector that is a match.
        By default match() returns NA if there is no match.

The vector returned is the length of first argument 
In the above example the vector returned is the length
of stateVBorders$st. 

It has NA when the state ID is not in the list of selected states   

5. Plot the four states using different
   color fills and different color outlines 

##Run
colorFill=c('red','white','blue','purple')
colorOutline = c('black','gray','sky blue','violet')

plot(rx,ry,type='n',axes=T,xlab='',ylab='')
polygon(x,y,col=colorFill,border=colorOutline,lwd=4) 
##End

Note the overplotting of the thicker lines.  


There is control to draw the color fill and outlines separately 
polygon(x,y,col=colorFill,border=NA)  #fill
polygon(x,y,density=0,border=TRUE,lwd=4,col=colorOutline) # outline

  
6. Putting states into classes based on rates  

The classed choropleth map put regions into different
classes based on region values.  It assigns the polygon
fill colors to the regions based on their class membership.

Historically many methods were proposed for putting
regions into different classes.  The cognitive research
of Brewer and Pickle based on three different map reading
tasks provide a ranking of several methods. Some of the established
methods in the cartography community, such as looking for
natural breaks in the data, did not fare so well.  The two
preferred methods were based on quartiles and quintiles.  
The slight edge when to quintile classes.  Quintile classes
have about 20% of the regions in each class.  

There still may be instances where other methods have merit, 
but in this fairly conventional class choropleth map setting
we will proceed with quintiles.  

7. An example of producing approximate quintile classes

First we need data.  We use the stateUnempoly95 data from a previous
assigment.  If you need to read it again put the comma delimited
file in your working directory and  

##Run  
stateUnemploy95 = read.csv('stateUnemployment95.csv',row.names=1,header=T)
names(stateUnemploy95) # [1] "rate"  "count"  "etpr" "lfpr" and standard errors
##End

We will map the unemployment rates.  
	
The script below illtrates use of quantile(), cut() and match()
functions to define classes from a the rate vector and to align
the class integers in polygon plotting order.  

First we get class boundaries or breaks using the quantile function.

##Run
classBreaks = quantile(stateUnemploy95$rate,seq(0,1,by=.2),type=5)
classBreaks	  # Boundaries for quintile classes
##End

In our class we use (i-.5)/n for cumulative to probabilities to go with
the sorted values or quantiles.  The third quantile argument, type=5, 
does this.

We interpolate quantiles for cumulative probabilities c(0,.2,.4,.6,.8,1.0)
We could use this vector as the second argument, but have used seq(0,1,by=.2)
as another way to produce the same vector.  

Our previous interpolation approach would need to be modified to 
include the min and max values as they involve "extrapolation." 

##Run    
classBreaks2 = approx(ppoints(stateUnemploy95$rate),sort(stateUnemploy95$rate),
                      seq(0,1,by=.2))$y
classBreaks2             
##End


The cut() function will determine the class membership for each rate.
Rate are compared with interval boundaries call breaks listed in
ascending order.

By default the intervals are open on the left and closed on the right.
A region whose rate ties with the left boundary the second
   interval receives a index value of 1.
A regions whose rate is within the second interval receives
   and index value of 2 
A region whose rate ties with the right boundary the second
interval receives a index value of 2. 

Regions with rates falling on the lowest bound of the first interval
receive and index value of NA.  The lower bound of the first
interval can be treated as closed using the argument
include.lowest=T, 
This is often desired with the breaks are defined using
the range of the data.  For example
breaks = seq(min(x),max(x),length=6)

 
## Run
classNumbers = cut(stateUnemploy95$rate,breaks=classBreaks,
                    include.lowest=T)  
table(classNumbers)
classNumbers = as.numeric(classNumbers)
classNumbers
##End

We note the unequal numbers in the 3rd and 4th classes. This is due to
several ties in the rates, that had been rounded to one decimal place.
The default object returned by cut is a factor.  We use as.numeric()
to drop the factor labeling as we just need the integers. From the
values we immediately guess that states were already sorted in
descending rate order.


8. Reordering class numbers and colors to be in 
   polygon plotting order using match() 

When we plot the polygons in a classed choropleth map,
we need to use the color numbers derived from the
region class memberships. 

We obtain the region ids for the polygon, and match these against
the region ids for the classNumbers. This yields subscripts 
to put the classNumbers in polygon plotting order!    

##Run
regionPolyId = stateVBorders$st[is.na(stateVBorders$x)]
classNumberId = row.names(stateUnemploy95)
subs = match(regionPolyId,classNumberId)

colorNumbers = classNumbers[subs]
colorNumbers
##End


9. Define colors for the five classes and produce the plot

myColors = c("#4060FF","#A0D0FF","#D0D0D0","#FFC080","#FF8000")

# Find plot scale range__________________________

rx = extendScale(stateVBorders$x)       
ry = extendScale(stateVBorders$y)

#plot
windows(width=10,height=7.5)
plot(rx,ry,type='n',axes=F,xlab='',ylab='')
polygon(stateVBorders$x,stateVBorders$y,col=myColors[colorNumbers],border=F)

# add a black outline, (sometimes gray outlines are better)
polygon(stateVBorders$x,stateVBorders$y,col="black",density=0,border=T)

##End

10. Add a title and legend  

Choropleth maps are a bit hard to interpret without
a title and legend.  

The title is easy.  

The legend is more complicated. I developed a legend
function to help with my mapping applications.  

It can be instructive to see a legend developed from scratch
as below.  Notice the strategy of using coordinates
relative to things on the screen. This facilitates hand
placement. 

The convention is that the high values go on top.  When
the high values are mortality rates I am inclined to
choose red for the hue on top.  There may be better
choice.  Feel free to change the colors above, but
please use a double-ended scale. 

The legend text presupposes a character size. 

Your may want to change the size. 
The character expansion for size, cex, is defined
at the top of the legend label section.

This appears as variable in the subsequent code.
Thus changing cex one place changes in all 
subsequent text commands.  

Cex could become a parameter in a legend function.
Additional recurrently-used values of the legend can be
pulled out and used as a parameters if one is
developing a function for reuse.       

##Run
#_______________________title__________________________

# locate the title relative to map coordinates
# centered on x, a fraction of the y range above the maximum y
#	centered, enlarged, bold font

tx = mean(rx)
ty = max(ry)+ .015*diff(ry)  
text(tx,ty,"Unemployment Rate For 1995",adj=.5,cex=1.7)


# ____________Legend Color boxes _______________________

l.n = 5   	# number of classes
l.minx = 135	# x location for legend
l.maxx = 139	
l.miny =  1    # y location for legend
l.maxy = 26.5 

l.bndy = seq(l.miny,l.maxy,length=6)-.5  #cell y boundaries
l.px = rep(c(l.minx,l.maxx,l.maxx,l.minx,NA),l.n)
l.py = rep(l.bndy,c(2,rep(5,l.n-1),3)) # the NAs are handle by l.px
polygon(l.px,l.py-1,col=myColors)
polygon(l.px,l.py-1,col="black",density=0)

# ____________________Legend labels______________________

cex = .90
cnt = table(classNumbers)
percent = round(100*cnt/sum(cnt)) 
l.laby = l.bndy[-(l.n+1)] + .4 * diff(l.bndy)
dx = l.maxx-l.minx
l.labx1 = l.minx - 4*dx
l.labx2 = l.minx - .4*dx
l.labx3 = l.maxx + .4*dx

brks = round(classBreaks,1)
text(l.labx2,l.bndy-.1*diff(l.bndy[1:2]),format(brks),adj=1,cex=cex)
#text(l.labx2,l.laby,format(brks[-1]),adj=1,cex=cex)
text(l.labx3,l.laby,format(round(percent)),adj=0,cex=cex)

dy = l.maxy-l.miny
text((l.maxx+l.minx)/2,l.miny-.2*dy,'Rate per 100,000',adj=.5,cex=cex)
text((l.minx+l.maxx)/2,l.maxy+.30*dy,'Class',adj=.5,cex=cex)
text(l.minx-1.6*dx,l.maxy+.15*dy,'Breaks',adj=.5,cex=cex)
text(l.maxx+1.9*dx,l.maxy+.15*dy,'Percents',adj=.5,cex=cex)

##End 

11.  Use locator() to add labels by Alaska,Hawaii and DC

The locator function below expects you to move your mouse
of the map and "+" will appear.  It expects you to click to the right
or below the polygons for Alaska, Hawaii, and DC in that order.
The abbreviation will appear soon after each click. There may
be a little pause.       

## Run
for (i in 1:3){
  coords = locator(1)
  text(coords$x,coords$y,c('AK','HI','DC')[i],adj=0,cex=cex)
}
## End
     
