# Getter for incremental costs

Getter for incremental costs

## Usage

``` r
get_incremental_costs(res)
```

## Arguments

- res:

  A list of results returned by ce_markov.

## Value

A numeric value of incremental cost (arm 2 minus arm 1).

## Examples

``` r
data(test_data)
res <- run_model(test_data)
get_incremental_costs(res)
#> with_drug 
#>  7771.831 
```
