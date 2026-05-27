
test_that("avgScoreByCohort calculates correct means and drops NAs", {

  # expected input
  input_df <- data.frame(
    cohort = c("A", "A", "B", "B", "A"),
    score  = c(10, 15, 20, 5, NA)
  )

  # expected output
  expected_df <- data.frame(
    cohort = c("A", "B"),
    score  = c(12.5, 12.5)
  )

  # Run the function
  result <- avgScoreByCohort(input_df)

  # compare expected to actual results
  expect_equal(result, expected_df)
})
