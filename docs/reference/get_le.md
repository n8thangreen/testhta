# Getter for life expectancy (LE)

Getter for life expectancy (LE)

## Usage

``` r
get_le(res, arm = NULL)
```

## Arguments

- res:

  A list of results returned by ce_markov.

- arm:

  Optional treatment arm name or index.

## Value

A numeric vector of total life expectancy by treatment, or a single
numeric value if arm is specified.

## Examples

``` r
data(test_data)
res <- run_model(test_data)
get_le(res)
#> without_drug    with_drug 
#>     12.06416     12.68332 
get_le(res, "with_drug")
#> with_drug 
#>  12.68332 
```
