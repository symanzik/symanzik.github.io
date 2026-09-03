# plot a histogram where the red (R) component
# of the RGB colors varies linearly
#
# Juergen Symanzik
# 2/3/2009

# create some data

outcome = runif(1000, 0, 100)
classbreaks = seq(0, 100, by = 10)

# create sequential variation in red component of RGB colors

colorchanges = rgb(cbind(as.integer(seq(0, 255, length = 10)), # R
  rep(0, 10), # G
  rep(0, 10)), # B
max = 255)

colorchanges

# draw histogram

hist(outcome, breaks = classbreaks,
  xlab = "Uniform Random Numbers",
  ylab = "Counts",
  main = "Histogram of a U[0, 100] Distribution",
  col = colorchanges
)


