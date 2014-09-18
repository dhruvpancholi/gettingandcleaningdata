---
title: "README"
author: "Dhruv Pancholi"
date: "Thursday, September 18, 2014"
output: html_document
---
Getting and Cleaning Data Coursera Project
===============================================

## Merging Data

After extracting the file, set the corresponding directory and the following code is used to read and merge the X data:

```r
test_x <- read.table("./test/X_test.txt")
headings <- read.table("./features.txt")
train_x <- read.table("./train/X_train.txt")
res_x <- rbind(test_x,train_x)

# write the merged X data
write.table(res_x, file="./combo/X.txt", row.names=FALSE, col.names=FALSE)

```

Merge the y data:

```r
test_y <- read.table("./test/Y_test.txt")
train_y <- read.table("./train/Y_train.txt")
res_y <- rbind(test_y,train_y)
# write the merged y data
write.table(res_y[,1], file="./combo/Y.txt", row.names=FALSE, col.names=FALSE)
```

Merge the subject data:
```r
test_subject <- read.table("./test/subject_test.txt")
train_subject <- read.table("./train/subject_train.txt")
res_subject <- rbind(test_subject,train_subject)

# write the merged subject data
write.table(res_subject[,1], file="./combo/subject.txt", row.names=FALSE, col.names=FALSE)

```

## Subsetting data
Creating the resultant data set which contains all the variables:
```r
# resultant data table
res[,1]<-res_subject
res[,2]<-res_y
res[,3:8]<-res_x[1:6]

# naming columns
names(res)<-c("subject","activity","mean_x","mean_y","mean_z","std_x","std_y","std_z")

# reading and assigning the labels to each and every activity
activity_labels <- read.table("./activity_labels.txt")[,2]
res$activity<-factor(res$activity,labels=activity_labels)
res$subject<-factor(res$subject)
```

Creating final tidy data set:
```r
# creating data table for each subject for each variable
tidy_data=expand.grid(subject=rep(1:30,6))
variables<-c("mean_x","mean_y","mean_z","std_x","std_y","std_z")
tidy_data$variable=rep(variables,each=30)

#calculating the mean for every subject for every activity
for(j in variables){
   for(i in levels(res$activity)){
     tidy_data[(tidy_data$variable==j),i]<-tapply(res[,j][res$activity==i],res$subject[res$activity==i],mean)
   }
}

# writing the final table which is uploaded
write.table(tidy_data, file="./combo/tidy_data.txt", row.names=FALSE)

```

## Complete Code
```r
setwd("D:/C/Courses/Data Science Courses/Getting and Cleaning Data/data/project_dataset")
test_x <- read.table("./test/X_test.txt")
headings <- read.table("./features.txt")
train_x <- read.table("./train/X_train.txt")
res_x <- rbind(test_x,train_x)

write.table(res_x, file="./combo/X.txt", row.names=FALSE, col.names=FALSE)


test_y <- read.table("./test/Y_test.txt")
train_y <- read.table("./train/Y_train.txt")
res_y <- rbind(test_y,train_y)
write.table(res_y[,1], file="./combo/Y.txt", row.names=FALSE, col.names=FALSE)

test_subject <- read.table("./test/subject_test.txt")
train_subject <- read.table("./train/subject_train.txt")
res_subject <- rbind(test_subject,train_subject)
write.table(res_subject[,1], file="./combo/subject.txt", row.names=FALSE, col.names=FALSE)

res[,1]<-res_subject
res[,2]<-res_y
res[,3:8]<-res_x[1:6]
names(res)<-c("subject","activity","mean_x","mean_y","mean_z","std_x","std_y","std_z")
activity_labels <- read.table("./activity_labels.txt")[,2]
res$activity<-factor(res$activity,labels=activity_labels)
res$subject<-factor(res$subject)
tidy_data=expand.grid(subject=rep(1:30,6))
variables<-c("mean_x","mean_y","mean_z","std_x","std_y","std_z")
tidy_data$variable=rep(variables,each=30)
for(j in variables){
   for(i in levels(res$activity)){
     tidy_data[(tidy_data$variable==j),i]<-tapply(res[,j][res$activity==i],res$subject[res$activity==i],mean)
   }
}
write.table(tidy_data, file="./combo/tidy_data.txt", row.names=FALSE)
```
