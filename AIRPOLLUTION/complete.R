# Write a function that reads a directory full of files and reports the number 
# of completely observed cases in each data file. The function should return a
# data frame where the first column is the name of the file and the second 
# column is the number of complete cases.

complete <-  function(x='specdata', id=1){
        my_files<- file.path(x,list.files(x))
        a <- numeric(length(id))
        b <- numeric(length(id))
        for (i in 1:length(id)){
                a [i] <- id[i]
                b [i] <- sum(complete.cases(read.csv(my_files[id[i]])))
        }
        data.frame('location'=a, 'nobs'=b)
}
