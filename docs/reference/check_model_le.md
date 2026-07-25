# Run model and check Life Expectancy against an expected value

Run model and check Life Expectancy against an expected value

## Usage

``` r
check_model_le(expected_le, ..., label = NULL)
```

## Arguments

- expected_le:

  The exact expected LE value.

- ...:

  Arguments passed to
  [`run_model()`](https://validate-hta.github.io/testhta/reference/run_model.md).

- label:

  A label for the test, passed to
  [`expect_equal()`](https://testthat.r-lib.org/reference/equality-expectations.html).

## Value

None, called for side effects (testthat assertion).

## Examples

``` r
data(test_data)
check_model_le(1, data = test_data, p_healthy_death = 1, p_sick_death = 1)
```
