context("Test Binomial Function")

test_that("bin_choose returns the right value", {
  expect_equal(bin_choose(n = 5, k = 2), 10)
  expect_equal(bin_choose(5, 0), 1)
  expect_equal(bin_choose(5, 1:3), c(5, 10, 10))
})

test_that("bin_choose returns an error", {
  expect_error(bin_choose(2, 5))
  expect_error(bin_choose(3, 1:5))
  expect_error(bin_choose(n = 1, k = 3))
})

test_that("bin_probability returns the right value", {
  expect_equal(bin_probability(success = 2, trials = 5, prob = 0.5), 0.3125)
  expect_equal(bin_probability(success = 0:2, trials = 5, prob = 0.5), c(0.03125, 0.15625, 0.31250))
  expect_equal(bin_probability(success = 55, trials = 100, prob = 0.45), 0.01075277)
})

test_that("bin_probability returns an error", {
  expect_error(bin_probability(5, 2, 0.5))
  expect_error(bin_probability(2, 5, 2))
  expect_error(bin_probability(2, 3.2, 3.2))
})

test_that("bin_distribution returns the right value", {
  expect_length(bin_distribution(trials = 5, prob = 0.5), 2)
  expect_equal(class(bin_distribution(trials = 5, prob = 0.5)), c("bindis", "data.frame"))
  expect_equal((bin_distribution(trials = 5, prob = 0.5))$success, 0:5)
  expect_equal((bin_distribution(trials = 5, prob = 0.5))$probability, c(0.03125, 0.15625, 0.31250, 0.31250, 0.15625, 0.03125))
})

test_that("bin_distribution returns an error", {
  expect_error(bin_distribution(5, 2))
  expect_error(bin_distribution(-1, 0.5))
  expect_error(bin_distribution(5, -1))
})

test_that("bin_cumulative returns the right value", {
  expect_length(bin_cumulative(trials = 5, prob = 0.5), 3)
  expect_equal(class(bin_cumulative(trials = 5, prob = 0.5)), c("bincum", "data.frame"))
  expect_equal((bin_cumulative(trials = 5, prob = 0.5))$success, 0:5)
  expect_equal((bin_cumulative(trials = 5, prob = 0.5))$probability, c(0.03125, 0.15625, 0.31250, 0.31250, 0.15625, 0.03125))
  expect_equal((bin_cumulative(trials = 5, prob = 0.5))$cumulative, c(0.03125, 0.18750, 0.50000, 0.81250, 0.96875, 1.00000))
})

test_that("bin_cumulative returns an error", {
  expect_error(bin_cumulative(5, 2))
  expect_error(bin_cumulative(-1, 0.5))
  expect_error(bin_cumulative(5, -1))
})
