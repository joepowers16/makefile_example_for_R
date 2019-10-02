##############################################################################-
## Project: make_example
## Script purpose: generates data for example
## Date: 2019-07-30 
## Author: JP
##############################################################################-

# This line is a technique for suppressing warnings and messages when the script
# is exectued in make. I'm still weighing its value in terms of decluttering vs.
# hiding important warnings: 
suppressWarnings({suppressMessages({
	
# Packages, Parameters, & Data ####
suppressPackageStartupMessages(library(magrittr))
suppressPackageStartupMessages(library(tidyverse))

source(here::here("file_paths.R"))

levels_am <- c("auto", "manual")
levels_vs <- c("v", "s")

ds_mtcars <- read_csv(file_ds_mt_raw)

# Munge ####
ds_mtcars %<>% 
  mutate(
    am = factor(am, labels = levels_am), 
    vs = factor(vs, labels = levels_vs)
  )

write_rds(ds_mtcars, file_ds_mtcars)

})})