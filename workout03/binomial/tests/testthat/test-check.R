context("Test check functions")

test_that("check_prob has a valid input probability value",{

  expect_true(check_prob(0))
  expect_true(check_prob(1))
  expect_true(check_prob(0.5))
})

test_that("check_prob has a invalid input probability value",{

  expect_error(check_prob(-1))
  expect_error(check_prob(2))
  expect_error(check_prob(1.1))
})

test_that("check_trials has a valid input of number of trails",{

  expect_true(check_trials(0))
  expect_true(check_trials(1))
  expect_true(check_trials(10))
})

test_that("check_trials has a invalid input of number of trails",{

  expect_error(check_trials(-1))
  expect_error(check_trials(1.6))
  expect_error(check_trials(2.1))
})

test_that("check_success has a valid input of number of success",{

  expect_true(check_success(1, 2))
  expect_true(check_success(0, 10))
  expect_true(check_success(10, 10))
  expect_true(check_success(c(1,2,3), 3))
})

test_that("check_success has a invalid input of number of success",{

  expect_error(check_success(2, 1))
  expect_error(check_success(2, -1))
  expect_error(check_success(1.1, 10))
  expect_error(check_success(c(1,2,3), 2))
})
