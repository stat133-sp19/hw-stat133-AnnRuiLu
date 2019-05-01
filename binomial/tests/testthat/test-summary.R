context("Test Summary Function")

test_that("aux_mean returns the right mean",{

  expect_equal(aux_mean(10, 0.3), 3)
  expect_equal(aux_mean(20, 0.9), 18)
  expect_equal(aux_mean(2, 1), 2)
  expect_equal(aux_mean(10, 0), 0)
})

test_that("aux_variance returns the right variance",{

  expect_equal(aux_variance(10, 0.3), 2.1)
  expect_equal(aux_variance(20, 0.9), 1.8)
  expect_equal(aux_variance(2, 1), 0)
  expect_equal(aux_variance(10, 0), 0)
})

test_that("aux_mode returns the right mode",{

  expect_equal(aux_mode(10, 0.3), 3)
  expect_equal(aux_mode(20, 0.9), 18)
  expect_equal(aux_mode(3, 0.5), c(2, 1))
})

test_that("aux_skewness returns the right skewness",{

  expect_equal(aux_skewness(10, 0.3), 0.2760262, tolerance=1e-7)
  expect_equal(aux_skewness(20, 0.9), -0.5962848, tolerance=1e-7)
  expect_equal(aux_skewness(3, 0.5), 0)
})

test_that("aux_kurtosis returns the right kurtosis",{

  expect_equal(aux_kurtosis(10, 0.3), -0.1238095, tolerance=1e-7)
  expect_equal(aux_kurtosis(20, 0.9), 0.2555556, tolerance=1e-7)
  expect_equal(aux_kurtosis(3, 0.5), -0.6666667, tolerance=1e-7)
})
