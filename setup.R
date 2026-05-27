# Setup a data processing workflow as an R package
#
# This script contains the r commands used to setup a standard data processing
# pipeline as an R package. In enterprise environment, it'd be really cool to
# create a github template repository with these steps already completed, but
# I thought for the purposes of demonstration, it'd be nice to walk through the
# individual steps

# Session info -------------------------------------------------------------------
# sessionInfo()
#>R version 4.5.2 (2025-10-31)
#>Platform: x86_64-pc-linux-gnu
#>Running under: Ubuntu 26.04 LTS

#>Matrix products: default
#>BLAS:   /usr/lib/x86_64-linux-gnu/openblas-pthread/libblas.so.3
#>LAPACK: /usr/lib/x86_64-linux-gnu/openblas-pthread/libopenblasp-r0.3.32.so;  LAPACK version 3.12.0

#>locale:
#>  [1] LC_CTYPE=en_US.UTF-8       LC_NUMERIC=C               LC_TIME=en_US.UTF-8
#>[4] LC_COLLATE=en_US.UTF-8     LC_MONETARY=en_US.UTF-8    LC_MESSAGES=en_US.UTF-8
#>[7] LC_PAPER=en_US.UTF-8       LC_NAME=C                  LC_ADDRESS=C
#>[10] LC_TELEPHONE=C             LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C

#> time zone: UTC
#> tzcode source: system (glibc)

#>attached base packages:
#>  [1] stats     graphics  grDevices utils     datasets  methods   base

#>loaded via a namespace (and not attached):
#>  [1] compiler_4.5.2 tools_4.5.2

# Dependencies ----------------------------------------------------------------
# Most dependencies will be managed using the R package DESCRIPTION file. This
# section loads the packages used for setting up the package infrastructure
# This workflow closely follows the one described in R packages(2e):
# https://r-pkgs.org/

# How these dependencies should be installed is probably best determined on
# case-by-case basis depending on the user and the environment. To install them
# locally on a personal laptop you can use the following:
#     install.packages(c("devtools", "roxygen2", "testthat", "knitr"))

# Load packages ---------------
# These packages are used for creating an R package and implementing features
# such as testing and documentation

# (An aside about my philosophy about namespaces in R: I like to load libraries normally
#  using library() AND refer to them by their::namespace() I think the slight performance
#  hit is worth the additional clarity and reduced risk of namespace conflict.
# This is also the recommended method for package development)

# (Another aside: For similar reasons I load tidyverse and devtools packages
# individual instead of by loading the metapackage
#    e.g. library(dplyr) instead of  library(tidyverse)   )

library(usethis)


# I'm including these steps to show what steps I used. In retrospect I really don't
# like this approach. In the future I'd switch to using a github template with an
# R package skeleton already created then some sort of action to update files with
# the new package name

# delete the .Rproj file to disable the warning
list.files(pattern = "\\.Rproj$") |>
   file.remove()

# create the package from one level up
usethis::create_package("../PackagesDemo")


# Add packages ----------------------------------------------------------------
# Each project will obviosly have some unique dependencies, but it's probably
# also safe to assume that some commonly used package versions can be standardized
# e.g. dplyr. Any template may already come with pinned version of these common
# packages, but for example here's how unique packages would be added:

usethis::use_package("dplyr", min_version = packageVersion("dplyr") )





