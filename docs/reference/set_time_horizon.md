# Set time horizon

Set time horizon

## Usage

``` r
set_time_horizon(input, scenario, values)
```

## Arguments

- input:

  A list of model parameters.

- scenario:

  The scenario name or index, or values if scenario is omitted.

- values:

  The number of cycles (numeric).

## Value

The modified list of parameters.

## Examples

``` r
data(test_data)
updated <- set_time_horizon(test_data, 10)
```
