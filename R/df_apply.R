df_apply <- function(.data, .f, .condition, .else = return(.data), ...) {
  .data |>
    lapply(
      function(x) if( .condition(x)) .f(x, ...) else .else(x, ...)
    ) |>
    as_tibble()
}
