download <- function() {
  download.file("http://d396qusza40orc.cloudfront.net/predmachlearn/pml-training.csv", "training.csv")
  download.file("http://d396qusza40orc.cloudfront.net/predmachlearn/pml-testing.csv", "testing.csv")
}