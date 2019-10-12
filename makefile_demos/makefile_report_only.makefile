##############################################################################-
## Project: Make File Example
## Script purpose: Makefile
## Date: 2019-07-29
## Author: Joe Powers 
## NOTE: If you're new to makefiles, please see APPENDIX at end of document and
## and the README to get oriented.
##############################################################################-  

# This makefile shows that limiting all to REPORT_TARGETS lead to rebuilds of reports even when DATA_TARGET dependencies were changed. 

##############################################################################
############################## DEFINE VARIABLES ##############################
##############################################################################

# define project subdirectories
DIR_PROJECT = ./
DIR_MUNGE = ./munge
DIR_ANALYSIS = ./analysis
DIR_DATA = ./data
DIR_RAW = $(DIR_DATA)/raw
DIR_REPORTS = ./reports

# Search path
VPATH = $(DIR_RAW) $(DIR_DATA) $(DIR_MUNGE) $(DIR_ANALYSIS) $(DIR_REPORTS) \
$(DIR_PROJECT)

# generate html report from Rmd file
RENDER = Rscript -e "rmarkdown::render('$<')" 
# generate html report from Rmd file and move it to "reports" directory
RENDER_TO_REPORTS = $(RENDER); mv $(<:.Rmd=.html) $(DIR_REPORTS)
# execute Rmd file without generating report
SOURCE_RMD_NO_REPORT = Rscript -e 'knitr::knit("$<", output = tempfile())'

##############################################################################
################################## ANALYSIS ##################################
##############################################################################
	
another_report.html: another_report.Rmd ds_long_name_to_demo_line_breaks.rds \
ds_mt_temp.rds
	$(RENDER_TO_REPORTS)
	
my_report.html: my_report.Rmd ds_mtcars.rds
	$(RENDER_TO_REPORTS)
	
##############################################################################
################################# MUNGE DATA #################################
##############################################################################
	
ds_mtcars.rds: ds_mtcars.R ds_mt_raw.csv
	Rscript $<
	
ds_mt_agg.rds: ds_mt_agg.Rmd ds_mtcars.rds
	$(SOURCE_RMD_NO_REPORT)
	
ds_mt_temp.rds: ds_mt_temp.R ds_mtcars.rds ds_mt_agg.rds
	Rscript $<
	
ds_long_name_to_demo_line_breaks.rds: ds_long_name_to_demo_line_breaks.R \
ds_mtcars.rds
	Rscript $<

##############################################################################
############################## LIST OF TARGETS ###############################
##############################################################################
# Processed data files
DATA_TARGETS = ds_mtcars.rds ds_mt_agg.rds ds_mt_temp.rds \
ds_long_name_to_demo_line_breaks.rds

# Reports
REPORT_TARGETS = my_report.html another_report.html

# Phony Targets are any targets that don't represent single files
.Phony: all clean clobber

all: $(REPORT_TARGETS)

clean: 
	rm -f reports/*.html
	
clobber: 
	rm -f reports/*.html data/*.rds	

##############################################################################
################################# APPENDIX ###################################
##############################################################################

# You can execute this makefile from any computer that has make installed 
# (i.e., every Mac or Unix machine) simply by typing "make" in the terminal
# when your working directory is set to this directory. 

# Makefiles explicitly coordinate file dependencies through `rules`. 

# Rules take the form:

# target: prerequisite_1 prerequisite_2 ... prerequisite_n
# [tab] recipe_1
# [tab] recipe_2
# [tab] ...
# [tab] recipe_n

# The `target` is a desired output, such as a file containing a dataset or 
# report. A target from one recipe can become a prerequisite in a later recipe. 
# For instance, one recipe will generate clean data as its target, and that 
# data is used as a prerequisite in a later report. Those two actions should be 
# accomplished in two recipes.
# 
# `prerequisites` are the script(s) and data that generate a target. 
# Prerequisites for one recipe can include one or many dscripts and datasets, 
# but in my workflow, one script per recipe is typical. The first prerequisite 
# is typically the script utilizing the data prerequistes that follow. 
# 
# `recipes` are shell commands that coordinate the prerequisites in order to 
# create the target. The command section in most of my recipes is one item long, 
# and executes the first prerequisite, usually an R script or Rmd file. 
# 
# `recipes` must be indented with *tabs* and not *spaces*. 
# If you are working in an RStudio project, go to Tools/Project-Options and 
# make sure that "Insert Spaces for Tab" is unchecked. If you are not working 
# in an Rproject, uncheck "Insert Spaces for Tab" from Tools/Global-Options.
# 
# `variables` in GNU Make are created like this ...
# VARNAME = something useful
# ... and `variables` are called like this 
# $(VARNAME)
# 
# The special variable `VPATH` saves the search paths through which make should 
# search for your target, prerequisite, and command files. 

# `Rscript` will execute an R script

# Useful automatic variables:
# $@       the name of the target
# $<       the name of the first prerequisite 
# $^       the names of all prerequisites of current rule
# $(@D)    the directory part of the target
# $(@F)    the file part of the target
# $(<D)    the directory part of the first prerequisite 
# $(<F)    the file part of the first prerequisite 

# Using these automatic variables, you can even refer to files that don't yet exist: 
# For instance in the following recipe I can use $(<F) to refer to and remove
# demo.md, a file that results from knitr::knit() that I have no use for: 

# demo.rds: demo.Rmd raw.rds
#		Rscript -e "knitr::knit('$<')"
#		rm $(<F:.Rmd=.md)

# $(<F:.Rmd=.md) will be evaluated as "demo.md" because $(<F) will return as a 
# string the file name of the first prerequisite, "demo.Rmd", and ":.Rmd=.md" 
# will edit the string "demo.Rmd" to become "demo.md", so that rm $(<F:.Rmd=.md)
# will be evaluated as "rm demo.md".