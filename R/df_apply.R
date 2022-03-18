#' Apply a function to a data frame
#'
#' @param .data A data frame
#' @param .f A function you would like to apply to a column(s) of the data frame
#' @param .condition A condition that column must have to apply the function
#' @param .else If the condition fails, a second function to apply
#' @param ... Allows for arguments to be passed into .f
#'
#' @return A data frame
#' @importFrom tibble as_tibble
#' @export
#'
#' @examples
#' n <- 7L
#' TestData <-
#'  tibble::tibble( double = rnorm(n, 100, 10),
#'          x = 123400 / 10^(1L:n),
#'          integer = (1L:n) * (1L:n),    # ^2 would return a double!!
#'          character = LETTERS[1L:n],
#'          factor = factor(letters[1L:n]),
#'          logical = rep(c(TRUE, FALSE), length.out = n) )
#' df_apply(TestData, round, is.numeric, toupper, digits = 1)
#'
#' data(medals_per_event)
#' df_apply(medals_per_event, tolower, function(x){!is.numeric(x)})
##
df_apply <- function(.data, .f, .condition=function(x) {TRUE}, .else=function(x) {x}, ...) {
  .data |>
    lapply(
      function(x) if( .condition(x)) .f(x, ...) else .else(x)
    ) |>
    tibble::as_tibble()
}
