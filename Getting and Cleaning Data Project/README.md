---
title: "README.md"
author: "Luka"
date: "August 23, 2015"
output: html_document
---

## Explanation for the scripts

1. Place the "UCI HAR Dataset" folder in your working directory

2. Place the "run_analysis.R" script in your working directory

3. Please make sure you have the following packages installed:
        
        plyr

4. Calls to the library function for all packages will be invoked by the script

5. Run "run_analysis.R" script from the console in R Studio



## Details on tidy data set created in step 5 of the project

1. Data was saved using command: 

        write.table(tidyDataMeanStd_Grouped, file = "tidyDataMeanStd_Grouped.txt", row.name = FALSE)

2. Text file can be loaded into R using:
        
        data <- read.table("tidyDataMeanStd_Grouped.txt", header = TRUE)
        
3. If your display in R is not "neat", please change the options in Tools > Global Options > Appearance > Font size; alternatively you may resize your R Studio console window.
        