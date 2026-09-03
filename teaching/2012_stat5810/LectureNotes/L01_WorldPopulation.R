# World Population Growth Rate, 8/27/2012
#
# Based on Murrell, ItDT, Section 9.1 (p.204-212)

# Read in Census World Population Web Page,
# then extract the numerical value

clockHTML <-
  readLines("http://www.census.gov/main/www/popclock.html")
unlink("http://www.census.gov/main/www/popclock.html")

length(clockHTML)
clockHTML[1]
clockHTML[731]

popLineNum <- grep('id="wclocknum"', clockHTML)
popLineNum

popLine <- clockHTML[popLineNum]
popLine

popText <- gsub('<span id="wclocktext">World </span><span id="wclocknum">|</span><br />',
                "", popLine)
popText

pop <- as.numeric(gsub(",", 
                       "", popText))
pop

# wait 120 sec (2 min)

Sys.sleep(120)

# Read in Census World Population Web Page again,
# then extract the numerical value and calculate the growth rate

clockHTML2 <-
  readLines("http://www.census.gov/main/www/popclock.html")
unlink("http://www.census.gov/main/www/popclock.html")

popLineNum2 <- grep('id="wclocknum"', clockHTML2)
popLineNum2

popLine2 <- clockHTML2[popLineNum2]
popLine2

popText2 <- gsub('<span id="wclocktext">World </span><span id="wclocknum">|</span><br />',
                "", popLine2)
popText2

pop2 <- as.numeric(gsub(",", 
                       "", popText2))
pop2

rateEstimate <- (pop2 - pop) / 2
rateEstimate

