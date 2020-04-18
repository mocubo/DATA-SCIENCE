#Write a function that takes a directory of data files and a threshold for complete
#cases and calculates the correlation between sulfate and nitrate for monitor locations
#where the number of completely observed cases (on all variables) is greater than the threshold. 
#The function should return a vector of correlations for the monitors that meet the threshold 
#requirement. If no monitors meet the threshold requirement, then the function should return
#a numeric vector of length 0.

corr <-  function(directory='specdata', threshold=0){
        my_files<- file.path(directory,list.files(directory))
        correlacion <- vector()
        j<-0
        for (i in 1:332) {
                my_tabla <- read.csv(my_files[i],stringsAsFactors = FALSE)
                completos <- my_tabla [complete.cases(my_tabla),]
                casos <- nrow(completos)
                if (casos > threshold){
                        j<-j+1
                        correlacion[j]<- cor (completos$sulfate,completos$nitrate)
                }
        }
        correlacion
}
