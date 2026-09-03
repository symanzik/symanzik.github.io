# Code chunks from unit3_slides.pdf
# Used for Analysing Spatial Data in R: Accessing Spatial Data
#
# Roger Bivand
#
# Updated 9/30/2013
# Juergen Symanzik

### Using maps data: Illinois counties

library(maptools)
library(maps)

ill = map("county", regions = "illinois", plot = FALSE, fill = TRUE)
class(ill)
names(ill)
summary(ill)
sapply(ill, head)

IDs = sub("^illinois,", "", ill$names)
head(IDs)

ill_sp = map2SpatialPolygons(ill, IDs, CRS("+proj=longlat"))
class(ill_sp)
summary(ill_sp)
names(ill_sp)
slotNames(ill_sp)
bbox(ill_sp)
class(slot(ill_sp, "polygons"))
slot(ill_sp, "polygons")[[1]]
slot(slot(ill_sp, "polygons")[[1]], "area")
slot(slot(ill_sp, "polygons")[[1]], "ID")

plot(ill_sp, axes = TRUE)


### Comparing spatial coordinates

library(rgdal)

ED50 = CRS(paste("+init=epsg:4230", "+towgs84=-87,-96,-120,0,0,0,0"))
class(ED50)
ED50

IJ.east = as(char2dms("4d31'00\"E"), "numeric")
class(IJ.east)
IJ.east

IJ.north = as(char2dms("52d28'00\"N"), "numeric")
class(IJ.north)
IJ.north

IJ.ED50 = SpatialPoints(cbind(x = IJ.east, y = IJ.north), ED50)
class(IJ.ED50)
IJ.ED50

res = spTransform(IJ.ED50, CRS("+proj=longlat +datum=WGS84"))
class(res)
res

spDistsN1(coordinates(IJ.ED50), coordinates(res), longlat = TRUE) * 1000


### Meuse bank CRS

EPSG = make_EPSG()
?make_EPSG
class(EPSG)
names(EPSG)
head(EPSG, 6)

EPSG[grep("Utah", EPSG$note), 1:2]

EPSG[grep("Amersfoort", EPSG$note), 1:2] # for Meuse data set

RD_New = CRS("+init=epsg:28992")
class(RD_New)

res = CRSargs(RD_New)
class(res)
res
cat(strwrap(res), sep = "\n")

res2 = showWKT(CRSargs(RD_New), morphToESRI = FALSE)
class(res2)
res2
cat(strwrap(gsub(",", ", ", res2)), sep = "\n")

res3 = showWKT(CRSargs(RD_New), morphToESRI = TRUE)
class(res3)
res3
cat(strwrap(gsub(",", ", ", res3)), sep = "\n")


### Reading shapefiles: maptools

library(maptools)

shapePath = "C://Program Files//R//R-3.0.1//library//maptools//shapes//"

list.files(shapePath)

getinfo.shape(paste(shapePath, "baltim.shp", sep = ""))

getinfo.shape(paste(shapePath, "columbus.shp", sep = ""))

getinfo.shape(paste(shapePath, "pointZ.shp", sep = ""))

getinfo.shape(paste(shapePath, "sids.shp", sep = ""))

sids = readShapePoly(paste(shapePath, "sids", sep = ""))
class(sids)            
proj4string(sids)
plot(sids, axes = TRUE)

columbus = readShapePoly(paste(shapePath, "columbus", sep = ""))
class(columbus)            
proj4string(columbus)
plot(columbus, axes = TRUE)


### Reading vectors: rgdal

library(rgdal)

shapePath1 = "C://Program Files//R//R-3.0.1//library//maptools//shapes"

sids1 = readOGR(dsn = shapePath1, layer = "sids")
class(sids1)            
proj4string(sids1)
plot(sids1, axes = TRUE)

pointZ = readOGR(dsn = shapePath1, layer = "pointZ")
class(pointZ)            
proj4string(pointZ)
cat(strwrap(proj4string(pointZ)), sep = "\n")
plot(pointZ, axes = TRUE)


### Reading rasters: rgdal

library(rgdal)

shapePath2 = "C://Program Files//R//R-3.0.1//library//rgdal//pictures"

list.files(shapePath2)

getGDALDriverNames()$name

SP27GTIF = readGDAL(paste(shapePath2, "//SP27GTIF.TIF", sep = ""))
class(SP27GTIF)
summary(SP27GTIF)
plot(SP27GTIF) # not what we want
image(SP27GTIF, col = grey(1:99/100), axes = TRUE) # takes a while


### Read below how to read/write data from Garmin and other GPS devices
### 

# Package "pgirmess": Miscellaneous functions for analysis and display of 
# ecological and spatial data
#
# http://cran.r-project.org/web/packages/pgirmess/pgirmess.pdf


# Read and Display Data from GPS Devices Using R
#
# http://www.nceas.ucsb.edu/scicomp/usecases/ReadAndDisplayGPSData

