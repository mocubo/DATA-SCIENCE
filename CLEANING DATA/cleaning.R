# Cargar las tablas desde los archivos
activity_labes<- read.csv(file.path("UCI HAR Dataset","activity_labels.txt"))
features<- read.csv(file.path("UCI HAR Dataset","features.txt"))
subject_test<- read.csv(file.path("UCI HAR Dataset/test","subject_test.txt"))
X_test<- read.csv(file.path("UCI HAR Dataset/test","X_test.txt"))
y_test.<- read.csv(file.path("UCI HAR Dataset/test","y_test.txt"))
subject_train<- read.csv(file.path("UCI HAR Dataset/train","subject_train.txt"))
X_train<- read.csv(file.path("UCI HAR Dataset/train","X_train.txt"))
y_train<- read.csv(file.path("UCI HAR Dataset/train","y_train.txt"))

#Formatear las tablas
subject_test<- as.factor(subject_test)
subject_train<- as.factor(subject_train)

