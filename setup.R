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
#     install.packages(c("devtools", "roxygen2", "testthat", "knitr", "sinew"))

# The one I added addition to the standard R packages (2e) recommendations
# is sinew. It pragmatically adds Roxygen skeletons instead of needing to manually
# click through R studio menus. Depending on your organization's AI policy, in
# the real world generating roxygen skeletons and writing documentation is something
# I might give to Claude to handle the first draft

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

library(devtools)
library(usethis)
library(testthat)
library(sinew)

# Configuration settings ------------------------------------------------------
# (Record in the project settings that we're using the 3rd edition of testthat)
usethis::use_testthat()


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
# Each project will obviously have some unique dependencies, but it's probably
# also safe to assume that some commonly used package versions can be standardized
# e.g. dplyr. Any template may already come with pinned version of these common
# packages, but for example here's how unique packages would be added:

usethis::use_package("dplyr", min_version = packageVersion("dplyr") )


# Add new function ------------------------------------------------------------
# Let's create an example function based on the initial coding exercise
# It'd be cool to combine all these individual steps into a utitility function that
# creates the R file, adds the roxygen skeleton and creates tests

# Define function name
func_name <- "avgScoreByCohort"

# and its code (this is for reproducibility of the example
#               In the real world, we'd just write the function lol)
# Define the function as a single string with \n
func_string <- paste0(func_name, " <- function(df){\n\n  df <- df |> dplyr::group_by(cohort) |>\n    dplyr::summarise(score = mean(score, na.rm = TRUE))\n\n  df\n}")



# create an R file
usethis::use_r(func_name, open = FALSE)


# Write the function to the file
cat(func_string, file = paste0("R/", func_name, ".R"))


# Generate the roxygen skeleton using sinew
sinew::makeOxyFile(input = "R", overwrite = TRUE, verbose = FALSE)

# Manual edits.......
# Add description, parameter details, and examples, etc.

# Add tests -------------------------------------------------------
usethis::use_test(func_name)

# Let's manually edit the tests to check that the example data provided as part
# of the example matches the expected output
# Manual edits .......

# test the functions
devtools::test()

# Check the whole package
devtools::check()

# clean up of variables used for the example
remove(func_name, func_string)


# Website ----------------------------------------------------------------
# just for fun, let's build a website and then set it up to automatically update
# each push. For this we'll use Posit's bolierplates, in the real world, we'd probably
# use our own workflow files
# And configure access to only people inside our organization

# enable pkgdown
usethis::use_pkgdown()

# enable a website and deployment to github pages
usethis::use_pkgdown_github_pages()

# enable a github action to automatically update the website
usethis::use_github_action("pkgdown")

