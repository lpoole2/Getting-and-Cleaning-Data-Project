#Code Book

This document describes the code inside run_analysis.R.

##Main functions

read.table

Used to read specific data from a data set.

str

Used to look at the properties of a data set.

rbind

Used to integrate data sets.

dataCombine

Used to merge data sets.


##Sample Data Set
At this point the final data frame meanAndStdAverages looks like this:
  
> str(Tiny)
## 'data.frame':    10299 obs. of  68 variables:
##  $ tBodyAcc-mean()-X          : num  0.289 0.278 0.28 0.279 0.277 ...
##  $ tBodyAcc-mean()-Y          : num  -0.0203 -0.0164 -0.0195 -0.0262 -0.0166 ...
##  $ tBodyAcc-mean()-Z          : num  -0.133 -0.124 -0.113 -0.123 -0.115 ...
##  $ tBodyAcc-std()-X           : num  -0.995 -0.998 -0.995 -0.996 -0.998 ...
##  $ tBodyAcc-std()-Y           : num  -0.983 -0.975 -0.967 -0.983 -0.981 ...
##  $ tBodyAcc-std()-Z           : num  -0.914 -0.96 -0.979 -0.991 -0.99 ...