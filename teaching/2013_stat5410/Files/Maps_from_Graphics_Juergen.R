# Code chunks from STAT 6560, Graphical Methods, Fall 2012
# Used for basic mapping functionality
#
# Updated 9/8/2013
# Juergen Symanzik


# Example 1:
#
# Basic geographic maps, ranging from a world map to detailed county maps 
# with labels and city names.

library(maps)

map() # World (default)
map("state") # US
map("state", c("Utah", "Colorado", "Idaho", "Wyoming", "Montana"))

data(state)
state.name
state.region
state.region == "Northeast"
state.name[state.region == "Northeast"]

map("state", state.name[state.region == "Northeast"])

map("state")
map.axes() # add latitude (North/South) and longitude (East/West)

map("county") # US counties

map("county", "Utah") # Utah counties

map.text("state") # too many labels
map.text("state", state.name[state.region == "South"])

map("county", "Utah")
map.cities() # too many labels

map("county", "Utah", xlim = c(-113,-111), ylim = c(40,41))
map.cities()
map.axes()

points(c(-112.5, -111.5), c(40.2, 40.8), pch = c(17, 20), col = "red", cex = 1.5)
## fill in two additional points

map("state", state.name[state.region == "Northeast"], fill = T, col = 0:8)

library(RColorBrewer)
map("state", state.name[state.region == "Northeast"], fill = T,
    col = brewer.pal(9, "Set3"))

map("state", fill = T, col = brewer.pal(9, "Set3"))

map("state", fill = T, col = brewer.pal(5, "Blues"))


# Example 2:
#
# Choropleth maps.

library(maps)

data(state)

colnames(state.x77)
murder <- state.x77[, 5]
range(murder)
breaks <- c(1, 4, 7, 10, 13, 16)
m.class <- cut(murder, breaks)
?cut
m.class

library(RColorBrewer)

brewer.pal(5, "Blues")
m.col <- brewer.pal(5, "Blues")[m.class]
m.col

map.m.col <- m.col[match.map("state", state.name)]
map("state", fill = T, col = map.m.col)
legend("bottomright", legend = levels(m.class), fill = brewer.pal(5, "Blues"))

dev.off()

# Example 3:
#
# Google map of Washington, D.C., as background.

library(RgoogleMaps)
library(PBSmapping)
library(maptools)

shpFile <- paste(system.file(package = "RgoogleMaps"), "/shapes/bg11_d00.shp", sep = "")
shp <- importShapefile(shpFile, projection = "LL")
bb <- qbbox(lat = shp[, "Y"], lon = shp[, "X"])
bb
MyMap <- GetMap.bbox(bb$lonR, bb$latR, destfile = "DC.jpg")
names(MyMap)

PlotPolysOnStaticMap(MyMap, shp, lwd = .5, col = rgb(0.25, 0.25, 0.25, 0.025), add = F)

# add some random points to the map
x <- runif(100, -0.1, 0.1) + 38.8933115
y <- runif(100, -0.1, 0.1) - 77.0146475
PlotOnStaticMap(MyMap, x, y, FUN = points, col = "red", add = T)

dev.off()


# Example 4:
#
# Google satellite map of lower Manhattan, New York, NY.

library(RgoogleMaps)

bb <- qbbox(c(40.702147, 40.711614, 40.718217),c(-74.015794, -74.012318, -73.998284),
            TYPE = "all", margin = list(m = rep(5, 4), TYPE = c("perc", "abs")[1]))
MyMap <- GetMap.bbox(bb$lonR, bb$latR, destfile = "MyTile3.png", maptype = "satellite")

PlotOnStaticMap(MyMap)

dev.off()


# Example 5:
#
# Google street map of lower Manhattan, New York, NY.

library(RgoogleMaps)

bb <- qbbox(c(40.702147, 40.711614, 40.718217),c(-74.015794, -74.012318, -73.998284),
            TYPE = "all", margin = list(m = rep(5, 4), TYPE = c("perc", "abs")[1]))
MyMap <- GetMap.bbox(bb$lonR, bb$latR, destfile = "MyTile3.png")

PlotOnStaticMap(MyMap)

dev.off()


# Example 6:
#
# Google street map of Washington, D.C., with markers and lines.

library(RgoogleMaps)

#Define the markers:
mymarkers <- cbind.data.frame(lat = c(38.898648, 38.889112, 38.880940),
                              lon = c(-77.037692, -77.050273, -77.03660), 
                              size = c("small", "small", "small"),
                              col = c("blue", "green", "red"), 
                              char = c("", "", ""))

# get the bounding box:
bb <- qbbox(lat = mymarkers[, "lat"], lon = mymarkers[, "lon"])

# download the map:
MyMap <- GetMap.bbox(bb$lonR, bb$latR, destfile = "DC.png", GRAYSCALE = T,
                     markers = mymarkers)

#determine the max zoom, so that all points fit on the plot
# (not necessary in this case):
#zoom <- min(MaxZoom(latrange = bb$latR, lonrange = bb$lonR))

# plot:
library(RColorBrewer)
pal <- brewer.pal(3, "Set2")

tmp <- PlotOnStaticMap(MyMap, lat = mymarkers[, "lat"], lon = mymarkers[, "lon"],
                       cex = 1.5, pch = 20, col = pal, add = F)
tmp <- PlotOnStaticMap(MyMap, lat = mymarkers[, "lat"], lon = mymarkers[, "lon"],
                       col = c("purple"), add = T, FUN = lines, lwd = 2)


