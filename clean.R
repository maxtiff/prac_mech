drop <- function(x) {
  x[,!c("V1", "user_name", "raw_timestamp_part_1", "raw_timestamp_part_2", "cvtd_timestamp", "new_window", "num_window"),with=F]
}

transformFeatures <- function(x) {
  x[,classe:=factor(classe)]
}