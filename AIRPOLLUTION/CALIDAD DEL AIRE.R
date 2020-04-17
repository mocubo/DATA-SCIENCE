# Este es mi primer programa en R

pollutantmean<-  function( id=1,pollutant = 'sulfate',x='specdata'){
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





