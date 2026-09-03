# L38: Leftovers

# Based on
#
# P. Murrell (2009), Introduction to Data Technologies, Chapman and Hall/CRC. 
#
# Note that the entire book is available online from 
#   http://www.stat.auckland.ac.nz/~paul/ItDT/
# under a Creative Commons licence.

### Dates in R

today = Sys.Date()
today
class(today)
format(today, "%d %b %Y")
format(today, "%d %B %Y")
format(today, "%B %d, %Y")

weekdays(today)
weekdays(today, abbreviate = TRUE)

months(today)
months(today, abbreviate = TRUE)

quarters(today)

date()

deadline = "2012-12-07"
class(deadline)

deadline2 = as.Date(deadline)
deadline2
class(deadline2)

# Difference between 2 dates

deadline2 - today

datediff = deadline2 - today
as.integer(datediff)

# Future dates

tenweeks = seq(today, length.out = 10, by = "1 week") # next ten weeks
tenweeks

fortydays = seq(today, length.out = 40, by = "1 day") # next 40 days
fortydays

whichdays = seq(today, length.out = 20, by = "2 day") # ???
whichdays


### Microsoft Excel xls Files (with Dates & Times)

library("xlsReadWrite")
#xls.getshlib()

ExcelName = "C://JUE//Teaching//Stat5810_Fa2012_IntroStatComputing_XXX//LectureNotes//TimeLog.xls"
ExcelData = read.xls(file = ExcelName, rowNames = FALSE)
ExcelData[1:11, ]

as.Date(ExcelData[1:11, 1], origin = "1900-01-01")

# We have to subtract 2 in this calculation because the Excel count starts from
# the 0th rather than the 1st of January and because Excel thinks that 1900
# was a leap year (apparently to be compatible with the Lotus 123 spreadsheet
# software). Sometimes, computer technology is not straightforward.

as.Date(ExcelData[1:11, 1] - 2, origin = "1900-01-01")

# Immediately adjust Dates and Times

ExcelData2 = read.xls(file = ExcelName, rowNames = FALSE, dateTime = "isotime")
ExcelData2[1:11, ]


### Combining Data

v1 = 1:3
v2 = 4:6

c(v1, v2)

cbind(v1, v2)

rbind(v1, v2)

rbind(cbind(v1, v2), 7:8)

start = NULL
for (i in 1:10)
  start = rbind(start, c(i, 2^i))
start

# or

start2 = cbind(1:10, 2^(1:10))
start2


### Formatting Output

ExcelTime = ExcelData2[1:11, 5]
ExcelTime

as.character(ExcelTime)

format(ExcelTime)
format(ExcelTime, digits = 2)
format(ExcelTime, digits = 3)

sprintf(fmt = "%6.2f hours", ExcelTime)
sprintf(fmt = "%3.1f [hours]", ExcelTime)

cat(sprintf(fmt = "%3.1f [hours]", ExcelTime), fill = 23)
cat(sprintf(fmt = "%3.1f [hours]", ExcelTime), fill = 24)
cat(sprintf(fmt = "%3.1f [hours]", ExcelTime), fill = 36)


### Creating an HTML Table

library("hwriter")

cat(hwrite(ExcelData2[1:11, ]))

cat(hwrite(sprintf(fmt = "%3.1f [hours]", ExcelTime)))

