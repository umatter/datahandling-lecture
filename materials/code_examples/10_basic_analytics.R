
# SET UP ----------------------
# load packages
library(tidyverse)

# initiate data frame on persons' spending
df_c <- data.frame(id = c(1:3,1:3),
                   money_spent= c(1000, 2000, 6000, 1500, 3000, 5500),
                   currency = c("CHF", "CHF", "USD", "EUR", "CHF", "USD"),
                   year=c(2017,2017,2017,2018,2018,2018))
df_c

# initiate data frame on persons' characteristics
df_p <- data.frame(id = 1:4,
                   first_name = c("Anna", "Betty", "Claire", "Diane"),
                   profession = c("Economist", "Data Scientist",
                                  "Data Scientist", "Economist"))
df_p



# Preparatory steps: combine/merge data frames ------------------------------------------

df_merged <- merge(df_p, df_c, by="id")
df_merged





# Data summaries: a first overview

# summary statistics for each variable
summary(df_merged)

# cross-tabulation (categorical variables)
table(df_merged$year)
table(df_merged$year, df_merged$profession)


# Selecting subsets (select columns) ------------------------------------------


df_selection <- select(df_merged, id, year, money_spent, currency)
df_selection



# Filtering datasets (filter rows based on variable values) ------------------------------------------

# one filtering condition
filter(df_selection, year == 2018)

# several filtering conditions
filter(df_selection, year == 2018, money_spent < 5000, currency=="EUR")





# Mutating datasets (add/change values/columns) ------------------------------------------

# initiate an exchange-rate data frame
exchange_rates <- data.frame(exchange_rate= c(0.9, 1, 1.2),
                             currency=c("USD", "CHF", "EUR"), stringsAsFactors = FALSE)
# join the exchange-rate with the main dataset
df_selection <- merge(df_selection, exchange_rates, by="currency")

# add the new variable with money spent in CHF
df_mutated <- mutate(df_selection, money_spent_chf = money_spent * exchange_rate)
df_mutated



# Summary statistics and aggregation -------------------------------------------

# generate a simple descriptive statistics table
summarise(df_mutated,
          mean = mean(money_spent_chf),
          standard_deviation = sd(money_spent_chf),
          median = median(money_spent_chf),
          N = n())


# summarize by groups of observations ("split-apply-combine")

# split into year-groups
by_year <- group_by(df_mutated, year)

# apply statistics functions, and combine results in one table
summarise(by_year,
          mean = mean(money_spent_chf),
          standard_deviation = sd(money_spent_chf),
          median = median(money_spent_chf),
          N = n())


# apply-type functions for data summaries

# load data
data("swiss")

# compute the mean for each variable (column)
sapply(swiss, mean)




