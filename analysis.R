download <- function() {
  download.file("http://d396qusza40orc.cloudfront.net/predmachlearn/pml-training.csv", "training.csv")
  download.file("http://d396qusza40orc.cloudfront.net/predmachlearn/pml-testing.csv", "testing.csv")
}

read <- function(file) {
  fread(file, na.strings=c("#DIV/0!",""))
}

build_report <- function() {
  knit2html("project.Rmd", "index.html")
}

train <- read("training.csv")
test <- read("testing.csv")

set.seed(86)

