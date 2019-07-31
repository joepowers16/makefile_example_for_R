##############################################################################-
## Project: make_example
## Script purpose: generates raw data for example
## Date: 2019-07-31 
## Author: JP
##############################################################################-

breadcrumbs::source_file_paths()

ds_mtcars <- mtcars

write.csv(ds_mtcars, file_ds_mt_raw)