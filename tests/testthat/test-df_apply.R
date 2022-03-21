#' Unit tests for df_apply() function.
#'
##

test_that("df_apply works", {
  # Dataframe we will run tests on
  TestData <- tibble::tibble(
    u_char = c('A', 'B', 'C', 'D', 'E'),
    double = c(1.98, 2.30, 3.29, 4.37, 5.02),
    l_char = c('z', 'y', 'x', 'w', 'v'),
    factor = as.factor(c('red', 'orange', 'yellow', 'green', 'blue')),
    int = c(1, 2, 3, 4, 5)
  )

  # After running df_apply(TestData, round, is.numeric):
  TestRes_1 <- tibble::tibble(
    u_char = c('A', 'B', 'C', 'D', 'E'),
    double = c(2, 2, 3, 4, 5),
    l_char = c('z', 'y', 'x', 'w', 'v'),
    factor = as.factor(c('red', 'orange', 'yellow', 'green', 'blue')),
    int = c(1, 2, 3, 4, 5)
  )

  # After running df_apply(TestData, round, is.numeric, toupper, digits = 1):
  TestRes_2 <- tibble::tibble(
    u_char = c('A', 'B', 'C', 'D', 'E'),
    double = c(2.0, 2.3, 3.3, 4.4, 5.0),
    l_char = c('Z', 'Y', 'X', 'W', 'V'),
    factor = c('RED', 'ORANGE', 'YELLOW', 'GREEN', 'BLUE'),
    int = c(1, 2, 3, 4, 5)
  )

  # Apply to just a few columns of test df
  TestRes_3 <- tibble::tibble(
    double = c(16.96)
  )

  TestRes_4 <- tibble::tibble(
    l_char = c('z', 'y', 'x', 'w', 'v'),
    factor = factor(c('red', 'orange', 'yellow', 'green', 'blue')),
    int = c(3, 3, 3, 3, 3)
  )

  expect_equal(df_apply(TestData, round, is.numeric), TestRes_1)
  expect_equal(df_apply(TestData, round, is.numeric, toupper, digits = 1), TestRes_2)
  # ^ So this makes the factor column into a character column... are we worried about that?
  expect_equal(df_apply(TestData[2], sum, is.numeric), TestRes_3)
  expect_equal(df_apply(TestData[3:5], mean, is.numeric), TestRes_4)
})
