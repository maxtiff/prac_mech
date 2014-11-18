library(caret)
library(foreach)
library(doSNOW)

## Load required scripts from workflow
required.scripts <- c('clean.R','error.R','filter.R')
sapply(required.scripts, source, .GlobalEnv)

cl <- makeCluster(2, type="SOCK")
registerDoSNOW(cl)

download <- function() {
  download.file("http://d396qusza40orc.cloudfront.net/predmachlearn/pml-training.csv", "training.csv")
  download.file("http://d396qusza40orc.cloudfront.net/predmachlearn/pml-testing.csv", "testing.csv")
}

read <- function(file) {
  fread(file, na.strings=c("#DIV/0!",""), stringsAsFactors = F)
}


build_report <- function() {
  knit2html("project.Rmd", "index.html")
}

download()

trainRaw <- read("training.csv")
testRaw <- read("testing.csv")

set.seed(1986)

## contains some NA values
naCols <- trainRaw[,sapply(.SD, function(x) any(is.na(x)))]

drop <- function(x) {
  x[,!c("V1", "user_name", "raw_timestamp_part_1", "raw_timestamp_part_2", "cvtd_timestamp", "new_window", "num_window"),with=F]
}

transform.features <- function(x) {
  x[,classe:=factor(classe)]
}

## try only columns that have values
trainFeatures <- drop(trainRaw[,eval(names(which(na.cols == F))),with=F])

# setwd('~/parc_mech/files')
# setwd('~/datasciencecoursera/parc_mech/files')

pml_write_files = function(x){
  n = length(x)
  for(i in 1:n){
    filename = paste0("problem_id_",i,".txt")
    write.table(x[i],file=filename,quote=FALSE,row.names=FALSE,col.names=FALSE)
  }
}