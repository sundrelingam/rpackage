#' An `s3` generic function
#' @md
#'
#' @details
#'   Even though the generic function is sourced after it's methods, there
#'   was no need to specify the collate order. These functions work as expected.
#'
#' @param x any R object
#' @export
s3 <- function(x) {
  UseMethod("s3")
}

