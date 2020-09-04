## setwd in UCI HAR DATASET, load dplyr and tidyr libraries

## READ DATASETS FOR TRAIN AND TEST
#TRAIN
sub_1<- read.delim("./train/subject_train.txt", header = FALSE)
act_1<- read.delim("./train/y_train.txt", header = FALSE)
set_1 <-  read.delim("./train/X_train.txt", header = FALSE)
features <- unlist(read.delim("features.txt", header = FALSE))

for(i in 1:7352){
      set_1[i,1]<- trimws(set_1[i,1])
      set_1[i,1]<- gsub("  ", " ", set_1[i,1])
}
set_1 <- separate(set_1, V1, into=features, sep=" ")

#TEST
sub_2<- read.delim("./test/subject_test.txt", header = FALSE)
act_2<- read.delim("./test/y_test.txt", header = FALSE)
set_2 <-  read.delim("./test/X_test.txt", header = FALSE)
for(i in 1:2947){
      set_2[i,1]<- trimws(set_2[i,1])
      set_2[i,1]<- gsub("  ", " ", set_2[i,1])
}
set_2 <- separate(set_2, V1, into=features, sep=" ")

## FIND AND EXTRACT ONLY MEASUREMENTS ON MEAN AND STD
c1 <- c(grep("mean\\(\\)$|std\\(\\)$", features))
set_1 <- select(set_1, c1)
set_2 <- select(set_2, c1)
for(i in 1:18){
      set_1[,i] <- as.numeric(set_1[,i]) 
      set_2[,i] <- as.numeric(set_2[,i]) 
}

## MERGE DATASETS
data<-rbind(cbind(sub_1,act_1, set_1),cbind(sub_2, act_2, set_2))

##LABELING ACTIVITIES
data[,2] <- factor(data[,2], levels = c(1,2,3,4,5,6), labels = c("WALKING",
                                                                 "WALKING_UPSTAIRS","WALKING_DOWNSTAIRS", "SITTING",
                                                                 "STANDING", "LAYING"))

##LABELING DATA
names(data)[1:2] <- c("subject", "activity")
m<- names(data)[3:20]
m<- as.data.frame(strsplit(m, " "))
m<- as.vector(gsub("-", "",m[2,]))
names(data)[3:20]<-m

##CREATING MEANS

data %>% group_by(subject, activity) %>% summarize_at(vars(1:18), list(mean=mean))