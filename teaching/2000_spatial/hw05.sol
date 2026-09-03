Stat 5810, Homework #5 - Solutions
----------------------------------


1) Solutions to 1 + 2 + 3 + ... + n:

### Here are the basic functions:

sumfor _ function (n = 1)
{
  value _ 0

  for (i in 1:n)
    value _ value + i

  return(value)
}


sumwhile _ function (n = 1)
{
  value _ 0
  i _ 1

  while (i <= n)
  {
    value _ value + i
    i _ i + 1
  }

  return(value)
}


sumrepeat _ function (n = 1)
{
  value _ 0
  i _ 1

  repeat
  {
    value _ value + i
    i _ i + 1
    if (i > n) break
  }

  return(value)
}


### Now the testing

> sumfor(1)
[1] 1
> sumwhile(1)
[1] 1
> sumrepeat(1)
[1] 1
> sumfor(2)
[1] 3
> sumwhile(2)
[1] 3
> sumrepeat(2)
[1] 3
> sumfor(3)
[1] 6
> sumwhile(3)
[1] 6
> sumrepeat(3) 
[1] 6
> sumfor(6)
[1] 21
> sumwhile(6)
[1] 21
> sumrepeat(6)
[1] 21
> sumfor(10)
[1] 55
> sumwhile(10)
[1] 55
> sumrepeat(10)
[1] 55


### Note that we can also do the following

> testdata _ as.list (c(1, 2, 3, 6, 10))
> lapply (testdata, sumfor)
[[1]]:
[1] 1

[[2]]:
[1] 3

[[3]]:
[1] 6

[[4]]:
[1] 21

[[5]]:
[1] 55


### We get the same results for
lapply (testdata, sumwhile)
lapply (testdata, sumrepeat)


### Now lets make testfor fool proof

sumforfoolproof _ function (n = 1)
{
  if (! is.integer(n))
  {
    cat ("Input not of type integer.", fill = T)
    return (F)
  }

  if (n < 1)
  {
    cat ("Input must be >=1.", fill = T)
    return (F)
  }

  value _ 0

  for (i in 1:n)
    value _ value + i

  return(value)
}


### And here the result:

> sumforfoolproof(0)
Input must be >=1.
[1] F
> sumforfoolproof(-5)
Input must be >=1.
[1] F
> sumforfoolproof(12.5)
Input not of type integer.
[1] F

> sumforfoolproof(1)
[1] 1
> sumforfoolproof(10)
[1] 55


### Is this really fool proof? Try

> sumforfoolproof (6:10)
[1] 21
Warning messages:
1: Condition has 5 elements: only the first used in: if(n < 1) { ....
2: Numerical expression has 5 elements: only the first used in: 1:n

> sumforfoolproof (matrix(6:9, 2, 2))
[1] 21
Warning messages:
1: Condition has 4 elements: only the first used in: if(n < 1) { ....
2: Numerical expression has 4 elements: only the first used in: 1:n

> sumforfoolproof ("TEXT")
Input not of type integer.
[1] F


### So we get some warnings for a vector and a matrix but no
### fatal error. This should be good enough for our needs...


=============================================================================


2) Summation until close proximity to pi^2 / 6:

sumpi6 _ function (delta = 0.01)
{
  n _ 1
  value _ 0

  while (value < pi^2 / 6 - delta)
  {
    value _ value + 1 / n^2
    n _ n + 1
  }

  return (n - 1)
  # note that we increased n in the loop even though 
  # value already > pi^2 / 6 - delta --- so have
  # to subtract 1 from n
}

### Test data:

delta1 _ pi - 3
delta2 _ 0.01
delta3 _ 0.001
delta4 _ 0.0001
delta5 _ 0.00001

> sumpi6 (delta1)
[1] 7

### manually check this result:

> pi^2/6 - pi + 3
[1] 1.503341
> sum(1 / (1:7)^2)
[1] 1.511797
> sum(1 / (1:6)^2)
[1] 1.491389

### yes, that's correct!

> sumpi6 (delta2)
[1] 100
> sumpi6 (delta3)
[1] 1000
> sumpi6 (delta4)
[1] 10000
> sumpi6 (delta5)
^CInterrupt 
Use traceback() to see the call stack

### Did you get an answer for the last one?
### I kept it running for several minutes,
### but due to internal rounding, it does not
### appear to get this close to pi^2 / 6.

=============================================================================


3) Test for prime numbers:

