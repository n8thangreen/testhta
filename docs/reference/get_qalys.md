# Getter for QALYs

Getter for QALYs

## Usage

``` r
get_qalys(res, arm = NULL)
```

## Arguments

- res:

  A list of results returned by ce_markov.

- arm:

  Optional treatment arm name or index.

## Value

A numeric vector of total QALYs by treatment, or a single numeric value
if arm is specified.

## Examples

``` r
data(test_data)
res <- run_model(test_data)
get_qalys(res)
#> without_drug    with_drug 
#>     9.048517     9.589129 
get_qalys(res, "with_drug")
#> with_drug 
#>  9.589129 
```
