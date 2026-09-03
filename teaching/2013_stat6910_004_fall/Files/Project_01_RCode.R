myFactorial1 = function(n) {
  return(factorial(n))
}

myFactorial2 = function(n) {
  return(prod(1:n))
}

myFactorial3 = function(n) {
  if (n == 0) {
    return(1)
  } else {
    result = 1
    for (i in 1:n) {
      result = result * i
    }
    return(result)
  }
}

myFactorial4 = function(n) {
  if (n == 0) {
    return(1)
  } else {
    result = 1
    i = 1
    while (i <= n) {
      result = result * i
      i = i + 1
    }
    return(result)
  }
}

myFactorial5 = function(n) {
  if (n == 0) {
    return(1)
  } else {
    return(n * myFactorial5(n - 1))
  }
}

myFactorial6 = function(n) {
  if (n == 0) {
    return(1)
  } else {
    return(myFactorial6(n - 1) * n)
  }
}
