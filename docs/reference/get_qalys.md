# Getter for QALYs

Getter for QALYs

## Usage

``` r
get_qalys(res)
```

## Arguments

- res:

  A list of results returned by ce_markov.

## Value

A numeric vector of total QALYs by treatment.

## Examples

``` r
data(test_data)
res <- run_model(test_data)
get_qalys(res)
#> without_drug    with_drug 
#>     9.048517     9.589129 
```
