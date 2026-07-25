# Getter for life expectancy (LE)

Getter for life expectancy (LE)

## Usage

``` r
get_le(res)
```

## Arguments

- res:

  A list of results returned by ce_markov.

## Value

A numeric vector of total life expectancy by treatment.

## Examples

``` r
data(test_data)
res <- run_model(test_data)
get_le(res)
#> without_drug    with_drug 
#>     12.06416     12.68332 
```
