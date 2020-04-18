rankhospital <- function (state= 'AL',outname= 'heart attack', num){
                outcome<- read.csv("outcome-of-care-measures.csv",stringsAsFactors = FALSE )
                columna <- switch (outname, 'heart attack'=11,
                                   'heart failure'=17,  'pneumonia' =23)
                if(num =='best') num=1
                outcome [,columna] <- as.numeric(outcome [,columna])
                ordenada <- outcome [order(outcome[,columna], outcome$Hospital.Name),]
                if (is.element (state,ordenada$State)){
                        listaestado<- ordenada [ordenada$State == state,]
                        filterna <- !is.na(listaestado[,columna])
                        resultado<- listaestado [filterna,]
                        ultima <- nrow(resultado)
                        if(num =='worst') num=ultima
                        hospital <- listaestado[num,2]
                }
                else 
                        hospital <-'estado no disponible'
                
                if (length (columna) == 0) 
                        hospital <-'enfermedad no disponible'
                hospital
}