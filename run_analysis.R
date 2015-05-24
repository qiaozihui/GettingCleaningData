
library(dplyr)
##create test table with features as col name, add 2 more columns as activity and objects 
testX<-read.table("UCI HAR Dataset/test/X_test.txt")
testY<-read.table("UCI HAR Dataset/test/Y_test.txt")
testsub<-read.table("UCI HAR Dataset/test/subject_test.txt")
features<-read.table("UCI HAR Dataset/features.txt")
colnames(testX) <- features[,2]
activity<-read.table("UCI HAR Dataset/activity_labels.txt")
testactivity<-join(testY,activity,by="V1")
colnames(testactivity)<-c("A_label","Activity")
colnames(testsub)<-"subject"
finaltest<-cbind(testsub,testactivity[,2],testX)
colnames(finaltest)[2]<-"activity"

##create train table with features as col name, add 2 more columns as activity and objects 
trainX<-read.table("UCI HAR Dataset/train/X_train.txt")
trainY<-read.table("UCI HAR Dataset/train/Y_train.txt")
trainsub<-read.table("UCI HAR Dataset/train/subject_train.txt")
colnames(trainX) <- features[,2]
trainactivity<-join(trainY,activity,by="V1")
colnames(trainsub)<-"subject"
finaltrain<-cbind(trainsub,trainactivity[,2],trainX)
colnames(finaltrain)[2]<-"activity"

##rbind test and train tables
finaltotal<-rbind(finaltest,finaltrain)

##extrac col with mean and sd
final<-finaltotal[grep("mean()|std()",colnames(finaltotal))]
final<-cbind(finaltotal[,1:2],final)
final<-final[-grep("meanFreq",colnames(final))]

##calculate mean for each subject on each activity
subject<-c(1:30)
aname<-activity[,2]
fcondition<-mutate(final,condition=paste(subject,activity))
conditionnames<-fcondition$condition
meantable<-aggregate(fcondition[,3:68],list(conditionnames),mean)

##add subject and activity name to table
split<-strsplit(meantable[,1],split=" ")
split<-unlist(split)
splittable<-matrix(split,ncol=2,byrow=TRUE)
colnames(splittable)<-c("subject","activity")

##create final mean table
finalmean<-cbind(splittable,meantable[,2:67])
write.table(finalmean,file="PA3_3.txt",row.name=FALSE)
