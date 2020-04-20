#Cargar paquetes
library(dplyr)


# Cargar las tablas desde los archivos
carga<- function (){
        activity_labels<- read.table(file.path("UCI HAR Dataset","activity_labels.txt"))
        features<- read.table(file.path("UCI HAR Dataset","features.txt"))
        subject_test<- read.table(file.path("UCI HAR Dataset/test","subject_test.txt"))
        X_test<- read.table(file.path("UCI HAR Dataset/test","X_test.txt"))
        y_test<- read.table(file.path("UCI HAR Dataset/test","y_test.txt"))
        subject_train<- read.table(file.path("UCI HAR Dataset/train","subject_train.txt"))
        X_train<- read.table(file.path("UCI HAR Dataset/train","X_train.txt"))
        y_train<- read.table(file.path("UCI HAR Dataset/train","y_train.txt"))
}

#Formatear y unir las tablas
formatea<- function(){
        features$V2<- as.character(features$V2)
        id_test<- c(1:nrow(y_test))
        id_train<- c((nrow(y_test)+1):(nrow(y_test)+nrow(y_train)))
        activity_labels <- rename(activity_labels, 'label'='V2')
        X_train<- mutate (X_train, 'id'=id_train, 'group'='train', 'activity'=y_train$V1, 'subject'=subject_train$V1)
        X_test<- mutate (X_test, 'id'=id_test,'group'='test', 'activity'=y_test$V1, 'subject'=subject_test$V1)
        X_y<- merge (X_test,X_train, all=TRUE)
        X_y_activities<- merge (X_y, activity_labels, by.x='activity', by.y = 'V1', all = TRUE)
        names (X_y_activities)[2:562]<- features$V2
}

#Seleccionar las variables medias y std y crear tabla final resumen
resume <- function(){
           medias<- X_y_activities[, c(1,grep('*mean*|*std*',names(X_y_activities)),(length (X_y_activities)-2):length (X_y_activities))]
      
}





