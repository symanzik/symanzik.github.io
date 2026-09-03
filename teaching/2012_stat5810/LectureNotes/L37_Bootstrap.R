# L37: Bootstrap

bs = function(x, j = 100){
  return(replicate(j, mean(sample(x, length(x), replace = TRUE))))
}

# 1st Hypothetical sample of 10 student heights out of 70
heights = c(66, 68, 62, 69, 65, 62, 70, 75, 63, 61)
hist(heights)

bsoutput = bs(heights, j = 100)
hist(bsoutput, main = "Bootstrap Distribution of Sample Average",
     xlab = "Average Height")
abline(v = mean(heights), col = "red")
quantile(bsoutput, c(0.05, 0.5, 0.95))
print(c(mean(heights) - qt(0.95, length(heights)) * sd(heights) / sqrt(length(heights)),
        mean(heights) + qt(0.95, length(heights)) * sd(heights) / sqrt(length(heights))))


# 2nd Hypothetical sample of 10 student heights out of 70
heights2 = c(55, 54, 59, 56, 58, 76, 70, 79, 73, 71)
hist(heights2)

bsoutput = bs(heights2, j = 100)
hist(bsoutput, main = "Bootstrap Distribution of Sample Average",
     xlab = "Average Height")
abline(v = mean(heights2), col = "red")
quantile(bsoutput, c(0.05, 0.5, 0.95))
print(c(mean(heights2) - qt(0.95, length(heights2)) * sd(heights2) / sqrt(length(heights2)),
        mean(heights2) + qt(0.95, length(heights2)) * sd(heights2) / sqrt(length(heights2))))


# 3rd Hypothetical sample of 10 student heights out of 70
heights3 = heights
heights3[10] = 40
hist(heights3)

bsoutput = bs(heights3, j = 100)
hist(bsoutput, main = "Bootstrap Distribution of Sample Average",
     xlab = "Average Height")
abline(v = mean(heights3), col = "red")
quantile(bsoutput, c(0.05, 0.5, 0.95))
print(c(mean(heights3) - qt(0.95, length(heights3)) * sd(heights3) / sqrt(length(heights3)),
        mean(heights3) + qt(0.95, length(heights3)) * sd(heights3) / sqrt(length(heights3))))


