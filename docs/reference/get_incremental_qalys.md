# Getter for incremental QALYs

Getter for incremental QALYs

## Usage

``` r
get_incremental_qalys(res)
```

## Arguments

- res:

  A list of results returned by ce_markov.

## Value

A numeric value of incremental QALYs (arm 2 minus arm 1).

## Examples

``` r
data(test_data)
res <- run_model(test_data)
get_incremental_qalys(res)
#> with_drug 
#> 0.5406124 
```
