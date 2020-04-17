best <- function (state= 'AL',outname= 'heart attack'){
        outcome<- read.csv("outcome-of-care-measures.csv" )
        outcome [order(outcome$Hospital.Name),]
        if (is.element (state,outcome$State)){
                listaestado<- filter (outcome, outcome$State == state)
                fila <- which.min (listaestado[ ,columna])
                hospital <- outcome[fila,2]
        }
        else 
                hospital <-'estado no disponible'
        columna <- switch (outname, 'heart attack'=11,
                           'heart failure'=17,  'pneumonia' =23)
        if (length (columna) == 0) 
                hospital <-'enfermedad no disponible'
        hospital
}
