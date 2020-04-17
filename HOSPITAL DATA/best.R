
best <- function (state= 'AL',outname= 'heart attack'){
        outcome<- read.csv("outcome-of-care-measures.csv",stringsAsFactors = FALSE )
        outcome <- outcome [order(outcome$Hospital.Name),]
        columna <- switch (outname, 'heart attack'=11,
                           'heart failure'=17,  'pneumonia' =23)
        if (is.element (state,outcome$State)){
                filterestado <- outcome$State == state
                listaestado<- outcome [filterestado,]
                filterna <- !is.na(listaestado[,columna])
                fila <- which.min (listaestado[filterna ,columna])
                hospital <- listaestado[fila,2]
        }
        else 
                hospital <-'estado no disponible'
        
        if (length (columna) == 0) 
                hospital <-'enfermedad no disponible'
        hospital
}