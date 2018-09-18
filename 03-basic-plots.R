# --------------------------------------------------------------------------------
#
# Basic Plots (chapters 12-13)
#
# --------------------------------------------------------------------------------

# Setup
library(dplyr)
library(dslabs)
data(murders)

population_in_millions <- murders$population/10^6
total_gun_murders <- murders$total

plot(population_in_millions, total_gun_murders)

# Transform population using the log10 transformation and save to object log10_population
log10_population <- log10(murders$population)

# Transform total gun murders using log10 transformation and save to object log10_total_gun_murders
log10_total_gun_murders <- log10(total_gun_murders)

# Create a scatterplot with the log scale transformed population and murders 
plot(log10_population, log10_total_gun_murders)

# Store the population in millions and save to population_in_millions 
population_in_millions <- murders$population/10^6

# Create a histogram of this variable
hist(population_in_millions)

# Create a boxplot of state populations by region for the murders dataset
boxplot(population~region, data = murders)

# Boxplots are even more useful when we want to quickly compare two or more
# distributions. For example, here are the heights for men and women:
     
heights %>% ggplot(aes(x=sex, y=height, fill=sex)) +
geom_boxplot()

heights %>% filter(sex=="Female") %>% top_n(5, desc(height)) %>% .$height
#> [1] 51 53 55 52 52
