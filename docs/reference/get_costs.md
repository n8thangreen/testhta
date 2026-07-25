# Getter for costs

Getter for costs

## Usage

``` r
get_costs(res)
```

## Arguments

- res:

  A list of results returned by ce_markov.

## Value

A numeric vector of total costs by treatment.

## Examples

``` r
data(test_data)
res <- run_model(test_data)
get_costs(res)
#> without_drug    with_drug 
#>     9205.744    16977.576 
```
