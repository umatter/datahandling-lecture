########################################################
# Data Handling Lecture 5: Read a Webpage into R
#
# See Wikipedia's page on the Swiss Economy
# https://en.wikipedia.org/wiki/Economy_of_Switzerland
########################################################


# SET UP ---------

# packages
library(rvest) # depends on httr and xml2

# fix variables
URL <- "https://en.wikipedia.org/wiki/Economy_of_Switzerland"



# READ WEBPAGE AS TEXT DOCUMENT -------------------
# (naive approach to import a website into R...)
swiss_econ <- readLines("https://en.wikipedia.org/wiki/Economy_of_Switzerland")
head(swiss_econ)

# Navigate the raw HTML
swiss_econ[231]


# PARSE THE HTML, WEB SCRAPING ------------

# parse the webpage, show the content
swiss_econ_parsed <- read_html("https://en.wikipedia.org/wiki/Economy_of_Switzerland")
swiss_econ_parsed

# find the element containing the table
tab_node <- html_element(swiss_econ_parsed,
                      xpath = "//*[@id='mw-content-text']/div/table[2]")
# extract the table as data.frame
tab <- html_table(tab_node)
tab





