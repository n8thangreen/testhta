# Run model and check Costs against an expected value

Run model and check Costs against an expected value

## Usage

``` r
check_model_costs(expected_costs, ..., label = NULL)
```

## Arguments

- expected_costs:

  The exact expected Cost value.

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
check_model_costs(0, data = test_data, c_healthy = 0, c_sick = 0, c_intervention = 0, c_death = 0)
```
