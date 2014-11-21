drop <- function(x) {
  return(x[,!c("V1", "user_name", "raw_timestamp_part_1", "raw_timestamp_part_2", "cvtd_timestamp", "new_window", "num_window"),with=F])
}

transformFeatures <- function(x) {
  return(x[,classe:=factor(classe)])
}

filter <- function(data) {
	# Remove NA values
  keep <- !sapply(data,function(x) any(is.na()))
  data <- data[,keep]

  # Drop unnecessary columns
  data <- drop(data)

  # Convert name of data frame into string to test for features in data.
  frameName <- deparse(substitute(data))

  # Transform training-data-specific "classe" column into factor class of variable.
  if (grepl("^(train)",frameName) == TRUE) {
  	if ("classe" in colnames(data)) {
  		transformFeatures(data)
  	}
  } else if (grepl("^(test)", frameName) == TRUE) {
  	#continue
  } else {
  	print("Check that the names of your data frames are correctly labeled.")
  }

  return(data)
}