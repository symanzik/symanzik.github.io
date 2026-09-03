# L06a: Data Types, Vectors, And Subsets - Earthquakes

# Data file located at
#    http://www.consrv.ca.gov/cgs/rghm/quakes/Documents/ms49epicenters.txt

CAquakes = read.table(file = "http://www.consrv.ca.gov/cgs/rghm/quakes/Documents/ms49epicenters.txt",
                      header = TRUE)

dim(CAquakes)

CAquakes[1:3, ]

class(CAquakes)

class(CAquakes$Date)


# All information on earthquakes with magnitude > 7.0


CAquakes[CAquakes$M > 7.0, ]


# Magnitudes that are > 7.0


CAquakes$M[CAquakes$M > 7.0]

# or

CAquakes[CAquakes$M > 7.0, "M"]


# Number of earthquakes with magnitudes > 7.0


sum(CAquakes$M > 7.0)


# Location (lat, lon) of earthquakes with magnitudes > 7.0


CAquakes[CAquakes$M > 7.0, c("Latitude", "Longitude")]


# Do all reported earthquakes have a magnitude > 1.0 ?


all(CAquakes$M > 1.0)


# Is there any reported earthquake with magnitude >= 8.0 ?


any(CAquakes$M >= 8.0)


# Is there any reported earthquake with magnitude >= 7.9 ?


any(CAquakes$M >= 7.9)


# When did we encouter the earthquake(s) with the largest magnitude?


CAquakes$Date[CAquakes$M == max(CAquakes$M)]


# What are the 10 hightest reported magnitudes (with repeats)?


sort(CAquakes$M, decreasing = TRUE)[1:10]


# What are the 10 hightest reported magnitudes (without repeats)?


unique(sort(CAquakes$M, decreasing = TRUE))[1:10]


# What are the magnitudes of earthquakes reported from 1/1/1980 to 12/31/1989?


CAquakes$M[(CAquakes$Date >= 19800000) & (CAquakes$Date <= 19891231)]

