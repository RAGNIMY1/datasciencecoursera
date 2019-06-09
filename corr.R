###################################################################################################################
##  FUNCTION NAME: corr
##  PURPOSE: takes a directory and a threshold of complete cases and calculates the correlation between sulfate 
##  and nitrate for monitors where the number of completely observed cases is greater than the threshold. 
##  ARGUMENTS: 
##     directory: name of the directory storing the CSV files
##     threshold: indicates the number of complete observations required to calculate the correlation
##  OUTPUT: a vector of correlations for all the monitors that met the threshold. If no monitors meet the
##  threshold, the function returns a numeric vector of length 0.
###################################################################################################################

corr <- function(directory,threshold=0) {
        ## Sets the work directory
        setwd("c:/RAGNIMY1/datasciencecoursera")
        ## Creates an empty numeric vector
        vectcor <- vector(mode = "numeric", length = 0)
        ## Creates a list of the files to be read from the directory passed as argument
        flist <- list.files(path = directory, full.names=TRUE, pattern = ".csv")
        ## Loops from the 1st to the last file
        for (i in 1:length(flist)) {
                ## Reads the file
                data <- read.csv(flist[i])
                ## Calculate the Correlation between "nitrate" and "sulfate"for completely observed cases,
                ## if the number of observations for a particular monitor is greater than the threshold passed as argument
                ## and appends the result to a vector while looping across the files
                if(sum(complete.cases(data))> threshold) {
                       vectcor <- c(vectcor,cor(data[["sulfate"]],data[["nitrate"]], use = "complete.obs"))
                } 
        }
        ## Returns the vector of calculated correlations
        return(vectcor)
}