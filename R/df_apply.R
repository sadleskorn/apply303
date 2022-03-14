df_apply <- function(.data, .f, .condition=function(x) {TRUE}, .else=function(x) {x}, ...) {
  .data |>
    lapply(
      function(x) if( .condition(x)) .f(x, ...) else .else(x)
    ) |>
    as_tibble()
}
