This project demonstrates the use of a makefile to coordinate data cleaning and analyis in R. Typical data projects have many dependencies between files. For instance a single R script could read in data from several csv files, run some code, and then output a plot or report. As R scripts grow long these dependencies often become hard to keep track of. For instance, a dataset may be changed at multiple points throughout a single long script, and the confused researcher loses track of what state their data was in at line 2005 of their code. 

An alternative approach to a lengthy R script that cleans, merges, and analyzes your data is to modularize each step into smaller scripts that have clearly defined input and output. Makefiles explicitly coordinate these small scripts and their dependencies through `recipes`. 

The beauty of make is that recipes will only be executed when a prerequisite becomes newer than its target. In lay terms, this means that any time you change a script or dataset that your target depends on, the target will be rebuilt. And, every other recipe that uses that target as a prerequisite will also be rebuilt. That's so useful because if your data chagnes, you certainly want all plots and models that use that data to be updated, but updating everything after every change is a waste of time. 

Recipes take the form:

```
target: prerequisite_1 prerequisite_2 ... prerequisite_n  
[tab] command_1  
[tab] command_2  
[tab] ...  
[tab] command_n  
```

The `target` is a desired output, such as a file containing a dataset or report. A target from one recipe can become a prerequisite in another recipe. For instance, one recipe will generate clean data that is used in a later report. Those two actions should be accomplished in two recipes.

The `prerequisites` are the data and scripts that generate a target. Prerequisites for one recipe can include one or many datasets and scripts. The first prerequisite is typically the script utilizing the data files from the prerequistes that follow. 

The `commands` are shell commands that coordinate the prerequisites in order to create the target. The command section in most of my recipes is one item long, and executes the first prerequisite, which is usually a script. 

`Commands` must be indented with *tabs* and not *spaces*. 
If you are working in an RStudio project, go to `Tools/Project Options` and 
make sure that "Insert Spaces for Tab" is unchecked. If you are not working 
in an Rproject, uncheck "Insert Spaces for Tab" from `Tools/Global Options`.

A real example of a make recipe could read: 

```
my_report.html: my_report.Rmd ds_mtcars.rds
	Rscript -e "rmarkdown::render('$<')" 
```

If the targets were saved in different subdirectories the recipe could read:
```
./analyis/my_report.html: ./analyis/my_report.Rmd ./data/ds_mtcars.rds
	Rscript -e "rmarkdown::render('$<')"
```

But as you will see in the example make file, you can set variables in Make that will eliminate the need to describe each target and prerequisite file path. 

## Some useful tips
### Avoiding clutter in your make log messages
You can avoid a lot of clutter in your make log messages by using `suppressPackageStartupMessages(library(package_name))`

### On script length 
How long your script should be is a bit like asking how long a paragraph should be. There's no absolute answer, but if your paragraph is over a page long, it's probably accomplishing more than your reader can keep in mind. Same goes for scripts, because future you needs to be able to understand what your script was trying to accomplish. I try to keep my scripts to <80 characters wide and <100 lines, preferably 50 lines. 

# References
[GNU Make Manual](https://www.gnu.org/software/make/manual/)  
[Broman, Minimal Make](https://kbroman.org/minimal_make/)  
[A Short Introduction to Makefile](https://www3.nd.edu/~zxu2/acms60212-40212/Makefile.pdf)  
[Phony Targets](https://www.gnu.org/software/make/manual/html_node/Phony-Targets.html#Phony-Targets)

## From https://lincolnmullen.com/projects/dh-r2/reproducible.html: 
Christopher Gandrud, Reproducible Research with R and RStudio (Chapman and Hall, 2013).
Though intended for scientists, see [Karl Broman’s short course on Tools for Reproducible Research](http://kbroman.org/Tools4RR/).
[CRAN Task View: Reproducible Research lists other packages relevant to reproducible research and literate programming.](http://cran.r-project.org/web/views/ReproducibleResearch.html)
Yihui Xie, Dynamic Documents with R and knitr (Chapman and Hall, 2013).
Manual for GNU Make
[Mike Bostock, “Why Use Make”](http://bost.ocks.org/mike/make/)
Boettiger, Carl. “An Introduction to Docker for Reproducible Research, with Examples from the R Environment.” arXiv:1410.0846 [cs], October 2, 2014. http://arxiv.org/abs/1410.0846.