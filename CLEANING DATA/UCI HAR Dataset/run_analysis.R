

setwd("test")

# Reads the csv files and store them as R objects 
xtest <- read.csv("X_test.txt")
ytest <- read.csv("y_test.txt")
subjecttest <- read.csv("subject_test.txt")
setwd("Inertial Signals")
body_acc_x_test <- read.csv("body_acc_x_test.txt")
body_acc_y_test <- read.csv("body_acc_y_test.txt")
body_acc_z_test <- read.csv("body_acc_z_test.txt")
body_gyro_x_test <- read.csv("body_gyro_x_test.txt")
body_gyro_y_test <- read.csv("body_gyro_y_test.txt")
body_gyro_z_test <- read.csv("body_gyro_z_test.txt")
total_acc_x_test <- read.csv("total_acc_x_test.txt")
total_acc_y_test <- read.csv("total_acc_y_test.txt")
total_acc_z_test <- read.csv("total_acc_z_test.txt")

setwd("..")
setwd("..")

setwd("train")
xtrain <- read.csv("X_train.txt")
ytrain <- read.csv("y_train.txt")
subjecttrain <- read.csv("subject_train.txt")
setwd("Inertial Signals")
body_acc_x_train <- read.csv("body_acc_x_train.txt")
body_acc_y_train <- read.csv("body_acc_y_train.txt")
body_acc_z_train <- read.csv("body_acc_z_train.txt")
body_gyro_x_train <- read.csv("body_gyro_x_train.txt")
body_gyro_y_train <- read.csv("body_gyro_y_train.txt")
body_gyro_z_train <- read.csv("body_gyro_z_train.txt")
total_acc_x_train <- read.csv("total_acc_x_train.txt")
total_acc_y_train <- read.csv("total_acc_y_train.txt")
total_acc_z_train <- read.csv("total_acc_z_train.txt")

# Join every variable on a single dataframe, one for the test data and another
# the for the training data with appropiate labels.



test <- data.frame(
        x = xtest[, 1], Activity = ytest[, 1], Subject = subjecttest [,1], 
        body_acc_x = body_acc_x_test[, 1], body_acc_y = body_acc_y_test[, 1], body_acc_z = body_acc_z_test[, 1],
        body_gyro_x = body_gyro_x_test[, 1], body_gyro_y = body_gyro_y_test[, 1], 
        body_gyro_z = body_gyro_z_test[, 1], total_acc_x = total_acc_x_test[, 1], 
        total_acc_y = total_acc_y_test[, 1], total_acc_z = total_acc_z_test[, 1]
)

train <- data.frame(
        x = xtrain[, 1], Activity = ytrain[, 1], Subject = subjecttrain [,1], 
        body_acc_x = body_acc_x_train[, 1], body_acc_y = body_acc_y_train[, 1], body_acc_z = body_acc_z_train[, 1],
        body_gyro_x = body_gyro_x_train[, 1], body_gyro_y = body_gyro_y_train[, 1], 
        body_gyro_z = body_gyro_z_train[, 1], total_acc_x = total_acc_x_train[, 1], 
        total_acc_y = total_acc_y_train[, 1], total_acc_z = total_acc_z_train[, 1]
)


# Add a column to indicate if the data is from test or train set

test <- mutate (test, type = "test")
train <- mutate (train, type = "train")

# Merge both sets of data

data <- rbind (test, train)


# Use descriptive activity names 

data$Activity <- factor(data$Activity, levels = c(1, 2, 3, 4, 5, 6),
                      labels = c("WALKING", "WALKING_UPSTAIRS", "WALKING_DOWNSTAIRS", "SITTING", "STANDING", "LAYING"))


# Split the 561 features from x and label them as per features.txt
setwd("..")
setwd("..")
features <- read.table("features.txt", stringsAsFactors = FALSE)
column_names <- features[, 2]
data$x <- gsub("^", " ", data$x)
numbers_list <- strsplit(data$x, "\\s+")
numbers_list <- lapply(numbers_list, function(x) {
        x <- x[x != ""]
        })
numbers_df <- as.data.frame(do.call(rbind, numbers_list))
colnames(numbers_df) <- column_names
data_with_numbers <- cbind(data, numbers_df)

#EXTRACT ONLY THE MEASUREMENTS ON THE MEAN AND STANDARD DEVIATION FOR EACH MEASUREMENT

columns_to_extract <- grep("mean|std", names(data_with_numbers), value = TRUE)
extract <- data_with_numbers[, c("Activity", "Subject", columns_to_extract)]
extract[, -c(1, 2)]  <- lapply(extract[, -c(1, 2)], function(x) as.numeric(x))

#Second data set wit the average of each variable for each activity and each subject

tidy_data <- aggregate(. ~ Activity + Subject, data = extract, FUN = mean, na.rm = TRUE)
tidy_data <- tidy_data[order(tidy_data$Activity, tidy_data$Subject), ]
rownames(tidy_data) <- NULL


#Save the tidy_data set to csv

write.csv(tidy_data, file = "tidy_data.csv", row.names = FALSE)
nombre_archivo <- "tidy_data.txt"
write.table(tidy_data, file = nombre_archivo, sep = "\t", row.names = FALSE)
