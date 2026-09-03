# L21a: RegularExpressions

# More Practice

practiceStrings2 = c("cat", "at", "t", "hate", "after", "caat", "caaat", "caaaat",     # 1-8
   "dog", "Dog", "dOg", "doG", "DOg", "doggy", "underdog", "rescued by the dog",       # 9-16
   "25.43", "33", "1000998.76224", "-98", "-109.53", "+76.3", "12..34", ".23", "4.",   # 17-25
   "+.", ".",                                                                          # 26-27
   "two words", "two      words", "oneword", "one two three", "   one     two   ")     # 28-32

grep("cat|at|t", practiceStrings2)
grep("^(cat|at|t)$", practiceStrings2)

grep("ca+t", practiceStrings2)

grep("[dD][oO][gG]", practiceStrings2)
grep("^[dD][oO][gG]$", practiceStrings2)

grep("[[:digit:]]+\\.?[[:digit:]]*", practiceStrings2)
grep("^[+]?[[:digit:]]*\\.?[[:digit:]]*$", practiceStrings2)
# the next two are identical
grep("^[+]?([.][[:digit:]]+|[[:digit:]]+\\.?[[:digit:]]*)$", practiceStrings2)
grep("^[+]?([.][[:digit:]]+|[[:digit:]]+[.]?[[:digit:]]*)$", practiceStrings2)

grep("[[:space:]]*[[:alpha:]]+[[:space:]]+[[:alpha:]]+[[:space:]]*", practiceStrings2)
grep("^[[:space:]]*[[:alpha:]]+[[:space:]]+[[:alpha:]]+[[:space:]]*$", practiceStrings2)


