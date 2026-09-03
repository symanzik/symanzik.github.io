class = c(seq(0, 100, 10), 150, 200)
percent = c(8.64, 13.02, 12.59, 11.15, 9.47, 8.18, 7.11, 5.68, 4.65, 3.58, 9.89, 3.17)

# reconstruct some possible data from the provided percentages

values = NULL
for (i in 1:(length(class)-1))
  values = c(values, rep(class[i], (percent[i]*100)))


par(mfrow = c(1,2 ))


wikihist = hist(values, 
  breaks = class,
  right = FALSE,
  main = "Histogram of US Income Data (around 2005) [Not adjusted]",
  xlab = "Income in Thousand US Dollars",
  ylab = "Density (per Thousand US Dollars)",
  sub = sprintf("%.2f%% of incomes are above 200 Thousand US Dollars (not shown)", 100 - sum(percent)),
  cex.sub = 0.6
)


# adjust heights for data outside the plotting region

wikihist$density = wikihist$density * sum(percent) / 100
wikihist$intensities = wikihist$intensities * sum(percent) / 100

plot(wikihist, 
  main = "Histogram of US Income Data (around 2005) [Adjusted]",
  xlab = "Income in Thousand US Dollars",
  ylab = "Density (per Thousand US Dollars)",
  sub = sprintf("%.2f%% of incomes are above 200 Thousand US Dollars (not shown)", 100 - sum(percent)),
  cex.sub = 0.6
)


