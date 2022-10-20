########################################################
# Data Handling Lecture 5: Text as Data
#
# Quanteda
########################################################




# SET UP -----------------

# load/install packages
pacman::p_load(
     tidytext,
     quanteda,
     readtext,
     stringr,
     quanteda.textstats,
     quanteda.textplots
)





### From raw text to corpus: step (1) -----------------

# set path
path_data <- system.file("extdata/", package = "readtext")

# import csv file
dat_inaug <- read.csv(paste0(path_data, "/csv/inaugCorpus.csv"))
names(dat_inaug)

# Create a corpus
corp <- corpus(dat_inaug, text_field = "texts")
print(corp)

# Look at the metadata in the corpus using `docvars`
docvars(corp)

# In quanteda, the metadata in a corpus can be handled like data frames.
docvars(corp, field = "Century") <- floor(docvars(corp, field = "Year") / 100) + 1





### From corpus to tokens: steps (2) and (3) ---------------

toks <- tokens(corp)
head(toks[[1]], 20)

# Remove punctuation
toks <- tokens(corp, remove_punct = TRUE)
head(toks[[1]], 20)

# Remove stopwords
stopwords("en")
toks <- tokens_remove(toks, pattern = stopwords("en"))
head(toks[[1]], 20)

# We can keep words we are interested in
tokens_select(toks, pattern = c("peace", "war", "great*", "unit*"))

# Remove "fellow" and "citizen"
toks <- tokens_remove(toks, pattern = c(
     "fellow*",
     "citizen*",
     "senate",
     "house",
     "representative*",
     "constitution"
))

# Build N-grams (onegrams, bigrams, and 3-grams)
toks_ngrams <- tokens_ngrams(toks, n = 2:3)

# Build N-grams based on a structure: keep n-grams that containt a "not"
toks_neg_bigram_select <- tokens_select(toks_ngrams, pattern = phrase("never_*"))
head(toks_neg_bigram_select[[1]], 30)






### From tokens to document-term-matrix (dtm): steps (3) and (4) --------

dfmat <- dfm(toks)
print(dfmat)





### From dtm to analysis and insights ---------


topfeatures(dfmat, 10)

# compute word frequencies as top feature
tstat_freq <- textstat_frequency(dfmat, n = 5)

# visualize frequencies in word cloud
textplot_wordcloud(dfmat, max_words = 100)



