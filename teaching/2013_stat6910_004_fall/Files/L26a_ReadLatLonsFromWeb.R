# L26a: Read Latitutes and Longitudes from the Web
#
# First go to this web page; then look at the source and
# find the information where the data of interest are stored
#
# http://dev.maxmind.com/geoip/legacy/codes/average-latitude-and-longitude-for-countries/

# Load the XML library
library(XML)

# parse the HTML file containing the country lats and longs
latlon = htmlParse("http://dev.maxmind.com/geoip/legacy/codes/average-latitude-and-longitude-for-countries/")

# Extrac the root of the document, which should be <html>
llRoot = xmlRoot(latlon)

xmlName(llRoot)
#[1] "html"

# When we examined the source, we saw that the lats and longs were 
# in a <pre> node so let's find all <pre> nodes
pres = getNodeSet(llRoot, "//pre")

# Let's see how many there are in the document
length(pres)
#[1] 1

# So it looks like we have found our data
# It should be in the text content of this node
xmlValue(pres[[1]])
#[1] "\n\"iso 3166 country\",\"latitude\",\"longitude\"\nAD,42.5000,1.5000\nAE,24.0000,54.0000...

# We have one long character string with all of our data in it.
# Let's save it to a vector.
content = xmlValue(pres[[1]])

class(content)
#[1] "character"

length(content)
#[1] 1

# We know how to read plain text from a file, but how do we read it 
# from a character vector?
# We look at the documentation for read.table
?read.table
llDF = read.table(text = content)
#Error in scan(file, what, nmax, sep, dec, quote, skip, nlines, na.strings,  : 
#  line 2 did not have 2 elements

llDF = read.table(text = content, skip = 2)
head(llDF)
#                   V1
#1   AD,42.5000,1.5000
#2  AE,24.0000,54.0000
#3  AF,33.0000,65.0000
#4 AG,17.0500,-61.8000
#5 AI,18.2500,-63.1667
#6  AL,41.0000,20.0000

# This is not quite what we want.
# Read more about the other arguments (this is your task!)

# Eventually you should get
#
#head(llDF)
#  iso.3166.country latitude longitude
#1               AD    42.50    1.5000
#2               AE    24.00   54.0000
#3               AF    33.00   65.0000
#4               AG    17.05  -61.8000
#5               AI    18.25  -63.1667
#6               AL    41.00   20.0000

# And here is the code to do so:

llDF = read.table(text = content, skip = 1, sep = ",", header = TRUE)
head(llDF)

