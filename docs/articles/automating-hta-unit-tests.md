# Automating HTA Model Validation with Unit Tests

Health economic evaluations require rigorous validation to ensure that
structural logic, cost accounting, and transition probabilities behave
as expected. The `testhta` package provides a standardized framework to
validate cohort Markov models against established criteria, specifically
aligning with the tests outlined in the HTA Verification Registry (T01 -
T16).

To make implementation as frictionless as possible, `testhta` includes
scaffolding functions that instantly generate a comprehensive test suite
tailored to your specific model data.

## Setting Up Your Test Environment

If you are starting a new cost-effectiveness analysis (CEA) project or
retrofitting an existing one, you can automatically generate the
necessary testing infrastructure using the
[`use_hta_unittests()`](https://validate-hta.github.io/testhta/reference/use_hta_unittests.md)
function.

This function creates the standard `tests/testthat/` directory structure
required by the `testthat` package and injects a pre-configured test
script.

### Generating the Skeleton

In your R console, simply run:

``` r

library(testhta)

# Generate the default test skeleton
use_hta_unittests()
```

By default, this creates a file named `test-hta_model.R` that utilizes a
placeholder data object named `test_data`.

### Customizing the Data Reference

In practice, your CEA model parameters will likely be stored in a custom
list or data frame. You can map the generated tests directly to your
project’s naming conventions using the `data_name` argument.

For example, if your baseline parameters are stored in an object called
`basecase_params`, you can run:

``` r

use_hta_unittests(data_name = "basecase_params")
```

The resulting test script will automatically substitute all internal
references, ensuring tests like the one below are immediately
executable:

``` r

test_that("T01: QALYs with discount_rate = 1 should be 0", {
  check_model_qalys(
    data = basecase_params, 
    discount_rate = 1, 
    expected_qalys = 0,
    label = "T01: QALYs with discount_rate = 1 should be 0"
  )
})
```

## The Verification Registry Suite

The generated skeleton includes programmatic checks for 16 standardized
HTA validation tests, categorized into four core areas. For the complete
test matrix, detailed descriptions, and code examples, see the dedicated
[**HTA Verification Framework
Vignette**](https://validate-hta.github.io/testhta/articles/verification-framework.html)
(`vignettes/verification-framework.Rmd`).

## Executing the Test Suite

Once your helper functions are defined and your parameter object is
loaded into the environment, you can execute the validation suite.

**Command Line Execution:** You can run the entire suite from the R
console using the `devtools` package:

``` r

devtools::test()
```

**IDE Integration:** If your programming workflow relies on Positron or
VS Code, you can leverage their integrated testing environments. Both
IDEs automatically detect `testthat` files, allowing you to run, debug,
and track the success of individual T01-T16 test blocks directly from
the testing pane without manually executing console commands.
