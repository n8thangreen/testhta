# Getter for treatment arm names

Getter for treatment arm names

## Usage

``` r
get_arm_names(input)
```

## Arguments

- input:

  A list of parameters or model results.

## Value

A character vector of treatment arm names.

## Examples

``` r
data(test_data)
get_arm_names(test_data)
#> [1] "without_drug" "with_drug"   
```
