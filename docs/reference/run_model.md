# Run Markov model with parameters and overrides

Run Markov model with parameters and overrides

## Usage

``` r
run_model(data, ...)
```

## Arguments

- data:

  A list of base parameters.

- ...:

  Overrides for parameters or helper arguments.

## Value

A list of model simulation results.

## Examples

``` r
data(test_data)
res <- run_model(test_data, discount_rate = 0.05)
```
