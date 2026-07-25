# Getter for state utilities

Getter for state utilities

## Usage

``` r
get_state_utilities(input, arm = NULL)
```

## Arguments

- input:

  A list of model parameters.

- arm:

  Optional treatment arm name (character) or index.

## Value

A vector of state utilities for the specified arm, or the full utility
matrix if arm is NULL.

## Examples

``` r
data(test_data)
get_state_utilities(test_data, "without_drug")
#> Asymptomatic_disease  Progressive_disease                 Dead 
#>                 0.95                 0.75                 0.00 
```
