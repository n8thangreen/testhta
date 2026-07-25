# Getter for transition probability matrix

Getter for transition probability matrix

## Usage

``` r
get_transition_matrix(input, arm = NULL)
```

## Arguments

- input:

  A list of model parameters.

- arm:

  Optional treatment arm name (character) or index.

## Value

A matrix of transition probabilities for the specified arm, or the 3D
array if arm is NULL.

## Examples

``` r
data(test_data)
get_transition_matrix(test_data, "without_drug")
#>                       to
#> from                   Asymptomatic_disease Progressive_disease   Dead
#>   Asymptomatic_disease               0.9521              0.0100 0.0379
#>   Progressive_disease                0.0000              0.8121 0.1879
#>   Dead                               0.0000              0.0000 1.0000
```
