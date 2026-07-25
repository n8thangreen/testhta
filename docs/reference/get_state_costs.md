# Getter for state costs

Getter for state costs

## Usage

``` r
get_state_costs(input, arm = NULL)
```

## Arguments

- input:

  A list of model parameters.

- arm:

  Optional treatment arm name (character) or index.

## Value

A vector of state costs for the specified arm, or the full cost matrix
if arm is NULL.

## Examples

``` r
data(test_data)
get_state_costs(test_data, "without_drug")
#> Asymptomatic_disease  Progressive_disease                 Dead 
#>                  500                 3000                    0 
```
