##############################################################################-
## Project: make_example
## Script purpose: generates data for example
## Date: 2019-07-30 
## Author: JP
##############################################################################-

# Packages, Parameters, & Data ####
library(magrittr)
library(tidyverse)

breadcrumbs::source_file_paths()

levels_am <- c("auto", "manual")
levels_vs <- c("v", "s")

ds_mtcars <- read_csv(file_ds_mt_raw)

# Munge ####
glimpse(ds_mtcars)

ds_mtcars %<>% 
  mutate(
    am = factor(am, labels = levels_am), 
    vs = factor(vs, labels = levels_vs, levels = levels_vs)
  )

write_rds(ds_mtcars, file_ds_mtcars)