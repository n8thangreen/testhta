# Getter for ICER

Getter for ICER

## Usage

``` r
get_icer(res)
```

## Arguments

- res:

  A list of results returned by ce_markov.

## Value

A numeric value representing the incremental cost-effectiveness ratio
(ICER).

## Examples

``` r
data(test_data)
res <- run_model(test_data)
get_icer(res)
#> [1] 14375.98
```
