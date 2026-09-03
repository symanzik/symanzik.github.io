# L30: XML (IMDB)

# http://www.imdb.com/chart/top
# Top 250 movies as voted by our users
# Accessed on 11/4/2012

# Load the XML library
library(XML)

# Call the htmlParse function, passing it the URL to the IMDB website
doc = htmlParse("http://www.imdb.com/chart/top")

# If this doesn't work for you, check the version of libxml installed on your computer.
# If it's older that 2.07 you will have problems
libxmlVersion()

#$major
#[1] "2"
#
#$minor
#[1] "07"
#
#$patch
#[1] "08"


# When we look at the HTML source, we see that the movies are in a <table>
# Let's try using readHTMLTable instead of htmlParse.
# If it works, then it will be easier for us, as it converts tables into dataframes.
tabs = readHTMLTable("http://www.imdb.com/chart/top")
length(tabs)
#[1] 3

# The function found two tables. 
# Let's check out the dimensions of each.
sapply(tabs, dim)
#     NULL NULL amazon-affiliates
#[1,]    1  251                 2
#[2,]    3    4                10

# The dimensions of the second one look like the one we are after.
# It has one more row than expected. Can you figure out why?
movieTab = tabs[[2]]
names(movieTab)
#[1] "V1" "V2" "V3" "V4"

head(movieTab)
#    V1     V2                                    V3      V4
#1 Rank Rating                                 Title   Votes
#2   1.    9.2       The Shawshank Redemption (1994) 852,221
#3   2.    9.2                  The Godfather (1972) 622,311
#4   3.    9.0         The Godfather: Part II (1974) 398,093
#5   4.    8.9                   Pulp Fiction (1994) 665,359
#6   5.    8.9 The Good, the Bad and the Ugly (1966) 262,349


# We see that the first row of this table should actually be the variable names.
# Let's redo the call to readHTMLTable, this time using some of the arguments to focus in on
# exactly what we want.
top250 = readHTMLTable("http://www.imdb.com/chart/top", 
                       which = 2, header = TRUE, 
                       colClasses = c("numeric", "numeric", "character", "numeric"))
#Warning message:
#In asMethod(object) : NAs introduced by coercion

# Here we use which = 2 to say that we want only the second table in the page
# We use header = TRUE to say that the first row of the table has variable names
# The colClasses argument is very handy. It allows us to specify the class of the variables/columns
# We want the first, second, and fourth columns to be converted to numeric vectors.


# Notice that we got a warning message about NAs introduced by coercion. 
# Let's take a look at the resulting data frame. 
head(top250)
#Rank Rating                                 Title Votes
#1    1    9.2       The Shawshank Redemption (1994)    NA
#2    2    9.2                  The Godfather (1972)    NA
#3    3    9.0         The Godfather: Part II (1974)    NA
#4    4    8.9                   Pulp Fiction (1994)    NA
#5    5    8.9 The Good, the Bad and the Ugly (1966)    NA
#6    6    8.9                   12 Angry Men (1957)    NA

# Because the Votes were in the thousands and commas were used to express these numbers,
# R isn't converting them properly.

# One way around this is to specify them as character and use regular expressions to eliminate the ,
# and then convert the result to numeric. 
top250 = readHTMLTable("http://www.imdb.com/chart/top", 
                       which = 2, header = TRUE, 
                       colClasses = c("numeric", "numeric", "character", "character"))
head(top250)  
#Rank Rating                                 Title   Votes
#1    1    9.2       The Shawshank Redemption (1994) 852,221
#2    2    9.2                  The Godfather (1972) 622,311
#3    3    9.0         The Godfather: Part II (1974) 398,093
#4    4    8.9                   Pulp Fiction (1994) 665,359
#5    5    8.9 The Good, the Bad and the Ugly (1966) 262,349
#6    6    8.9                   12 Angry Men (1957) 209,918

top250$VotesN = as.numeric(gsub(",", "", top250$Votes))
head(top250)
#Rank Rating                                 Title   Votes VotesN
#1    1    9.2       The Shawshank Redemption (1994) 852,221 852221
#2    2    9.2                  The Godfather (1972) 622,311 622311
#3    3    9.0         The Godfather: Part II (1974) 398,093 398093
#4    4    8.9                   Pulp Fiction (1994) 665,359 665359
#5    5    8.9 The Good, the Bad and the Ugly (1966) 262,349 262349
#6    6    8.9                   12 Angry Men (1957) 209,918 209918

# That worked nicely!

# Now let's try to extract the year from the title and create a new variable 
# with this information. 
# How about eliminating everything except digits from the title?
top250$Yr = as.numeric(gsub("[^[:digit:]]", "", top250$Title))
head(top250)

#Rank Rating                                 Title   Votes VotesN     Yr
#1    1    9.2       The Shawshank Redemption (1994) 852,221 852221   1994
#2    2    9.2                  The Godfather (1972) 622,311 622311   1972
#3    3    9.0         The Godfather: Part II (1974) 398,093 398093   1974
#4    4    8.9                   Pulp Fiction (1994) 665,359 665359   1994
#5    5    8.9 The Good, the Bad and the Ugly (1966) 262,349 262349   1966
#6    6    8.9                   12 Angry Men (1957) 209,918 209918 121957

