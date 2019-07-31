##############################################################################-
## Project: Make File Example
## Script purpose: Makefile
## Date: 2019-07-29
## Author: Joe Powers 
## NOTE: If you're new to makefiles, please see end of document to get oriented
##############################################################################-  

##############################################################################
############################## DEFINE VARIABLES ##############################
##############################################################################

# define project subdirectories
RAW = ./cloud_make_example/data/raw
DAT = ./cloud_make_example/data
MUN = ./munge
ANL = ./analysis
REP = ./cloud_make_example/reports

# Search path
VPATH = $(RAW) $(DAT) $(MUN) $(ANL) $(REP)

# Command variables
REND = Rscript -e "rmarkdown::render('$<')"

# generate html report from Rmd file...
RENDER = Rscript -e "rmarkdown::render('$<')" 
# ... and move it to "reports" directory
RENDREP = $(RENDER); mv $(<:.Rmd=.html) $(REP)

# run Rmd scripts without generating report
KNIT = Rscript -e "knitr::knit('$<')" 

##############################################################################
############################## LIST OF TARGETS ###############################
##############################################################################

# Processed data files
DATA = ds_mtcars.rds ds_mt_agg.rds

# Reports
REPORTS = my_report.html

# All targets
all: $(DATA) $(REPORTS)
.PHONY: all

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
################################# GLOSSARY ###################################
##############################################################################

# makefiles are composed of recipes in the form:

# target: prerequisite_1 prerequisite_2 ... prerequisite_n
# [tab] command_1
# [tab] command_2
# [tab] ...
# [tab] command_n

The `target` is a desired output, such as a file containing a dataset or report.
A target from one recipe can become a prerequisite in another recipe. For 
instance, one recipe will generate clean data that is used in a later report. 
Those two actions should be accomplished in two recipes.

`prerequisites` are the data and scripts that generate a target. 
Prerequisites for one recipe can include one or many datasets and scripts.
The fiest prerequisite is typically the script that utilized the data files 
that follow. 

`commands` are shell commands that coordinate the prerequisites in order to 
create the target. The command section in most of my recipes is one item long, 
and executes the first prerequisite, which is usually a script. 

variables in GNU Make are created like this ...
VARNAME = something useful

... and called like this 
$(VARNAME)

The variable `VPATH` saves the search paths through which make should search for 
your target, prerequisite, and command files. 

# `Rscript` will execute an R script
# `$<` refers to the first prerequisite in the recipe

