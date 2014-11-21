## Drops unnecessary columns
drop <- function(x) {
  return(x[,!c("V1", "user_name", "raw_timestamp_part_1", "raw_timestamp_part_2", "cvtd_timestamp", "new_window", "num_window"),with=F])
}

## Convert 'classe' column into factor type for processing.
transformFeatures <- function(x) {
  return(x[,classe:=factor(classe)])
}

filter <- function(df) {

  # Convert name of data frame into string to test for features in data.
  frameName <- deparse(substitute(df))

  # Remove any rows that contain NA values
  missing <- sapply(df, function(x) any(is.na(x)))
  df <- df[,eval(names(which(missing == FALSE))),with=F]

  # Drop unnecessary columns
  df <- drop(df)

  # Transform training-data-specific "classe" column into factor type.
  if (grepl("^(train)",frameName) == TRUE) {
  	if ("classe" %in% colnames(df)) {
  		transformFeatures(df)
  	}
  } else if (grepl("^(test)", frameName) == TRUE) {
  	#continue
  } else {
  	print("Check that the data frames are correctly labeled.")
  }

  return(df)
}
