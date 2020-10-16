#' @title Installed but Not Attached
#' @md
#' @description
#'   Installed with the package via `Import` in `DESCRIPTION` but the
#'   function is called from the package without attaching the package.
#' @note
#'   Expect it to error out.
#' @export
installed_not_attached <- function() {
  as_tibble(mtcars)
}

#' @title Installed and Attached when Called
#' @md
#' @description
#'   Installed with the package via `Import` in `DESCRIPTION` and
#'   package search path specified with `::` when function called.
#' @export
installed_and_attached <- function() {
  tibble::as_tibble(mtcars)
}

#' @title Installed and Dependent but not Attached when Called
#' @md
#' @description
#'   Installed with the package via `Import` in `DESCRIPTION` and
#'   package search path specified with `::` when function called.
#' @note
#'   Does not error out. The user can also use this package directly.
#'   For example, try `mtcars  %>% select(disp)` without a `library` call.
#'
#'   It doesn't find the function in the package namespace, but it works
#'   because it eventually looks up the function in the user's search path
#'   (in which `dplyr` is attached). But you would rather use `@import` here
#'   (see \link{installed_and_imported}) unless you want the *user* to
#'   have the ability to use `dplyr` without explicitly attaching.
#' @export
installed_and_dependent <- function() {
  mtcars  %>% select(disp)
}

#' @title Installed and Imported to `NAMESPACE`
#' @md
#' @description
#'   Installed with the package via `Import` in `DESCRIPTION` and
#'   packaged added to the `NAMESPACE` by `@import`. Function from
#'   package is called without `::`.
#' @note
#'   Expect this to work. But the user can't use the functions without
#'   attaching the package (in this case `tidyr`). Try `drop_na(mtcars)`.
#' @import tidyr
#' @export
installed_and_imported <- function() {
  drop_na(mtcars)
}
