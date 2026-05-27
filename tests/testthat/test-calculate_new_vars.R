test_that("NA values in PSA return an error", {

  df <- data.frame(psa = c(12, 4, 8, NA))

  expect_error(calculate_new_vars(df))



})
