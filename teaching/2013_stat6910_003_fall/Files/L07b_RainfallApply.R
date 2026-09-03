# L07b: Apply etc. - Rainfall

load(url("http://www.math.usu.edu/~symanzik/teaching/2013_stat6910_003_fall/Files/rainfallCO.rda"))


class(rain)

length(rain)

names(rain)


class(rain$st050183)

length(rain$st050183)

head(rain$st050183)


class(rain["st050183"])

length(rain["st050183"])


class(rain[[1]])

head(rain[[1]])


lapply(rain, mean)

sapply(rain, mean)

lapply(rain, mean, na.rm = TRUE,
       trim = 0.1)


sapply(rain, max)


sapply(rain, quantile, probs = 0.99)


all(sapply(rain, length) == sapply(day, length))


head(day[[1]])
Year = lapply(day, floor) 
head(Year[[1]])
Uyear = lapply(Year, unique)
head(Uyear[[1]])
OpYear = sapply(Uyear, length)
OpYear

length(unique(floor(day[[1]])))

sapply(day, function(x) length(unique(floor(x))))

sapply(rain, function(x) sum(x > 0) / length(x))



### Arrays & Apply

x = array(1:30, c(4, 3, 2))
x

y = array(1:10, 4:2)
y

z = array(1, 4:2)
z

zz = array(1:10, 2:4)
zz


###

y

apply(y, 1, sum)

apply(y, 2, sum)

apply(y, 3, sum)

