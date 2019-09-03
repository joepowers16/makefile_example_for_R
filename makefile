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
DIR_MUNGE = ./munge
DIR_REPORTS = ./reports
DIR_ANALYSIS = ./analysis

# Search path
VPATH = $(DIR_PROJECT) $(DIR_DATA) $(DIR_MUNGE) $(DIR_RAW) $(DIR_ANALYSIS) \
$(DIR_REPORTS)

# generate html report from Rmd file
RENDER = Rscript -e "rmarkdown::render('$<')" 
# generate html report from Rmd file and move it to "reports" directory
RENDER_TO_REPORTS = $(RENDER); mv $(<:.Rmd=.html) $(DIR_REPORTS)

SOURCE_RMD_NO_REPORT = Rscript -e 'knitr::knit("$<", output = tempfile())'
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
	rm -f $(addprefix $(DIR_REPORTS)/, $(TARGETS_REPORTS))
	
ds_mt.rds: 

ds_mt_agg.rds: 

report.html: 

%.rds: %.R 
	Rscript $<

%.rds: %.Rmd 
	$(SOURCE_RMD_NO_REPORT)
	
%.html: %.Rmd
	$(RENDER_TO_REPORTS)
	

	