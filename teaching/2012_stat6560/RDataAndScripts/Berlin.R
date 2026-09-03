year = c(1897, 1900, 1904, 1907, 1914, 1919, 1921, 1924, 1927)
count = c(16, 24, 29.9, 39.7, 75, 40.7, 117.7, 162, 206)

plot(year, count, 
  type = "l",
  main = "Women in the Deutsche Turnerschaft",
  xlim = c(1895, 1930),
  ylim = c(0, 210),
  xlab = "Year",
  ylab = "Number (in Thousand)"
)

points(year, count, pch = 19)

# World War I: 1914 - 1918

lines(c(1914, 1918), c(0, 0),
  col = "red",
  lwd = 3.0,
)

text(1916, 10.0, 
  "WWI",
  col = "red",
  cex = 0.8
)