# Take a look at movie number 6. What happened there?

# Our regular expression wasn't quite fine enough. Let's try instead to 
# eliminate everything but what's between the ().
x = gsub(".*(", "", top250$Title)

#Error in gsub(".*(", "", top250$Title) : 
#  invalid regular expression '.*(', reason 'Missing ')''

# Hmm, this is not working. Any idea why?


# The ( is a metacharacter and R is looking for the closing ).
# We need to escape it so that it is interpreted as a left parenthesis, not a metacharacter
x = gsub(".*\\(", "", top250$Title)
head(x)

#[1] "1994)" "1972)" "1974)" "1994)" "1966)" "1957)"
# That looks better.

# Now let's get rid of both sides with a nested gsub:
top250$Yr = as.numeric(gsub("\\).*$", "", gsub(".*\\(", "", top250$Title)))
#Warning message:
#  NAs introduced by coercion 

head(top250)

#Rank Rating                                 Title   Votes VotesN   Yr
#1    1    9.2       The Shawshank Redemption (1994) 852,221 852221 1994
#2    2    9.2                  The Godfather (1972) 622,311 622311 1972
#3    3    9.0         The Godfather: Part II (1974) 398,093 398093 1974
#4    4    8.9                   Pulp Fiction (1994) 665,359 665359 1994
#5    5    8.9 The Good, the Bad and the Ugly (1966) 262,349 262349 1966
#6    6    8.9                   12 Angry Men (1957) 209,918 209918 1957

# Yeah! that worked - almost...
which(is.na(top250$Yr))
#[1] 151 185
top250$Title[which(is.na(top250$Yr))]
#[1] "Warrior (2011/I)"    "The Artist (2011/I)"

# You hopefully got the idea and can resolve these yourself...
# So, don't be surprised to see the unexpected in your data -
# and always check your results for plausibility!


# OK, now that we have the year as a separate variable, let's eliminate it from the title.
top250$Title2 = gsub("[[:blank;]]+\\([[:digit:]]+\\)", "", top250$Title)

#Error in gsub("[[:blank;]]+\\([[:digit:]]+\\)", "", top250$Title) : 
#  invalid regular expression '[[:blank;]]+\([[:digit:]]+\)', reason 'Unknown character class name'
# What's the problem?
# [:blank;] should be [:blank:]

# Once we fix this mistake, we are good to go.
top250$Title2 = gsub("[[:blank:]]+\\([[:digit:]]+\\)", "", top250$Title)
head(top250)

#Rank Rating                                 Title   Votes VotesN   Yr
#1    1    9.2       The Shawshank Redemption (1994) 852,221 852221 1994
#2    2    9.2                  The Godfather (1972) 622,311 622311 1972
#3    3    9.0         The Godfather: Part II (1974) 398,093 398093 1974
#4    4    8.9                   Pulp Fiction (1994) 665,359 665359 1994
#5    5    8.9 The Good, the Bad and the Ugly (1966) 262,349 262349 1966
#6    6    8.9                   12 Angry Men (1957) 209,918 209918 1957
#Title2
#1       The Shawshank Redemption
#2                  The Godfather
#3         The Godfather: Part II
#4                   Pulp Fiction
#5 The Good, the Bad and the Ugly
#6                   12 Angry Men

# Notice that I put these new variables into Title2 and VotesN because
# I didn't want to wipe out the old version, if I made a mistake.
# Now that the work is done, I can drop the old versions
top250 = top250[, c("Rank", "Rating", "Title2", "VotesN", "Yr")]
head(top250)

#Rank Rating                         Title2 VotesN   Yr
#1    1    9.2       The Shawshank Redemption 852221 1994
#2    2    9.2                  The Godfather 622311 1972
#3    3    9.0         The Godfather: Part II 398093 1974
#4    4    8.9                   Pulp Fiction 665359 1994
#5    5    8.9 The Good, the Bad and the Ugly 262349 1966
#6    6    8.9                   12 Angry Men 209918 1957

# Let's rename the new variables.
names(top250)
#[1] "Rank"   "Rating" "Title2" "VotesN" "Yr"    

names(top250) = c("Rank", "Rating", "Title","Votes", "Yr")
tail(top250)

#Rank Rating         Title Votes   Yr
#245  245      8 The Searchers 40945 1956
#246  246      8 La Dolce Vita 27671 1960
#247  247      8     Rio Bravo 27560 1959
#248  248      8       Skyfall 48456 2012
#249  249      8      3 Idiots 47426 2009
#250  250      8     King Kong 49771 1933

# The data are ready.  

# Let's do some statistics!
hist(top250[, "Votes"], main = "Number of Votes", xlab = "Count")
which(top250[, "Votes"] > 8e5)
#[1] 1 8
top250[which(top250[, "Votes"] > 8e5), "Title"]
#[1] "The Shawshank Redemption" "The Dark Knight"         
hist(top250[, "Yr"], main = "Movies by Year", xlab = "Year")
plot(top250[, "Votes"], top250[, "Yr"], xlab = "Votes", ylab = "Year")

# We might want to add other fields, e.g. genre.
# Or collect more data....


