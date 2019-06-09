###################################################################################################################
##  FUNCTION NAME: pollutantmean
##  PURPOSE: calculates the mean of a pollutant across a list of monitors - data is stored in CSV files, 
##  each file containing data from a single monitor
##  ARGUMENTS: 
##     directory: name of the directory storing the CSV files
##     pollutant: fine particulate matter (nitrate or sulfate) for which we will calculate the mean
##     id: ID number of the monitor (can be a range of monitors)
##  RUNNING THE FUNCTION: e.g. pollutantmean("specdata","nitrate",70:72)
###################################################################################################################


pollutantmean <- function(directory,polutant,id = 1:332) {
        ## Sets the work directory
        setwd("c:/coursera")
        ## Creates an empty data frame
        data <- data.frame()
        ## Creates a numeric vector
        level_pm <- numeric()
        ## Creates a list of the files to be read
        flist <- list.files(path = directory, full.names=TRUE, pattern = ".csv")
        for (i in id) {
                ## Reads the files containing the data (only the files containing data for the selected monitors)
                data <- read.csv(flist[i])
                ## Concatenates the vector level_pm with all the values of the pollutant data read in each file
                level_pm <- c(level_pm,data[[polutant]])
        }
        ## Calculates the mean of the pollutant data, ignoring the missing values identified as NA
        mean(level_pm, na.rm=TRUE)
}
