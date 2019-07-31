##############################################################################-
## Project: Make File Example
## Script purpose: Makefile
## Date: 2019-07-29
## Author: Joe Powers 
## NOTE: If you're new to makefiles, please see APPENDIX at end of document and
## and the README to get oriented.
##############################################################################-  

##############################################################################
############################## DEFINE VARIABLES ##############################
##############################################################################

# define project subdirectories
RAW = ./cloud_makefile_example_for_R/data/raw
DAT = ./cloud_makefile_example_for_R/data
MUN = ./munge
ANL = ./analysis
REP = ./cloud_makefile_example_for_R/reports

# Search path
VPATH = $(RAW) $(DAT) $(MUN) $(ANL) $(REP)

# generate html report from Rmd file...
REND = Rscript -e "rmarkdown::render('$<')" 
# ... and move it to "reports" directory
RENDREP = $(REND); mv $(<:.Rmd=.html) $(REP)

# run Rmd scripts without generating report
KNIT = Rscript -e "knitr::knit('$<')" 

##############################################################################
############################## LIST OF TARGETS ###############################
##############################################################################

# Processed data files
DATA = ds_mtcars.rds ds_mt_agg.rds ds_long_name_to_demo_line_breaks.rds

# Reports
REPORTS = my_report.html another_report.html

# All targets
all: $(DATA) $(REPORTS)

##############################################################################
################################# MUNGE DATA #################################
##############################################################################

ds_mt_raw.csv: ds_mt_raw.R
	Rscript $<
	
ds_mtcars.rds: ds_mtcars.R ds_mt_raw.csv
	Rscript $<
	
ds_mt_agg.rds: ds_mt_agg.Rmd ds_mtcars.rds
	$(KNIT)
	
ds_long_name_to_demo_line_breaks.rds: ds_long_name_to_demo_line_breaks.R \
ds_mtcars.rds
	Rscript $<
	
##############################################################################
################################## ANALYSIS ##################################
##############################################################################

my_report.html: my_report.Rmd ds_mtcars.rds
	$(RENDREP)
	
another_report.html: another_report.Rmd ds_long_name_to_demo_line_breaks.rds \
ds_mt_agg.rds ds_mtcars.rds
	$(RENDREP)

##############################################################################
################################# APPENDIX ###################################
##############################################################################

# You can execute this makefile from any computer that has make installed 
# (i.e., every Mac or Unix machine) simply by changing your working directory 
# to the directory containing this makefile and typing "make" in the terminal. 

# Makefiles explicitly coordinate file dependencies through `recipes`. 

# Recipes take the form:

# target: prerequisite_1 prerequisite_2 ... prerequisite_n
# [tab] command_1
# [tab] command_2
# [tab] ...
# [tab] command_n

# The `target` is a desired output, such as a file containing a dataset or 
# report. A target from one recipe can become a prerequisite in another recipe. 
# For instance, one recipe will generate clean data that is used in a later 
# report. Those two actions should be accomplished in two recipes.
# 
# `prerequisites` are the data and scripts that generate a target. 
# Prerequisites for one recipe can include one or many datasets and scripts.
# The fiest prerequisite is typically the script that utilized the data files 
# that follow. 
# 
# `commands` are shell commands that coordinate the prerequisites in order to 
# create the target. The command section in most of my recipes is one item long, 
# and executes the first prerequisite, which is usually a script. 
# 
#`commands` must be indented with *tabs* and not *spaces*. 
# If you are working in an RStudio project, go to Tools/Project Options and 
# make sure that "Insert Spaces for Tab" is unchecked. If you are not working 
# in an Rproject, uncheck "Insert Spaces for Tab" from Tools/Global Options.
# 
# `variables` in GNU Make are created like this ...
# VARNAME = something useful
# ... and `variables` are called like this 
# $(VARNAME)
# 
# The special variable `VPATH` saves the search paths through which make should search for 
# your target, prerequisite, and command files. 

# `Rscript` will execute an R script
# `$<` is a wildcard that refers to the first prerequisite in the recipe
