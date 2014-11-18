library(caret)
library(foreach)
library(doSNOW)

## Load required scripts from workflow
required.scripts <- c('clean.R','error.R','filter.R','download.R','submisson.R')
sapply(required.scripts, source, .GlobalEnv)

cl <- makeCluster(2, type="SOCK")
registerDoSNOW(cl)



read <- function(file) {
  fread(file, na.strings=c("#DIV/0!",""), stringsAsFactors = F)
}




## download files
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

answers <- predictions

# setwd('~/parc_mech/files')
# setwd('~/datasciencecoursera/parc_mech/files')

pml_write_files(predictions)

buildReport()