primebasic _ function (n = 1)
{
  if (n == 1)
  {
    cat ("There are no prime numbers between 1 and 1.", fill = T)
    return (F)
  }

  if (n == 2)
  {
    cat ("The only prime number between 1 and 2 is 2.", fill = T)
    return (2)
  }

  cat ("Prime number between 1 and ", n, " are:", fill = T)
  cat (2, fill = T)
  primes _ 2

  for (i in 3:n)
  {
    # can we devide i by any number in the range 2 to i-1 ?
    # if so, then i is not a prime number, if not then i 
    # is a prime number

    if (all (i %% 2:(i-1) != 0))
    {
      cat (i, fill = T)
      primes _ c(primes, i)
    }
  }

  return(primes)
}


### Now the testing

> ptest _ primebasic(1)
There are no prime numbers between 1 and 1.
> ptest _ primebasic(2)
The only prime number between 1 and 2 is 2.
> ptest _ primebasic(3)
Prime number between 1 and  3  are:
2
3
> ptest _ primebasic(4)
Prime number between 1 and  4  are:
2
3
> ptest _ primebasic(10)
Prime number between 1 and  10  are:
2
3
5
7
> ptest _ primebasic(100)
Prime number between 1 and  100  are:
2
3
5
7
11
13
17
19
23
29
31
37
41
43
47
53
59
61
67
71
73
79
83
89
97
> ptest
 [1]  2  3  5  7 11 13 17 19 23 29 31 37 41 43 47 53 59 61 67 71 73 79 83 89 97


primefast _ function (n = 1)
{
  if (n == 1)
  {
    cat ("There are no prime numbers between 1 and 1.", fill = T)
    return (F)
  }

  if (n == 2)
  {
    cat ("The only prime number between 1 and 2 is 2.", fill = T)
    return (2)
  }

  cat ("Prime number between 1 and ", n, " are:", fill = T)
  cat (2, fill = T)
  cat (3, fill = T)
  primes _ c (2, 3)

  # note that we handle 3 immediately as a prime - the loop
  # below does not recognize it as a prime! 

  # only check odd numbers between 3 and n 

  for (i in seq(3, n, by = 2))
  {
    # can we devide i by any odd number in the range 3 to sqrt(i) ?
    # if so, then i is not a prime number, if not then i 
    # is a prime number
    # note that we do not need to check whether i can be devided by 2
    # since we already excluded even numbers i from the loop

    if (all (i %% seq(3, ifelse(i < 9, 3, sqrt(i)), by = 2) != 0))
    # note that seq(3, x, by = 2) produces an error if x < 3 --
    # so we must check that x is at least 3
    {
      cat (i, fill = T)
      primes _ c(primes, i)
    }
  }

  return(primes)
}


### Now the testing


> ptest _ primefast(1)
There are no prime numbers between 1 and 1.
> ptest _ primefast(2)
The only prime number between 1 and 2 is 2.
> ptest _ primefast(3)
Prime number between 1 and  3  are:
2
3
> ptest _ primefast(4)
Prime number between 1 and  4  are:
2
3
> ptest _ primefast(5)
Prime number between 1 and  5  are:
2
3
5
> ptest _ primefast(10)
Prime number between 1 and  10  are:
2
3
5
7
> ptest _ primefast(100)
Prime number between 1 and  100  are:
2
3
5
7
11
13
17
19
23
29
31
37
41
43
47
53
59
61
67
71
73
79
83
89
97
> ptest
 [1]  2  3  5  7 11 13 17 19 23 29 31 37 41 43 47 53 59 61 67 71 73 79 83 89 97



