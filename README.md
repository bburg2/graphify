
<!-- README.md is generated from README.Rmd. Please edit that file -->

# graphify

<!-- badges: start -->
<!-- badges: end -->

The goal of graphify is to make a few graphs for an erasmusladder
project.

## Installation

You can install the development version of graphify from
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("bburg2/graphify")
```

## Example

This is a basic example which shows you how to solve a common problem:

``` r
library(graphify)
#> Loading required package: tidyverse
#> ── Attaching packages ─────────────────────────────────────── tidyverse 1.3.1 ──
#> ✔ ggplot2 3.3.5     ✔ purrr   0.3.4
#> ✔ tibble  3.1.6     ✔ dplyr   1.0.8
#> ✔ tidyr   1.2.0     ✔ stringr 1.4.0
#> ✔ readr   2.1.2     ✔ forcats 0.5.1
#> ── Conflicts ────────────────────────────────────────── tidyverse_conflicts() ──
#> ✖ dplyr::filter() masks stats::filter()
#> ✖ dplyr::lag()    masks stats::lag()
library(readr)
library(here)
#> here() starts at C:/Users/Bas/Desktop/School/Programmeren/datascience/graphify
library(tidyverse)
library(dplyr)
library(plotly)
#> 
#> Attaching package: 'plotly'
#> The following object is masked from 'package:ggplot2':
#> 
#>     last_plot
#> The following object is masked from 'package:stats':
#> 
#>     filter
#> The following object is masked from 'package:graphics':
#> 
#>     layout

# load in some data
## data_time <- read_csv(here("data", "data.csv"))

# Graph for Average trail duration per session per genotype
## time_graph(data_time, column = quo(`Trial duration(s)`), "Average trail duration per session per genotype", "Duration (s)")
```
