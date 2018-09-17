# --------------------------------------------------------------------------------
#
# Basic Data Wrangling (chapter 11)
#
# --------------------------------------------------------------------------------

# Setup
library(dplyr)
library(dslabs)
data(murders)

# Adding a column with mutate
murders <- mutate(murders, rate = total / population * 100000)
head(murders)

# Subsetting with filter
filter(murders, rate <= 0.71)

# Selecting columns with select
new_table <- select(murders, state, region, rate)
filter(new_table, rate <= 0.71)

# The pipe: %>%
murders %>% select(state, region, rate) %>% filter(rate <= 0.71)

# In general, the pipe sends the result of the left side of the pipe to be the
# first argument of the function on the right side of the pipe. Here is a very
# simple example:
     
16 %>% sqrt()
#> [1] 4

# We can continue to pipe values along:
     
16 %>% sqrt() %>% log2()
#> [1] 2

# Creating a data frame
# It is sometimes useful for us to create our own data frames. You can do this
# by using the data.frame function:
     
grades <- data.frame(names = c("John", "Juan", "Jean", "Yao"), 
                          exam_1 = c(95, 80, 90, 85), 
                          exam_2 = c(90, 85, 85, 90))
grades

# Warning: By default the function data.frame coerces characters into factors:
     
class(grades$names)
#> [1] "factor"

# To avoid this we use the rather cumbersome argument stringsAsFactors:
     
grades <- data.frame(names = c("John", "Juan", "Jean", "Yao"), 
                          exam_1 = c(95, 80, 90, 85), 
                          exam_2 = c(90, 85, 85, 90),
                          stringsAsFactors = FALSE)
class(grades$names)
#> [1] "character"

# --------------------------------------------------------------
# Exercises from Assessment 4
# --------------------------------------------------------------

# Loading data
library(dslabs)
data(murders)

# Loading dplyr
library(dplyr)

# Redefine murders so that it includes column named rate with the per 100,000 murder rates
murders <- mutate(murders, rate=total/population*100000)

# --------------------------------------------------------------

# Note that if you want ranks from highest to lowest you can take the negative and then compute the ranks 
x <- c(88, 100, 83, 92, 94)
rank(-x)

# Defining rate
rate <-  murders$total/ murders$population * 100000

# Redefine murders to include a column named rank
# with the ranks of rate from highest to lowest
murders <- mutate(murders, rank(-rate))
murders

# Use select to only show state names and abbreviations from murders
select(murders, state,abb)

# Filter to show the top 5 states with the highest murder rates
filter(murders, rank < 6)

# Use filter to create a new data frame no_south
no_south <- filter(murders, region != "South")

# Use nrow() to calculate the number of rows
nrow(no_south)

# --------------------------------------------------------------

# Create a new data frame called murders_nw with only the states from the northeast and the west
murders_nw <- filter(murders, region %in% c("Northeast","West"))

# Number of states (rows) in this category 
nrow(murders_nw)

# add the rate column
murders <- mutate(murders, rate =  total / population * 100000, rank = rank(-rate))

# Create a table, call it my_states, that satisfies both the conditions 
my_states <- filter(murders, region %in% c("Northeast","West") & rate < 1)

# Use select to show only the state name, the murder rate and the rank
select(my_states, state, rate, rank)

# Define the rate column
murders <- mutate(murders, rate =  total / population * 100000, rank = rank(-rate))

# show the result and only include the state, rate, and rank columns, all in one
# line
filter(murders, region %in% c("Northeast","West") & rate < 1) %>%
     select(state, rate, rank)

# --------------------------------------------------------------

# Create new data frame called my_states (with specifications in the
# instructions)
my_states <-murders %>%
     mutate(rate =  total / population * 100000, rank = rank(-rate)) %>%
     filter(region %in% c("Northeast","West") & rate < 1) %>%
     select(state, rate, rank)
my_states

# --------------------------------------------------------------

mutate(murders, rate = total / population * 100000, rank = rank(-rate)) %>%
     select(state, rate, rank)


