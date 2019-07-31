This project demonstrates the use of a makefile to coordinate data cleaning and analyis in R. Typical data projects have many dependencies between files. For instance a single R script could read in data from several csv files, run some code, and then output a plot or report. As R scripts grow long these dependencies often become hard to keep track of. For instance, a dataset may be changed at multiple points throughout a single long script, and the confused researcher loses track of what state their data was in at line 2005 of their code. 

An alternative approach to a lengthy R script that cleans, merges, and analyzes your data is to modularize each step into smaller scripts that have clearly defined input and output. Makefiles explicitly coordinate these small scripts and their dependencies through `recipes`. The beauty of make is that recipes will only be executed when a prerequisite becomes newer than its target. In lay terms, this means that any time you change a script or dataset that your target depends on, the target will be rebuilt. And, every other recipe that uses that target as a prerequisite will also be rebuilt. That's so useful because if your data chagnes, you certainly want all plots and models that use that data to be updated, but updating everything after every change is a waste of time. 

Recipes take the form:

target: prerequisite_1 prerequisite_2 ... prerequisite_n
[tab] command_1
[tab] command_2
[tab] ...
[tab] command_

The `target` is a desired output, such as a file containing a dataset or report. A target from one recipe can become a prerequisite in another recipe. For instance, one recipe will generate clean data that is used in a later report. Those two actions should be accomplished in two recipes.

The `prerequisites` are the data and scripts that generate a target. Prerequisites for one recipe can include one or many datasets and scripts. The first prerequisite is typically the script utilizing the data files from the prerequistes that follow. 

The `commands` are shell commands that coordinate the prerequisites in order to create the target. The command section in most of my recipes is one item long, and executes the first prerequisite, which is usually a script. 

`Commands` must be indented with *tabs* and not *spaces*. 
If you are working in an RStudio project, go to Tools/Project Options and 
make sure that "Insert Spaces for Tab" is unchecked. If you are not working 
in an Rproject, uncheck "Insert Spaces for Tab" from Tools/Global Options.

A final note on script length: How long your script should be is a bit like asking how long a paragraph should be. There's no absolute answer, but if your paragraph is over a page long, it's probably accomplishing more than your read can keep in mind. Same goes for scripts, because future you needs to be able to understand what your script was trying to accomplish oth should accomplish. I try to keep my scripts to <80 characters wide and <100 lines, preferably 50 lines. 

# References
https://www.gnu.org/software/make/manual/
https://kbroman.org/minimal_make/
https://www3.nd.edu/~zxu2/acms60212-40212/Makefile.pdf