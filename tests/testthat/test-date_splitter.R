context("date_splitter: splits date into list")

date_list <- .date_splitter(x = "2019-01-01")

test_that("data type is correct", {
  expect_is(date_list, "list")
  expect_equal(names(date_list), c("year", "month", "day" ))
  expect_is(date_list$year, "integer")
  expect_is(date_list$month, "integer")
  expect_is(date_list$day, "integer")
})
