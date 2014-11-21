## error() uses tryCatch() to handle errors that may occur when processing data
error <- function(expression) {
#   tryCatch({
#     #expression
#   }, warning = function(w) {
#     #warning-handler-code
#   }, error = function(e) {
#     #error-handler-code
#   }, finally = {
#     #cleanup-code
#   }
}