5) Function that tests whether a matrix is symmetric:

issymmetric _ function (x)
{
  # returns T if matrix is symmetric and F otherwise
  #
  # is x a matrix? - if not, then return F;
  # note that dim returns NULL for a scalar and a vector 
  # and this is not numeric
  #
  if (! is.numeric(dim(x)))
    F
    #
    # check the dimensionality
    #
  else if (nrow(x) == ncol(x))
    {
      #
      # is each x[i,j] = x[j,i] ?
      #
      all(x == t(x))
    }
    else
    {
      #
      # dimensions do not match, thus not symmetric
      #
      F
    }
}

And here the output and test runs (note where the comments
appear when printed within S-Plus):

> x0 _ 1
> x0
[1] 1
> x1 _ matrix(1:10, 2, 5)
> x1
     [,1] [,2] [,3] [,4] [,5] 
[1,]    1    3    5    7    9
[2,]    2    4    6    8   10
> x2 _ matrix(1:9, 3, 3)
> x2
     [,1] [,2] [,3] 
[1,]    1    4    7
[2,]    2    5    8
[3,]    3    6    9
> x3 _ matrix(c(1, 2, 3, 2, 2, 2, 3, 2, 3), 3, 3)
> x3
     [,1] [,2] [,3] 
[1,]    1    2    3
[2,]    2    2    2
[3,]    3    2    3

> issymmetric
function(x)
{
        #
        # check the dimensionality
        #
        # returns T if matrix is symmetric and F otherwise
        #
        # is x a matrix? - if not, then return F;
        # note that dim returns NULL for a scalar and a vector 
        # and this is not numeric
        #
        if(!is.numeric(dim(x))) F else if(nrow(x) == ncol(x)) {
                #
                # is each x[i,j] = x[j,i] ?
                #
                all(x == t(x))
        }
        else {
                #
                # dimensions do not match, thus not symmetric
                #
                F
        }
}

> issymmetric(x0)
[1] F
> issymmetric(x1)
[1] F
> issymmetric(x2)
[1] F
> issymmetric(x3)
[1] T

Note that this function immediately returns F if the input
is a scalar and a vector. (Theoretically, one might argue
that a scalar is symmetric, but it formally is not a 
symmetric matrix...)



