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
PROJECT = ./

# Search path
VPATH = $(PROJECT)

##############################################################################
############################## LIST OF TARGETS ###############################
##############################################################################

# Phony Targets are any targets that don't represent single files
.Phony: all clean

all: ds_mt_agg.rds

clean: 
	rm -f ds_mt_agg.rds
	
ds_mt_agg.rds: 

%.rds: %.Rmd 
	Rscript -e 'knitr::knit("$<", output = tempfile())'
	

	