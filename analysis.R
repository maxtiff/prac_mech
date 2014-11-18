library(caret)
library(foreach)
library(doSNOW)

## Load required scripts from workflow
required.scripts <- c('clean.R','error.R','filter.R','download.R','submisson.R')
sapply(required.scripts, source, .GlobalEnv)

cl <- makeCluster(4, type="SOCK")
registerDoSNOW(cl)


## download files
download()

## Load files into environment
trainRaw <- read("training.csv")
testRaw <- read("testing.csv")

set.seed(1986)

## contains some NA values
naCols <- trainRaw[,sapply(.SD, function(x) any(is.na(x)))]

## try only columns that have values
trainFeatures <- drop(trainRaw[,eval(names(which(na.cols == F))),with=F])

answers <- predictions

# setwd('~/parc_mech/files')
# setwd('~/datasciencecoursera/parc_mech/files')

## Write files for submission
pml_write_files(predictions)

## Write report for submission
buildReport()
