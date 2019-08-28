context("get_columns_xml: builds xml string")

test_xml <- .get_columns_xml(report = "report_type", columns = c("col1", "col2", "col3"))

test_that("data type is correct", {
  expect_is(test_xml, "character")
  expect_equal(nchar(test_xml), 129)
})
