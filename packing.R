library(plyr)
library(rjson) #install these packages if necessary

#List all files matching the pattern in these directories. 
fileList <- list.files("/Users/Shelby/Research/CS-395/asp-competition-probs/packing/tests/test30",  full.names = TRUE, pattern = "-results1")

#The first line sets up a dataframe with no rows and four columns. The second is a list of the column names, and the third sets the names for the dataframe.
resultsFrame <- data.frame(matrix(ncol=4,nrow=0))
x <- c("FileName", "Squares", "Time", "Satisfiability")
colnames(resultsFrame) <- x

#Get the length of your file array, this should probably not be a magic number.
for(i in 1:length(fileList)){
  fileName = fileList[i]
  if(file.info(fileName)$size != 0){ #If the file is not empty
    JSONSolved <- rjson::fromJSON(file = fileName) #Load the JSON
    #print(JSONSolved[["sat"]])
    if(JSONSolved[[1]][["Result"]] == "SATISFIABLE"){
      satisfiability <- 1
    }
    else{
      satisfiability <- 0
    }
    squares <- JSONSolved[[2]][["Blocks"]]
    Time <- JSONSolved[[1]][["Time"]][["Total"]]
    #Temporarily load the above values into a new dataframe.
    tempFrame <- data.frame(fileName,squares,Time,satisfiability)
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
