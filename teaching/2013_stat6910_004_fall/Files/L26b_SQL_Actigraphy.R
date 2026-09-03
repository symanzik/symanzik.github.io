# L26b: Read Actigraphy Data from SQL Data Base
#
# Based on Work for Abbass Sharif's Dissertation 

library(RSQLite)
	
### Define Database Driver
driver = dbDriver("SQLite")

### Define connection to actread.db
connect <- dbConnect(driver, dbname = "C://JUE//Teaching//Stat6910_Fa2013_AdvancedR//LectureNotes//actread.db")

# Which tables are in the database?
dbListTables(connect)

### Select all rows & all columns from the database
query_baseline = dbSendQuery(connect, statement = "SELECT * FROM tbl_actread;")
data_baseline = fetch(query_baseline, n = -1)  
dim(data_baseline)
head(data_baseline)

# What was the SQL statment?
dbGetStatement(query_baseline)

# Are there more data to fetch?
dbHasCompleted(query_baseline)

### Select all rows & all columns of the baseline data from the database
query_baseline = dbSendQuery(connect, statement = "SELECT * FROM tbl_actread WHERE BaseEq0 = 0;")
data_baseline = fetch(query_baseline, n = -1)  
dim(data_baseline)
head(data_baseline)

### Select all rows & Time__1 & Act columns of the baseline data from the database
query_baseline = dbSendQuery(connect, statement = "SELECT Time__1, Act FROM tbl_actread WHERE BaseEq0 = 0;")
data_baseline = fetch(query_baseline, n = -1)  
dim(data_baseline)
head(data_baseline)
plot(data_baseline)

### Select all rows & Time__1 & Act columns of the data 6 months after from the database
query_after6months = dbSendQuery(connect, statement = "SELECT Time__1, Act FROM tbl_actread WHERE BaseEq0 = 1;")
data_after6months = fetch(query_after6months, n = -1)
dim(data_after6months)
head(data_after6months)
plot(data_after6months)

### What are the means for the 2 groups?
query_means = dbSendQuery(connect, statement = "SELECT BaseEq0, AVG(Act) FROM tbl_actread GROUP BY BaseEq0;")
data_means = fetch(query_means, n = -1)
data_means

### Select Time__1 & Act & Day__1 & BaseEq0 columns from the database where Act >= 10500 
query_big = dbSendQuery(connect, statement = "SELECT Time__1, Act, Day__1, BaseEq0 FROM tbl_actread WHERE Act >= 10500;")
data_big = fetch(query_big, n = -1)
dim(data_big)
data_big

### Produce nicer column names via the AS option
query_big = dbSendQuery(connect, statement = "SELECT Time__1 AS Time, Act, Day__1 AS Day, BaseEq0 FROM tbl_actread WHERE Act >= 10500;")
data_big = fetch(query_big, n = -1)
dim(data_big)
data_big

### Done !!!
dbDisconnect(connect)

