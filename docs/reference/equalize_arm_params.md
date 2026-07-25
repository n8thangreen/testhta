# Equalize treatment-specific parameters across arms

Equalize treatment-specific parameters across arms

## Usage

``` r
equalize_arm_params(input, from_arm = "without_drug", to_arm = "with_drug")
```

## Arguments

- input:

  A list of model parameters.

- from_arm:

  The source arm name or index.

- to_arm:

  The target arm name or index.

## Value

The modified list of parameters with identical inputs for both arms.

## Examples

``` r
data(test_data)
updated <- equalize_arm_params(test_data, "without_drug", "with_drug")
```
