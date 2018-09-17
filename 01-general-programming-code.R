# --------------------------------------------------------------------------------
#
# General programming code from chapters 8-10
#
# --------------------------------------------------------------------------------

# Setup
library(dslabs)
data(murders)

murders

pop <- murders$population
pop <- sort(pop)
pop

pop <- murders$population
which.min(pop)

min(pop)
which.min(pop)

states <- (murders$state)
states[which.min(pop)]

ranks <- rank(murders$population)
my_df

# --------------------------------------------------------------
# Exercises from Assessment 4
# --------------------------------------------------------------

# Access the `state` variable and store it in an object 
states <- murders$state 

# Sort the object alphabetically and redefine the object 
states <- sort(states) 

# Report the first alphabetical value  
states[1]

# Access population values from the dataset and store it in pop
pop <- murders$population

# Sort the object and save it in the same object 
pop <- sort(pop)

# Report the smallest population size
print(pop[1])

# --------------------------------------------------------------

# Define the variable i to be the index of the smallest state
i <- which.min(murders$population)

# Define variable states to hold the states
states <- murders$state

# Use the index you just defined to find the state with the smallest population
states[i]

# --------------------------------------------------------------

# Store temperatures in an object 
temp <- c(35, 88, 42, 84, 81, 30)

# Store city names in an object 
city <- c("Beijing", "Lagos", "Paris", "Rio de Janeiro", "San Juan", "Toronto")

# Create data frame with city names and temperature 
city_temps <- data.frame(name = city, temperature = temp)

# --------------------------------------------------------------

# Define a variable states to be the state names 
states <- murders$state

# Define a variable ranks to determine the population size ranks 
ranks <- rank(murders$population)

# Create a data frame my_df with the state name and its rank
my_df <- data.frame(name = states, rank = ranks)
my_df

# --------------------------------------------------------------

# Define a variable states to be the state names from the murders data frame
states <- murders$state

# Define a variable ranks to determine the population size ranks 
ranks <- rank(murders$population)

# Define a variable ind to store the indexes needed to order the population
# values
ind <- order(ranks)

# Create a data frame my_df with the state name and its rank and ordered from
# least populous to most
my_df <- data.frame(name = states[ind], rank = ranks[ind])
my_df

# --------------------------------------------------------------

# Using new dataset 
library(dslabs)
data(na_example)

# Checking the structure 
str(na_example)

# Find out the mean of the entire dataset 
mean(na_example)

# Use is.na to create a logical index ind that tells which entries are NA
ind <- is.na(na_example)
# Determine how many NA ind has using the sum function
sum(ind)

# --------------------------------------------------------------

# Note what we can do with the ! operator
x <- c(1, 2, 3)
ind <- c(FALSE, TRUE, FALSE)
x[!ind]

# Create the ind vector
library(dslabs)
data(na_example)
ind <- is.na(na_example)

# We saw that this gives an NA
mean(na_example)

# Compute the average, for entries of na_example that are not NA 
mean(na_example[!ind])

# --------------------------------------------------------------
# Excercises from Assessment 5
# --------------------------------------------------------------
murder_rate <- murders$total / murders$population * 100000
murder_rate

murders$state[order(murder_rate)]
mean(murder_rate)

# --------------------------------------------------------------

# Assign city names to `city` 
city <- c("Beijing", "Lagos", "Paris", "Rio de Janeiro", "San Juan", "Toronto")

# Store temperature values in `temp`
temp <- c(35, 88, 42, 84, 81, 30)

# Convert temperature into Celsius and overwrite the original values of 'temp' with these Celsius values
temp <- (temp - 32) * 5/9

# Create a data frame `city_temps` 
city_temps <- data.frame(name = city, temperature = temp)

# --------------------------------------------------------------

# Define an object `x` with the numbers 1 through 100
x <- c(1:100)
# Compute the sum 
sum(1/x^2)

# --------------------------------------------------------------

ind <- murder_rate < 0.71
murders$state[ind]

sum(ind)

west <- murders$region == "West"
safe <- murder_rate <= 1

# We can use the & to get a vector of logicals that tells us which states
# satisfy both conditions:
     
ind <- safe & west
murders$state[ind]
#> [1] "Hawaii"  "Idaho"   "Oregon"  "Utah"    "Wyoming"

ind <- which(murders$state == "California")
ind #this is the index that matches the California entry
#> [1] 5
murder_rate[ind]
#> [1] 3.37

ind <- match(c("New York", "Florida", "Texas"), murders$state)
ind
#> [1] 33 10 44

# Now we can look at the murder rates:
     
murder_rate[ind]
#> [1] 2.67 3.40 3.20

c("Boston", "Dakota", "Washington") %in% murders$state
#> [1] FALSE FALSE  TRUE

match(c("New York", "Florida", "Texas"), murders$state)
#> [1] 33 10 44
which(murders$state %in% c("New York", "Florida", "Texas"))
#> [1] 10 33 44

# --------------------------------------------------------------
# Excercises from Assessment 6
# --------------------------------------------------------------

# Store the murder rate per 100,000 for each state, in `murder_rate`
murder_rate <- murders$total / murders$population * 100000

# Store the `murder_rate < 1` in `low` 
low <- murder_rate < 1

# Get the indices of entries that are below 1
which(low)

# --------------------------------------------------------------

# Store the murder rate per 100,000 for each state, in murder_rate
murder_rate <- murders$total/murders$population*100000

# Store the murder_rate < 1 in low 
low <- murder_rate < 1

# Names of states with murder rates lower than 1
murders$state[low]

# --------------------------------------------------------------

# Store the murder rate per 100,000 for each state, in `murder_rate`
murder_rate <- murders$total/murders$population*100000

# Store the `murder_rate < 1` in `low` 
low <- murder_rate < 1

# Create a vector ind for states in the Northeast and with murder rates lower than 1. 
ind <- low & murders$region == "Northeast"
# Names of states in `ind` 
murders$state[ind]

# --------------------------------------------------------------

# Store the murder rate per 100,000 for each state, in murder_rate
murder_rate <- murders$total/murders$population*100000
              
# Compute average murder rate and store in avg using `mean` 
avg <- mean(murder_rate)
              
# How many states have murder rates below avg ? Check using sum 
sum(murder_rate < avg) 

# --------------------------------------------------------------

# Store the 3 abbreviations in abbs in a vector (remember that they are character vectors and need quotes)
abbs <- c("AK", "MI", "IA")
# Match the abbs to the murders$abb and store in ind
ind <- match(abbs, murders$abb)
# Print state names from ind
murders$state[ind]

# --------------------------------------------------------------

# Store the 5 abbreviations in `abbs`. (remember that they are character vectors)
abbs <- c("MA", "ME", "MI", "MO", "MU")

# Use the %in% command to check if the entries of abbs are abbreviations in the the murders data frame
abbs %in% murders$abb

# --------------------------------------------------------------

# Store the 5 abbreviations in abbs. (remember that they are character vectors)
abbs <- c("MA", "ME", "MI", "MO", "MU") 

# Use the `which` command and `!` operator to find out which abbreviation are not actually part of the dataset and store in ind
ind <- which(!abbs %in% murders$abb)
# What are the entries of abbs that are not actual abbreviations
abbs[ind]

