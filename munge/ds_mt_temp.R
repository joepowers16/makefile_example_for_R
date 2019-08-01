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

# Munge ####
ds_mt_temp <- 
	ds_mtcars %>% 
	group_by(cyl) %>% 
	summarise(
		mpg = mean(mpg),
		wt = mean(wt),
		mpg_sd = sd(mpg),
		wt_sd = sd(wt)
	) %>% 
	ungroup()

write_rds(ds_mt_temp, file_ds_mt_temp)