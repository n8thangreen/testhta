# Getter for incremental QALYs

Getter for incremental QALYs

## Usage

``` r
get_incremental_qalys(res, arm1 = "without_drug", arm2 = "with_drug")
```

## Arguments

- res:

  A list of results returned by ce_markov.

- arm1:

  Baseline treatment arm name or index (default: "without_drug").

- arm2:

  Comparator treatment arm name or index (default: "with_drug").

## Value

A numeric value of incremental QALYs (arm 2 minus arm 1).

## Examples

``` r
data(test_data)
res <- run_model(test_data)
get_incremental_qalys(res)
#> [1] 0.5406124
```
