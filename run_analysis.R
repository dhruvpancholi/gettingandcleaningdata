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
