##############################################################################-
## Project: make_example
## Script purpose: generates raw data for example
## Date: 2019-07-31 
## Author: JP
##############################################################################-

# Packages, Parameters, & Data ####
suppressPackageStartupMessages(library(magrittr))
suppressPackageStartupMessages(library(tidyverse))

source(here::here("file_paths.R"))

ds_mtcars <- read_rds(file_ds_mtcars)
ds_mt_agg <- read_rds(file_ds_mt_agg)

# Munge ####
ds_mt_temp <- left_join(ds_mtcars, ds_mt_agg, by = "cyl")

write_rds(ds_mt_temp, file_ds_mt_temp)