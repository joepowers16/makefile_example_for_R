##############################################################################-
## Project: make_example
## Script purpose: generates dataset with long name for example
## Date: 2019-07-30 
## Author: JP
##############################################################################-

# Packages, Parameters, & Data ####
library(magrittr)
library(tidyverse)

source(here::here("file_paths.R"))

ds_mtcars <- read_rds(file_ds_mtcars)

# Munge ####
ds_long <- 
	ds_mtcars %>% 
	group_by(am) %>% 
	summarise(
		mpg = mean(mpg),
		wt = mean(wt),
		mpg_sd = sd(mpg),
		wt_sd = sd(wt)
	) %>% 
	ungroup()

write_rds(ds_long, file_ds_long_name_to_demo_line_breaks)