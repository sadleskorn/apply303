#' R file to run unit tests.
#'
#' Loads testthat and runs test_check on the apply303 package.
##

library(testthat)
library(apply303)

test_check("apply303")
