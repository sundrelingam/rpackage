#' @export
s3.character <- function(x) {
  print("S3 Character method dispatched.")
}

#' @export
s3.default <- function(x) {
  print("S3 Default method dispatched.")
}
