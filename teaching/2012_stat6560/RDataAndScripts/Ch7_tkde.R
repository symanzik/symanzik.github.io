### tkde (three--dimensional kernel density estimation) function
### Written by Mike Minnotte

tkde <- function(x, y = NULL, z = NULL, hx = NULL, hy = NULL, hz = NULL,
	xlist = NULL, ylist = NULL, zlist = NULL, extend = .1, 
	nx = 20, ny = 20, nz = 20, adjust = c(1, 1, 1),
	xlab = NULL, ylab = NULL, zlab = NULL, ...)
{
data <- xyz.coords(x, y, z)
x <- data$x
y <- data$y
z <- data$z

n <- length(x)

if (is.null(hx)) hx <- bw.SJ(x, method = "dpi")
if (is.null(hy)) hy <- bw.SJ(y, method = "dpi")
if (is.null(hz)) hz <- bw.SJ(z, method = "dpi")

if (is.null(xlist) )
	{dx <- (max(x) - min(x)) * extend
	xlist <-seq(min(x) - dx, max(x) + dx, length = nx)}
else nx <- length(xlist)

if (is.null(ylist) )
	{dy <- (max(y) - min(y)) * extend
	ylist <-seq(min(y) - dy, max(y) + dy, length = ny)}
else ny <- length(ylist)

if (is.null(zlist) )
	{dz <- (max(z) - min(z)) * extend
	zlist <-seq(min(z) - dz, max(z) + dz, length = nz)}
else nz <- length(zlist)

f <- array(0, c(nx, ny, nz))

kx <- matrix(0, n, nx)
for (i in 1:nx) kx[, i] <- dnorm(x, xlist[i], hx * adjust[1])

ky <- matrix(0, n, ny)
for (j in 1:ny) ky[, j] <- dnorm(y, ylist[j], hy * adjust[2])

kz <- matrix(0, n, nz)
for (k in 1:nz) kz[, k] <- dnorm(z, zlist[k], hz * adjust[3])

for (i in 1:nx) for (j in 1:ny) for (k in 1:nz)
	f[i,j,k] <- mean(kx[, i] * ky[, j] * kz[, k])

maxf <- max(f)
levs <- maxf*c(.99, .9, .75, .5, .25, .1)

plot3d(x, y, z, type = "n")
contour3d(f, levs, xlist, ylist, zlist, 
	color=c("black", "red", "orange", "yellow", "cyan", "blue"),
	alpha=c(1, 1, .4, .4, .25, .15), add = T, ...)
#decorate3d()

invisible()
}

