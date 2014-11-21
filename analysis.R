## Set working dir
setwd("~/datasciencecoursera/prac_mech")

## Load required libraries for analysis
library(caret)
library(foreach)
library(doSNOW)
library(data.table)
library(knitr)

## Load required scripts from workflow
required.scripts <- c('clean.R','error.R','download.R','submission.R', 'buildRMD.R')
sapply(required.scripts, source, .GlobalEnv)

## Create computing clusters from processor cores
cl <- makeCluster(4, type="SOCK")
registerDoSNOW(cl)


## download files
download()

## Load files into environment
trainRaw <- read("training.csv")
testRaw <- read("testing.csv")

set.seed(1986)

## Remove any columns that contain some NA values or are blank. Convert 'classe'
## column in training data frame to factor type.
trainFeatures <- filter(trainRaw)
testFeatures <- filter(testRaw)

## Build models
control <- trainControl(method = "cv", number = 5, allowParallel = TRUE,
                        verboseIter = TRUE)
model1 <- train(classe ~ ., data=trainFeatures, method = "rf", trControl = control)
model2 <- train(.outcome ~ ., data=trainFeatures, method = "svmRadial", trControl = control)
model3 <- train(.outcome ~ ., data=trainFeatures, method="knn", trControl = control)

## Create table of accuracy statistics
accuracy <- data.frame(Model=c("Random Forest", "SVM (radial)", "KNN"),
                      Accuracy=c(round(max(head(model1$results)$Accuracy), 3),
                                 round(max(head(model2$results)$Accuracy), 3),
                                 round(max(head(model3$results)$Accuracy), 3)))

# kable(accuracy)

## Run predictions of each model on test data
prediction1 <- predict(model1, testFeatures)
prediction2 <- predict(model2, testFeatures)
prediction3 <- predict(model3, testFeatures)

## Create data frame of predictions for submission
predictions <- data.frame(rf = prediction1, svm = prediction2, knn = prediction3)
predictions$agree <- with(predictions, rf == svm && rf == knn)
agree <- all(predictions$agree)

colnames(predictions) <- c("Random Forest", "SVM", "KNN", "Agreement")
# kable(predictions)


answers <- predictions[,1]

# setwd('~/parc_mech/files')
setwd('~/datasciencecoursera/prac_mech/files')

## Write files for submission
pml_write_files(answers)

## Write report for submission
buildReport()
