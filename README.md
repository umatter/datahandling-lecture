
# About
Lecture materials for the SEPS-HSG (University of St. Gallen) course 'Data Handling: Import, Cleaning and Visualisation' (BA, Major in Economics). The materials consist of two parts:

 - Lecture lecture summaries: `materials/lecture_summaries/`
 - Lecture slides: `materials/slides/`
 
## Additional materials related to lecture summaries and slides:

 - Code examples used during lectures: `materials/code_examples/`
 - Images used in slides/summaries: `img/`
 - References used in slides/summaries: `references/`

## Code and data:

 - `code/` contains r-scripts with additional examples as well as utility functions to curate/maintain and compile the lecture materials.
 - `data/` contains data files used in the code examples.


## How to get the latest updates?

Open the terminal, type
`git pull`
and hit enter.


# Install dependencies

When starting to use this repository, first run the following lines of R code in the console.

```{r}
install.packages("tidyverse")
install.packages("knitr")
install.packages("bookdown")
install.packages("pacman")
install.packages("qdapRegex")
```

Then, copy-paste the following code into the console and hit enter (this will install all additional packages used in the code examples shown in the slides).

```{r}

# get a list of all rmd files (slides and summaries)
lecture_summaries_files <- list.files("materials/lecture_summaries", pattern = "\\.Rmd", full.names =TRUE)
slides_files <- list.files("materials/slides", pattern = "\\.Rmd", full.names = TRUE)
all_files <- c(lecture_summaries_files, slides_files)

# parse the rmds, extract a list of package dependencies
rmds <- lapply(all_files, readLines)
to_install <- lapply(rmds, qdapRegex::rm_between, 
                     left = c("library(", "require("),
                     right = c(")", ")"),
                     extract = TRUE)
to_install <-  unique(na.omit(unlist(to_install)))
to_install <- to_install[! to_install %in% c("PACKAGE-NAME",  "<PACKAGE NAME>")]

# install all missing packages
pacman::p_load(char = to_install)
```
In addition to the standard pandoc installation (should be installed with RStudio) you will have to install the `pandocfilters` library (in OSX: `pip install --user pandocfilters`).


# How to contribute

- Open issues:
  - report bugs and typos
  - suggest enhancements
- Resolve open issues with a pull request
- Contribute to the wiki




# Compilation of materials

Run the following in the terminal:

```{bash}
sh makeall_datahandling.sh
```
This tests all the R code, compiles lecture_summaries as html (`materials/lecture_summaries/html`) and pdf (`materials/lecture_summaries/pdf`), slides as html/ioslides (`materials/slides/html`), and outputs the sourcecode of code examples in the lecture_summaries to an R script (`materials/sourcecode`).


# Error messages

In case you are confronted with an error message of the type "pandoc document conversion failed" and you still see a tex file that is generated before the knitting process stopped, then do the following: open the tex file in RStudio, run it and install the latex packages that are suggested.

