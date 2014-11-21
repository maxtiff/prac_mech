drop <- function(x) {
  return(x[,!c("V1", "user_name", "raw_timestamp_part_1", "raw_timestamp_part_2", "cvtd_timestamp", "new_window", "num_window"),with=F])
}

transformFeatures <- function(x) {
  x[,classe:=factor(classe)]
}

filter <- function(data) {

  keep <- !sapply(data,function(x) any(is.na()))

  data <- data[,keep]



}