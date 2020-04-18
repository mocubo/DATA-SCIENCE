rankall <- function (outname= 'heart attack', num='best'){
        outcome<- read.csv("outcome-of-care-measures.csv",stringsAsFactors = FALSE )
        columna <- switch (outname, 'heart attack'=11,
                           'heart failure'=17,  'pneumonia' =23)
        if(num =='best') 
                num=1
        outcome [,columna] <- as.numeric(outcome [,columna])
        ordenada <- outcome [order(outcome[, columna], outcome$Hospital.Name),]
        estados <- sort(unique (outcome$State))
        hospital <- vector()
        index <- vector()
        for (i in 1:length(estados)){
                state<- estados[i]
                listaestado<- ordenada [ordenada$State == state,]
                filterna <- !is.na(listaestado[,columna])
                resultado<- listaestado [filterna,]
                ultima <- nrow (resultado)
                if(num =='worst') 
                        pos=ultima
                else
                        pos = num
                hospital[i] <- as.character (resultado[pos,2])
                index [i]<- i
        }
        
        if (length (columna) == 0) 
                hospital <-'enfermedad no disponible'
        data.frame("hospital"= hospital,'state'= estados)
        
}

