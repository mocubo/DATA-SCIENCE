# Este es mi primer programa en R.

# Write a function named 'pollutantmean' that calculates the mean of a pollutant
# (sulfate or nitrate) across a specified list of monitors. The function 
# 'pollutantmean' takes three arguments: 'directory', 'pollutant', and 'id'. 
# Given a vector monitor ID numbers, 'pollutantmean' reads that monitors' 
# particulate matter data from the directory specified in the 'directory'
# argument and returns the mean of the pollutant across all of the monitors,
# ignoring any missing values coded as NA.


pollutantmean<-  function( x='specdata',pollutant = 'sulfate',id=1){
        my_files<- file.path(x,list.files(x))  
        total<-0
        datos <-0
        if (pollutant == 'sulfate') columna = 2
        if (pollutant == 'nitrate') columna = 3
        for (n in id){
                airdata <- read.csv(my_files[n])
                totalparcial <- sum(airdata[,columna], na.rm=TRUE)
                datosparcial <- sum(!is.na(airdata[,columna]))
                total <- total + totalparcial
                datos <- datos + datosparcial
        }
        total/datos
}





