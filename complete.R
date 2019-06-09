###################################################################################################################
##  FUNCTION NAME: complete
##  PURPOSE: reads a directory full of files and reports the number of observed complete cases in each file
##  ARGUMENTS: 
##     directory: name of the directory storing the CSV files
##     id: ID number of the monitor (can be a range of monitors)
##  OUTPUT: a data frame presenting for each id the number of complete observations
##  RUNNING THE FUNCTION: e.g. complete("specdata",30:25)
###################################################################################################################


complete <- function(directory,id = 1:332) {
        ## Sets the work directory
        setwd("c:/coursera")
        ## Creates an empty data frame
        data <- data.frame()
        ## Creates a numeric vector
        nobs <- numeric()
        ## Creates a list of the files to be read from the directory passed as argument
        flist <- list.files(path = directory, full.names=TRUE, pattern = ".csv")
        for (i in id) {
                ## Reads the file containing the data (only the files containing data for the selected monitors)
                data <- read.csv(flist[i])
                ## Retrieves the number of rows in the file, excluding incomplete rows
                ## and appends the number of rows to the numeric vector 
                nobs <- c(nobs,nrow(na.omit(data)))
        }
        ## Displays the data frame returning two columns: 1st column contains the id of the monitor, 2nd column the
        ## number of complete measures
        data.frame(id,nobs)
}