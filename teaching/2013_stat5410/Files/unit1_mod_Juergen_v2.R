# Code chunks from unit1_slides.pdf
# Used for Analysing Spatial Data in R: Representing Spatial Data
#
# Roger Bivand
#
# Updated 9/23/2013
# Juergen Symanzik


library(sp)


### Spatial Points

# load the original data

data(meuse)
class(meuse)
names(meuse)
head(meuse)
?meuse
head(meuse[, c("x", "y")])


# translate coords into a SpatialPoints object

coords = SpatialPoints(meuse[, c("x", "y")])
class(coords)
head(coords)
summary(coords)


# add original data and create a SpatialPointsDataFrame object

meuse1 = SpatialPointsDataFrame(coords, meuse)
class(meuse1)
names(meuse1)


# we can access components from this object as in a regular data frame -
# but it is a spatial data frame object !!

summary(meuse1$zinc)

stem(meuse1$zinc)
stem(meuse1$zinc, scale = 1/2)

meuse1[meuse1$zinc > 1500, c("zinc", "lead", "copper", "cadmium")]

meuse1[-(1:150), ]

summary(meuse1$landuse)
tapply(meuse1$zinc, meuse1$landuse, mean)


# accessing coordinates, bounding box & projection from a spatial data frame object

mcoord = coordinates(meuse1)
class(mcoord)
head(mcoord)
mcoord[meuse1$zinc > 1500, ]

mbbox = bbox(meuse1)
class(mbbox)
mbbox

mproj = proj4string(meuse1)
class(mproj)
mproj


# Teaser: Plotting a SpatialPoints object (from unit2_slides.pdf, p4)
#
# (more to come next week)


plot(as(meuse1, "Spatial"), axes = TRUE)
plot(meuse1, add = TRUE)
summary(meuse1$ffreq)
plot(meuse1[meuse1$ffreq == 1, ], col = "green", add = TRUE)



### Spatial Lines and Spatial Polygons

# read the data

data(meuse.riv)
class(meuse.riv)
str(meuse.riv)
head(meuse.riv)
plot(meuse.riv)
?meuse.riv


# create a SpatialPolygons object

river_polygon = Polygons(list(Polygon(meuse.riv)), ID = "meuse")
class(river_polygon)

rivers = SpatialPolygons(list(river_polygon))
class(rivers)
summary(rivers)
names(rivers)
slotNames(rivers)
bbox(rivers)
slot(rivers, "polygons")
class(slot(rivers, "polygons"))
slot(rivers, "polygons")[[1]]
slot(slot(rivers, "polygons")[[1]], "area")
slot(slot(rivers, "polygons")[[1]], "ID")


# create a SpatialLinesDataFrame object

library(maptools)

dim(volcano)
volcano[1:10, 1:10]
plot(volcano) # not what we had expected

heatmap(volcano, Rowv = NA, Colv = NA)

volcano_sl = ContourLines2SLDF(contourLines(volcano))
class(volcano_sl)
plot(volcano_sl) # this makes more sense!

slotNames(volcano_sl)
bbox(volcano_sl)
proj4string(volcano_sl)

row.names(slot(volcano_sl, "data"))

sapply(slot(volcano_sl, "lines"), function(x) slot(x, "ID"))

sapply(slot(volcano_sl, "lines"), function(x) length(slot(x, "Lines")))

volcano_sl$level


### Spatial Grids and Spatial Pixels

# creata a SpatialPixelsDataFrame object

data(meuse.grid)
class(meuse.grid)
names(meuse.grid)
head(meuse.grid)
?meuse.grid

coords = SpatialPixels(SpatialPoints(meuse.grid[, c("x", "y")]))

class(coords)

meuseg1 = SpatialPixelsDataFrame(coords, meuse.grid)

class(meuseg1)
names(meuseg1)

bbox(meuseg1)
head(meuseg1$soil, n = 100)

slotNames(meuseg1)
slot(meuseg1, "grid")
head(slot(meuseg1, "data"))
meuseg1$data # does not work

dim(slot(meuseg1, "data"))
object.size(meuseg1)


# creata a SpatialGridDataFrame object

meuseg2 = meuseg1
fullgrid(meuseg2) = TRUE

class(meuseg2)
names(meuseg2)
gridparameters(meuseg2)

bbox(meuseg2)
head(meuseg2$soil, n = 100)

slot(meuseg2, "grid")
class(slot(meuseg2, "grid"))

dim(slot(meuseg2, "data"))
object.size(meuseg2)


