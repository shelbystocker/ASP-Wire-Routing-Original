library(plyr)
library(rjson) #install these packages if necessary

#List all files matching the pattern in these directories. 
fileList <- list.files("/Users/Shelby/Research/spring19/orig-vs-optimize/try1",  full.names = TRUE, pattern = "-results1.txt")

#The first line sets up a dataframe with no rows and four columns. The second is a list of the column names, and the third sets the names for the dataframe.
resultsFrame <- data.frame(matrix(ncol=6,nrow=0))
x <- c("FileName", "Blocks", "Time", "Satisfiability", "Rules", "Atoms")
colnames(resultsFrame) <- x

#Get the length of your file array, this should probably not be a magic number.
for(i in 1:length(fileList)){
  fileName = fileList[i]
  if(file.info(fileName)$size != 0){ #If the file is not empty
    JSONSolved <- rjson::fromJSON(file = fileName) #Load the JSON
    if(JSONSolved[[1]][["Result"]] == "OPTIMUM FOUND"){
      satisfiability <- 1
    }
    else{
      satisfiability <- 0
    }
    blocks <- JSONSolved[[2]][["Blocks"]]
    Time <- JSONSolved[[1]][["Time"]][["Total"]]
    Rules <- JSONSolved[[1]][["Stats"]][["LP"]][["Rules"]][["Original"]]
    Atoms <- JSONSolved[[1]][["Stats"]][["LP"]][["Atoms"]]
    #Temporarily load the above values into a new dataframe.
    tempFrame <- data.frame(fileName, blocks, Time, satisfiability, Rules, Atoms)
    #Set the column names from x above.
    colnames(tempFrame) <- x
    #Concatenate vertically (add tempFrame to the bottom of reachabilityTime)
    resultsFrame <- rbind(resultsFrame, tempFrame)
    #Remove old variables
    
  }
  else{
    print("ERROR")
  }
  
}
#Hmmm I shouldve commented this one before. I believe it "summarizes" based on the blocked variable. So it will average all rows with the same value for blocked.
#It also removes NA values. 
#df3 <- ddply(reachabilityTime,.(blocked),summarize, replicant = mean(replicant, na.rm=TRUE), timeOriginal = mean(timeOriginal, na.rm=TRUE), Satisfiable = mean(Satisfiable, na.rm=TRUE))
