# Version 1: Data from photo only

year = c(1920, 1972, 1986, 1997)
visits = c(0.05, 1.0, 2.0, 2.5)

plot(year, visits, 
  type = "l",
  main = "Annual Visitation of Zion NP",
  xlab = "Year",
  ylab = "Visitors (in Million)"
)

points(year, visits, pch = 19)



# Version 2: Data from photo and from Web

year = c(1920, 1972, 1986, #1997)
  1994:2008)
visits = c(0.05, 1.0, 2.0, #2.5)
  2.286651,
  2.442062,
  2.519901,
  2.467234,
  2.387714,
  2.471564,
  2.454248,
  2.249389,
  2.614735,
  2.480690,
  2.699241,
  2.608564,
  2.589250,
  2.697182,
  2.647508 / 11 * 12
)

# additional values for 1994 - 2008 (11 months only) from
# http://www.nps.gov/zion/parkmgmt/park-visitation-statistics.htm
# acquired on 1/8/2009

plot(year, visits, 
  type = "l",
  main = "Annual Visitation of Zion NP",
  sub = "(1994-2008 data from http://www.nps.gov/zion/parkmgmt/park-visitation-statistics.htm)",
  font.sub = 1,
  cex.sub = 0.6,
  xlab = "Year",
  ylab = "Visitors (in Million)"
)

points(year, visits, pch = 19)
points(year[year==2008], visits[year==2008], pch = 19, col = "red")

text(2008, 0.05, 
  "2008: estimate (based on first 11 months)", 
  pos = 2,
  col ="red",
  cex = 0.6
)


