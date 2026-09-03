# Example 1

rdata = runif(100)


for (i in 1:10)
{
  hist(rdata)
  Sys.sleep(0.4)

  plot(c(0,1), c(0,1), type = "n", 
    xlab = "", ylab = "", 
    axes = FALSE)
  Sys.sleep(0.2)

  hist(rdata,
    xlab = "mydata")
  Sys.sleep(0.4)

  plot(c(0,1), c(0,1), type = "n", 
    xlab = "", ylab = "", 
    axes = FALSE)
  Sys.sleep(0.2)
}

---------

# Example 2

rdata = runif(100)


for (i in 1:10)
{
  hist(rdata)
  Sys.sleep(0.4)

  plot(c(0,1), c(0,1), type = "n", 
    xlab = "", ylab = "", 
    axes = FALSE)
  Sys.sleep(0.2)

  hist(rdata + 1,
    xlab = "rdata",
    main = "Histogram or rdata")
  Sys.sleep(0.4)

  plot(c(0,1), c(0,1), type = "n", 
    xlab = "", ylab = "", 
    axes = FALSE)
  Sys.sleep(0.2)
}

