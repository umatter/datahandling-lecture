
# SET UP --------------

# load packages
library(tidyverse)



## Data types, strings ------------------------------------------------------------------------
messy_df <- data.frame(last_name = c("Wayne", "Trump", "Karl Marx"),
                       first_name = c("John", "Melania", ""),
                       gender = c("male", "female", "Man"),
                       date = c("2018-11-15", "2018.11.01", "2018/11/02"),
                       income = c("150,000", "250000", "10000"), stringsAsFactors = FALSE)








## define, clean categorical variables ------------------------------------------------------------------------
messy_df$gender <- as.factor(messy_df$gender)
messy_df$gender
# Problems?




## standardize categories ------------------------------------------------------------------------
messy_df$gender[messy_df$gender == "Man"] <- "male"
messy_df$gender


## tidyverse approach
messy_df$gender <- fct_recode(messy_df$gender, "male" = "Man")
messy_df$gender








## numeric/integer values ------------------------------------------------------------------------
as.integer(messy_df$income)
# Problem?


## ------------------------------------------------------------------------
messy_df$income <- str_replace(messy_df$income, pattern = ",", replacement = "")
messy_df$income <- as.integer(messy_df$income)



## clean up variables  ------------------------------------------------------------------------
messy_df
# remaining problems?





## split strings, add new variables
splitnames <- str_split(messy_df$last_name, pattern = " ", simplify = TRUE)
splitnames

## find rows with problematic cases, add correct first name, 
problem_cases <- messy_df$first_name == ""
messy_df$first_name[problem_cases] <- splitnames[problem_cases, 1]


#last name
messy_df$last_name[problem_cases] <- splitnames[problem_cases, 2]
messy_df


##  parse dates correctly -------------------------------------------------------
library(lubridate)


## ------------------------------------------------------------------------
messy_df$date <- ymd(messy_df$date)


## ------------------------------------------------------------------------
messy_df


## ------------------------------------------------------------------------
str(messy_df)







################################################################
# BREAK --------------------------
################################################################



# Reshaping datasets: introductory example/concept -----------------------------

# load example data
rawdata <- read.csv("data/treatments.csv")

# inspect data
rawdata


# reshape from wide to long
tidydata <- pivot_longer(data = rawdata, 
                         cols = c("treatmenta", "treatmentb"),
                         names_to = "treatment",
                         names_prefix = "treatment",
                         values_to = "result")

# inspect result
tidydata






# Wide to Long --------------------------------------------


## initialize and inspect a wide example data-frame
wide_df <- data.frame(last_name = c("Wayne", "Trump", "Marx"),
                      first_name = c("John", "Melania", "Karl"),
                      gender = c("male", "female", "male"),
                      income.2018 = c("150000", "250000", "10000"),
                      income.2017 = c( "140000", "230000", "15000"),stringsAsFactors = FALSE)
wide_df











# transform from wide to long
long_df <- pivot_longer(wide_df, 
                        c(income.2018, income.2017),
                        names_to = "year",
                        names_prefix = "income.",
                        values_to = "income")
# inspect the result
long_df








# Long to wide -------------------------------------------

# initiate a weird long data.frame
weird_df <- data.frame(last_name = c("Wayne", "Trump", "Marx",
                                     "Wayne", "Trump", "Marx",
                                     "Wayne", "Trump", "Marx"),
                       first_name = c("John", "Melania", "Karl",
                                      "John", "Melania", "Karl",
                                      "John", "Melania", "Karl"),
                       gender = c("male", "female", "male",
                                  "male", "female", "male",
                                  "male", "female", "male"),
                       value = c("150000", "250000", "10000",
                                 "2000000", "5000000", "NA",
                                 "50", "25", "NA"),
                       variable = c("income", "income", "income",
                                    "assets", "assets", "assets",
                                    "age", "age", "age"),
                       stringsAsFactors = FALSE)


# inspect it, where are the problems?
weird_df


# transform from long to wide
tidy_df <- pivot_wider(weird_df,
                       names_from = "variable",
                       values_from = "value")

# inspect result
tidy_df







# Stacking/Row binding -------------------------------------------


# initialize and inspect sample subsets
# initialize
subset1 <- data.frame(ID=c(1,2),
                      X=c("a", "b"),
                      Y=c(50,10))

subset2 <- data.frame(ID=c(3,4),
                      Z=c("M", "O"))

subset3 <- data.frame(ID= c(5),
                      X=c("c"),
                      Z="P")

# inspect
str(subset1)
str(subset2)
str(subset3)


# combine/stack
# install if needed
# install.packages("dplyr")

# load packages
library(dplyr)

# stack data frames
combined_df <- bind_rows(subset1, subset2, subset3)

# inspect the result
combined_df


