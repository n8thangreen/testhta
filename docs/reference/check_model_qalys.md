# Run model and check QALYs against an expected value

Run model and check QALYs against an expected value

## Usage

``` r
check_model_qalys(expected_qalys, ..., label = NULL)
```

## Arguments

- expected_qalys:

  The exact expected QALY value.

- ...:

  Arguments passed to
  [`run_model()`](https://validate-hta.github.io/testhta/reference/run_model.md)
  (e.g., data, discount_rate).

- label:

  A label for the test, passed to
  [`expect_equal()`](https://testthat.r-lib.org/reference/equality-expectations.html).

## Value

None, called for side effects (testthat assertion).

## Examples

``` r
data(test_data)
check_model_qalys(0, data = test_data, u_healthy = 0, u_sick = 0)
```
