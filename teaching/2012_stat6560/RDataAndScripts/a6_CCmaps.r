File       a6_CCmaps 
By         Dr. Carr
Due        The two screen shots from 9. 
           Paste into word and put on your web site.    

1. Introduction

The purpose of this exercise is to promote the
development of new CCmaps applications.  
This particular exercise focuses on developing
a new data set to go with existing boundaries files.    

This example uses continental US counties. The boundary
files for counties and states are given in Section 7 below.   
 
2. Gather two county data sets.  
 
For convenience return to the
NCI Web Resources:

Atlas of Cancer Mortality in the U.S. 1950-1994
Data available for two time periods
1950-1969, 1970-1994

Access: http://www3.cancer.gov/atlasplus/new.html

Directions
Select  Mortality Maps and Rates by Cancer
Select  Type of Cancer 
Select  Download Data
Click   desired red button in the table
Click   Ascii Text  
 
Pick a cancer site for which there is county data.  
County data is not available for some of the rare cancer sites. 
Pick a sex, a race and get two data sets one for each time period.

The following is for white male prostate cancer.  Your 
example should be different.


3. Merging files and convert the county fips code 
   from a factor variable variable into a numeric variable  

# pro means prostate
# c   means county
# w   means white
# m   means male
# 50  means 1950-1969
# 70  means 1970-1004

procwm50 = read.table('procwm50.txt',sep=';',header=T,row.names=1)
procwm70 = read.table('procwm70.txt',sep=';',header=T,row.names=1)      

# Remove the US value in the first line
procwm50US = procwm50[1,]
procwm50 = procwm50[-1,]

procwm70US = procwm70[1,]
procwm70 = procwm70[-1,]
# check
procwm70[1:5,]

# the first four variables of the seven variables are  
# age-adjusted rate
# the number of deaths
# the rate lower bound
# the rate upper bound

# merge the first two variables for the two data sets.
# using the county fips codes, the row.names

procwm5070 = merge(procwm50[,1:2],procwm70[,1:2],by="row.names")

# For this kind of merge R adds the row.names as variable 1
# When the same variable names appear in both sets 
# it adds '.x' to the label of the first set
# it adds '.y' to the label of the second set
names(procwm5070)

# The polygon fips codes in CCmaps do not have a leading zero.
# To make fips codes in the data file match this we need
# to convert the fips codes in column 1 to integers.

# This is a bit tricky since Splus has encoded the fips codes as
# as a factor 
#    as.character() converts the factor level interpretation into characters
#    as.numeric() converts the numbers encoded as character strings
#    into the standard numeric representation 
procwm5070[,1] = as.numeric(as.character(procwm5070[,1]))
# 
procwm5070[1:5,1]  #check okay

4. Fix up the variable labels 
names(procwm5070) = c('ID',
'rate50','count50',
'rate70','count70')

5.  Add three more variables 

# the rate bound width for 50
# the rate bound width for 70
# the percent change in rates from 50 to 70

a = procwm50[,1]
b = procwm70[,1]
procwm5070 = data.frame(procwm5070,
                    bndDif50=procwm50[,4]-procwm50[,3],
                    bndDif70=procwm70[,4]-procwm70[,3],
                    percentChange=100*(b-a)/a)
procwm5070[1:5,]

6. Write the data frame to a .csv file.  

write.csv(procwm5070,file="procwm5070.csv")

Using Excel remove the first column of integers that R has added.
I select the column and delete it.
The save the file.  When I exit I do not save the file
again.  If I read the file I get a message but it come up.
  

7. Building a new application

Download CCmaps from the link.  I suggest getting the full version
that comes with the Run Time Environment compatible with the 
dated software.  Unzip the file.  It is pretty big. 

Look in the CCmaps folder. Double click on the CCmaps batch file icon.
to run CCmaps.  

For fun you can use the open item under the File menu
to run an existing application.  There are several in the 
application folder and the folders inside.  Select a file that starts
with ap_ such as ap_LungRainPov.txt.  The maps should come up
and you can try the slides, etc.
 
For this assignment 

Run CCmaps
Under the File menu select New 

Fill in the four file names and save, using the browser
where convenient to get the names.    


In my cases the names were      
Data:               C:\CCmaps\Applications\Health\procwm5070.csv
Region Polygons:    C:\CCmaps\Applications\Health\county.txt  
Reference Polygons: C:\CCmaps\Applications\Health\county_states.txt
Save to:            C:\CCmaps\Applications\Health\ap_procwm5070.txt

CCmaps will create a new application and calculate default values to get started
and after a while the maps view should appear with the new data.   

  
8.  Edit default labeling for the top text and the variables

Under the edit menu select top text item and edit the user labels.
In my case I would indicate the data is for White Males,
indicated the source, and provide link to contact me.    

The maps probably look okay so you can leave the map bounds alone.
The map bounds item lets you associated different x and y
limits with the panel edges to change the aspect ratio of the map.  

Under the Variables Menu select Labels and provide better labels with units. 
My top label would be Prostate Cancer Mortality Rate 1970-1994 (Deaths per 100000)
  
Unfortunately you can only edit the labels for the variables in view.  
Use the Picker under the Variables Menu to select other variables
and improve their labels.

Use the save item under the file menu to save the results.  This can be
the same ap_ file.  

9. Produce two plots

Use the Cognostics Menu items
Find Candidates and Display All items
to find a slider setting with a relatively
high R-squared value.  This may be pretty
low. Save the screen shot to submit.     

Plot 1 (with your variables) 
Color:  Rate 70
X       Rate 50
y       BndDif 70 
Weight  Equal  

Plot2 (with your variables)
Color:  PercentChange
x:      Rate50
y:      Rate70
Weight  Equal


10.  Bonus question

Given the standard errors for the two rates, how would you
approximate the standard error for the percent change.  If you
have no clue its okay.  If you do know or can find out, great. 
 
  			           