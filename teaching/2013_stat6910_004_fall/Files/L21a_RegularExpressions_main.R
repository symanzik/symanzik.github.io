# L21a: RegularExpressions

# Source these in to play with some regular expressions

cNames = c("Dewitt County", 
           "Lac qui Parle County", 
           "St John the Baptist Parish", 
           "Stone County")

test = cNames[3]

substring(test, 1, 2)
#[1] "St"

substring(test, 1, 2) == "St"
# [1] TRUE

newName = paste("St.", 
                substring(test, 3, nchar(test)), sep = "")
newName
# [1] "St. John the Baptist Parish"


# now try this

test = cNames[4]
substring(test, 1, 2) == "St"
newName = paste("St.", 
                substring(test, 3, nchar(test)), sep = "")
newName


# and this ...

string = "The Slippery St Frances"
substring(string, 1, 3) == "St "
newName = paste("St.", 
                substring(string, 4, nchar(string)), sep = "")
newName


substring(cNames, 1, 2) == "St"
#[1] FALSE FALSE  TRUE  TRUE

substring(cNames, 1, 3)
#[1] "Dew" "Lac" "St " "Sto"

substring(cNames, 1, 3) == "St "
# [1] FALSE FALSE  TRUE FALSE

newNames = cNames
whichRep = substring(cNames, 1, 3) == "St "
newNames[whichRep] = 
  paste("St. ", 
        substring(cNames[whichRep], 4, 
                  nchar(cNames[whichRep])), sep = "")
newNames
# [1] "Dewitt County"               "Lac qui Parle County"       
# [3] "St. John the Baptist Parish" "Stone County"

unlist(strsplit(string, " "))
#[1] "The"      "Slippery" "St"       "Frances"

unlist(strsplit(string, ""))
#[1] "T" "h" "e" " " "S" "l" "i" "p" "p" "e" "r" "y" " " "S" "t" " " "F"
#[18] "r" "a" "n" "c" "e" "s"

chars = unlist(strsplit(string, ""))

possible = which(chars == "S")
possible
#[1] 5 14

substring(string, possible, possible + 2)
#[1] "Sli" "St"

substring(string, possible, possible + 2) == "St "

gsub("St ", "St. ", cNames)
# [1] "Dewitt County"               "Lac qui Parle County"       
# [3] "St. John the Baptist Parish" "Stone County"


###

funny = "rep1!c@ted"
subjectLines = c("Re: 90 days",
                 "Fancy rep1!c@ted watches", "It's me")

strings = c("hi mabc", "abc", "abcd", "abccd",
            "abcabcdx", "cab", "abd", "cad")

grep("[[:alpha:]][[:digit:][:punct:]][[:alpha:]]", 
     subjectLines)
#[1] 2 3

newStrings = gsub("'", "", subjectLines)
newStrings
# [1] "Re: 90 days"              "Fancy rep1!c@ted watches"
# [3] "Its me"

grep("[[:alpha:]][[:digit:][:punct:]][[:alpha:]]", 
     newStrings)
#[1] 2


grep("^[^[:lower:]]+$", 
     c(newStrings, "xAbcd", "ABC123+-", " "))
#[1] 5 6


gregexpr("[[:alpha:]][[:digit:][:punct:]][[:alpha:]]", 
     newStrings)
#[1] -1 12 -1
#attr(,"match.length")
#[1] -1  3 -1
#attr(,"useBytes")
#[1] TRUE


gregexpr("[[:alpha:]][[:digit:][:punct:]]+[[:alpha:]]",
         newStrings)
#[1] -1 9 -1
#attr(,"match.length")
#[1] -1  4 -1
#attr(,"useBytes")
#[1] TRUE



# Practice

practiceStrings = c("hi mabc", "abc", " abcd", "abccd", "abcabcdx", "cab", "abd", "cad")

grep("abc", practiceStrings)

grep("^abc", practiceStrings)

grep("abc.d", practiceStrings)

grep("abc+d", practiceStrings)

grep("abc?d", practiceStrings)

grep("abc$", practiceStrings)

grep("abc.*d", practiceStrings)

grep("abc?", practiceStrings)

grep("a[b?d]", practiceStrings)


# More Practice

practiceStrings2 = c("cat", "at", "t", "hate", "after", "caat", "caaat", "caaaat",     # 1-8
   "dog", "Dog", "dOg", "doG", "DOg", "doggy", "underdog", "rescued by the dog",       # 9-16
   "25.43", "33", "1000998.76224", "-98", "-109.53", "+76.3", "12..34", ".23", "4.",   # 17-25
   "+.", ".",                                                                          # 26-27
   "two words", "two      words", "oneword", "one two three", "   one     two   ")     # 28-32


# Greedy Matching

htmlStr = "<html><head></head><body> <h1>This is a title</h1><para>And this is a short paragraph. It has two sentences.</para></body></html>"

gregexpr("<.*>", htmlStr)

gregexpr("<[^>]*>", htmlStr)


