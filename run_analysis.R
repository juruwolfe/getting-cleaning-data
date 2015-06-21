run_analysis <- function(){
	##Let's grab the data, in our renamed 'data' folder, because the old folder name had spaces
	features <- read.table("data/features.txt")
	
	xTest <- read.table("data/test/X_test.txt")
	yTest <- read.table("data/test/y_test.txt")
	subject_test <- read.table("data/test/subject_test.txt")
	
	xTraining <- read.table("data/train/X_train.txt")
	yTraining <- read.table("data/train/y_train.txt")
	subject_train <- read.table("data/train/subject_train.txt")
	
	##Now to combine our X data
	x <- rbind(xTest, xTraining)
	##And set the headers as features 
	colnames(x) <- features$V2
	
	##Now to combine our subject info
	sub <- rbind(subject_test,subject_train)	
	##And set the column name
	colnames(sub) <- "Subject"
	
	##Onto Y!
	y <- rbind(yTest, yTraining)	
	##And set the column name
	colnames(y) <- "Activity"
	
	##Swap out the activity names for their actual names
	##This *should* be dynamic, will refactor if I have time
	y[y == 1] = "Walking"
	y[y == 2] = "Walking_Upstairs"
	y[y == 3] = "Walking_Downstairs"
	y[y == 4] = "Sitting"
	y[y == 5] = "Standing"
	y[y == 6] = "Laying"
	
	##Let's bring it all home, into one giant set
	rawData <- cbind(x,sub,y)
	
	## Time to grab all the column names that include a 
	## variable on the Mean or std, using a custom function
	meanCols <- getColumnNames("Mean",rawData)
	stdCols <- getColumnNames("std",rawData)
	
	## Get just the data that goes with the mean and STD cols
	meanCsv <- rawData[,meanCols]
	stdCsv <- rawData[,stdCols]
	
	# combine them into one, and inclue the subject & activity info
	meanAndStd <- cbind(meanCsv,stdCsv,sub,y)
	
	# get the averages for each activity & subject, on the mean and std
	averages <- aggregate(meanAndStd, list(Activity = meanAndStd$Activity, Subject =  meanAndStd$Subject), mean)
	
	# remove the activity & subject columns, as they're now included as 
	# the first two
	length <- ncol(averages)
	averages[length] <- NULL
	averages[length-1] <- NULL
	
	# write our tidy data set
	write.table(averages, file="wearable-tidy-data.txt", row.name=FALSE)
}

getColumnNames <- function(string, data){
	# create empy variable 
	stringColNames <- ""
	# get all the possible column names
	colnames <- c(colnames(data))
	# find which columns include the string passed to the function
	stringLocation <- grep(string, colnames)
	# loop through that to grab the actual column names that include the
	# string, push that to the empty var
	for(i in stringLocation){
		stringColNames <- c(stringColNames, colnames(data[i]))
	}
	# get rid of the empty space in our new vector
	stringColNames <- stringColNames[stringColNames != ""]
	# send back the column names
	return(stringColNames);
}