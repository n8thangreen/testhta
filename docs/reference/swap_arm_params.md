# Swap treatment-specific parameters between two arms

Swap treatment-specific parameters between two arms

## Usage

``` r
swap_arm_params(input, arm1 = "without_drug", arm2 = "with_drug")
```

## Arguments

- input:

  A list of model parameters.

- arm1:

  Name or index of the first treatment arm.

- arm2:

  Name or index of the second treatment arm.

## Value

The modified list of parameters with swapped inputs.

## Examples

``` r
data(test_data)
updated <- swap_arm_params(test_data, "without_drug", "with_drug")
```
