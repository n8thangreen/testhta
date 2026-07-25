# Getter for incremental costs

Getter for incremental costs

## Usage

``` r
get_incremental_costs(res, arm1 = "without_drug", arm2 = "with_drug")
```

## Arguments

- res:

  A list of results returned by ce_markov.

- arm1:

  Baseline treatment arm name or index (default: "without_drug").

- arm2:

  Comparator treatment arm name or index (default: "with_drug").

## Value

A numeric value of incremental cost (arm 2 minus arm 1).

## Examples

``` r
data(test_data)
res <- run_model(test_data)
get_incremental_costs(res)
#> [1] 7771.831
```
