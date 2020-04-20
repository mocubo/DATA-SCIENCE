#Cargar paquetes
library(dplyr)


# Cargar las tablas desde los archivos
activity_labes<- read.table(file.path("UCI HAR Dataset","activity_labels.txt"))
features<- read.table(file.path("UCI HAR Dataset","features.txt"))
subject_test<- read.table(file.path("UCI HAR Dataset/test","subject_test.txt"))
X_test<- read.table(file.path("UCI HAR Dataset/test","X_test.txt"))
y_test<- read.table(file.path("UCI HAR Dataset/test","y_test.txt"))
subject_train<- read.table(file.path("UCI HAR Dataset/train","subject_train.txt"))
X_train<- read.table(file.path("UCI HAR Dataset/train","X_train.txt"))
y_train<- read.table(file.path("UCI HAR Dataset/train","y_train.txt"))

#Formatear las tablas
subject_test<- as.factor(subject_test)
subject_train<- as.factor(subject_train)
id_test<- c(1:nrow(y_test))
id_train<- c((nrow(y_test)+1):(nrow(y_test)+nrow(y_train)))
X_train<- mutate (X_train, 'id'=id_train, 'group'='train', 'activity'=y_train$V1)
X_test<- mutate (X_test, 'id'=id_test,'group'='test', 'activity'=y_test$V1)
X_y<- merge (X_test,X_train)

