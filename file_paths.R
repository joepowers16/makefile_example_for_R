dir_proj <- here::here()
dir_cloud <- here::here("cloud_makefile_example_for_R")
dir_data <- fs::path(dir_cloud, "data")
dir_raw <- fs::path(dir_data, "raw")
dir_reports <- fs::path(dir_cloud, "reports")

file_ds_mt_raw <- fs::path(dir_raw, "ds_mt_raw.csv")
file_ds_mtcars <- fs::path(dir_data, "ds_mtcars.rds")
file_ds_mt_agg <- fs::path(dir_data, "ds_mt_agg.rds")
file_ds_long_name_to_demo_line_breaks <- 
	fs::path(dir_data, "file_ds_long_name_to_demo_line_breaks.rds")
file_ds_mt_temp <- fs::path(dir_data, "ds_mt_temp.rds")