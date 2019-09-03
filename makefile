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
DIR_PROJECT = ./
DIR_DATA = ./data
DIR_RAW = $(DIR_DATA)/raw

# Search path
VPATH = $(DIR_PROJECT) $(DATA) $(DIR_RAW)

##############################################################################
############################## LIST OF TARGETS ###############################
##############################################################################

# Phony Targets are any targets that don't represent single files
.Phony: all clean

TARGETS_DATA = ds_mt.rds ds_mt_agg.rds 
TARGETS_REPORTS = report.html

all: $(TARGETS_DATA) $(TARGETS_REPORTS)

clean: 
	rm -f $(addprefix $(DIR_DATA)/, $(TARGETS_DATA)) 
	rm -f $(addprefix $(DIR_TARGETS)/, $(TARGETS_REPORTS))
	
ds_mt.rds: 

ds_mt_agg.rds: 

report.html: 

%.rds: %.R 
	Rscript $<

%.rds: %.Rmd 
	Rscript -e 'knitr::knit("$<", output = tempfile())'
	
%.html: %.Rmd
	Rscript -e 'rmarkdown::render("$<")'
	

	