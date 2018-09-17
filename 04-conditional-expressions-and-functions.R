# --------------------------------------------------------------------------------
#
# Conditional Expressions and Functions 14)
#
# --------------------------------------------------------------------------------

# Setup
library(dplyr)
library(dslabs)
data(murders)

a <- 0

if(a!=0){
     print(1/a)
} else{
     print("No reciprocal for 0.")
}
#> [1] "No reciprocal for 0."

# Let’s look at one more example using the US murders data frame:
     
murder_rate <- murders$total/murders$population*100000

# Here is a very simple example that tells us which states, if any, have a
# murder rate lower than 0.5 per 100,000. The if statement protects us from the
# case in which no state satisfies the condition.

ind <- which.min(murder_rate)

if(murder_rate[ind] < 0.5){
     print(murders$state[ind]) 
} else{
     print("No state has murder rate that low")
}
#> [1] "Vermont"

#If we try it again with a rate of 0.25, we get a different answer:
     
if(murder_rate[ind] < 0.25){
     print(murders$state[ind]) 
     } else{
          print("No state has a murder rate that low.")
     }
#> [1] "No state has a murder rate that low."

a <- 0
ifelse(a > 0, 1/a, NA)
#> [1] NA

# The function is particularly useful because it works on vectors. It examines
# each entry of the logical vector and returns elements from the vector provided
# in the second argument, if the entry is TRUE, or elements from the vector
# provided in the third argument, if the entry is FALSE.

a <- c(0,1,2,-4,5)
result <- ifelse(a > 0, 1/a, NA)

data(na_example)
no_nas <- ifelse(is.na(na_example), 0, na_example) 
sum(is.na(no_nas))
#> [1] 0

# Two other useful functions are any and all. The any function takes a vector of
# logicals and returns TRUE, if any of the entries is TRUE. The all function
# takes a vector of logicals and returns TRUE, if all of the entries are TRUE.
# Here is an example:
     
z <- c(TRUE, TRUE, FALSE)
any(z)
#> [1] TRUE
all(z)
#> [1] FALSE

avg <- function(x){
     s <- sum(x)
     n <- length(x)
     s/n
}

# Now avg is a function that computes the mean:
     
x <- 1:100
identical(mean(x), avg(x))
#> [1] TRUE

# Notice that variables defined inside a function are not saved in the
# workspace. So while we use s and n when we call avg, the values are created
# and changed only during the call. Here is an illustrative example:
     
s <- 3
avg(1:10)
#> [1] 5.5
s
#> [1] 3

compute_s_n <- function(n) {
     x <- 1:n
     sum(x)
}

for(i in 1:5){
     print(i)
}
#> [1] 1
#> [1] 2
#> [1] 3
#> [1] 4
#> [1] 5

# And here is the for-loop we would write for our Sn example:
     
m <- 25
s_n <- vector(length = m) # create an empty vector
     for(n in 1:m){
          s_n[n] <- compute_s_n(n)
     }

# Now we can create a plot to search for a pattern:
     
n <- 1:m
plot(n, s_n)

plot(n, s_n)
lines(n, n*(n+1)/2)

# -----------------------------------------------------------
# Vectorization and functionals
# -----------------------------------------------------------

# Although for-loops are an important concept to understand, in R we rarely use
# them. As you learn more R, you will realize that vectorization is the
# preferred over for-loops since it results in shorter and clearer code. We
# already saw examples in the Vector Arithmetic Section. A vectorized function
# is a function that will apply the same operation on each of the vectors.

x <- 1:10
sqrt(x)
#>  [1] 1.00 1.41 1.73 2.00 2.24 2.45 2.65 2.83 3.00 3.16
y <- 1:10
x*y
#>  [1]   1   4   9  16  25  36  49  64  81 100

# To make this calculation, there is no need for for-loops. But not all
# functions work this way. For instance, the function we just wrote,
# compute_s_n, does not work element-wise since it is expecting a scalar. This
# piece of code does not run the function on each entry of n:
     
n <- 1:25
compute_s_n(n)

# Functionals are functions that help us apply the same function to each entry
# in a vector, matrix, data frame or list. Here we cover the functional that
# operates on numeric, logical and character vectors: sapply.

# The function sapply permits us to perform element-wise operations on any
# function. Here is how it works:
     
x <- 1:10
sapply(x, sqrt)
#>  [1] 1.00 1.41 1.73 2.00 2.24 2.45 2.65 2.83 3.00 3.16

# Here each element of x is passed on to the function sqrt and the result is
# returned. These results are concatenated. In this case, the result is a vector
# of the same length as the original x. This implies that the for-loop above can
# be written as follows:
     
n <- 1:25
s_n <- sapply(n, compute_s_n)
plot(n, s_n)

# FAMILIARIZE YOURSELF WITH apply, lapply, mapply, vapply, and replicate

# -----------------------------------------------------------
# Map
# -----------------------------------------------------------

# Another series of functionals are provided by the purrr package. These are
# similar to sapply, but, in some instances, they are somewhat easier to use for
# beginners. The general idea is the same

library(purrr)
n <- 1:25
s_n <- map(n, compute_s_n)

# One advantage that becomes clear later is that with the purrr functionals you
# know what type of object you will get back. This is different with sapply that
# can return several different types. The map function always returns a list.

class(s_n)
#> [1] "list"

# If we want a numeric vector we can instead use:
     
s_n <- map_dbl(n, compute_s_n)
plot(n, s_n)

# -----------------------------------------------------------
# Matrices
# -----------------------------------------------------------

# Matrices are another type of object that are common in R. Matrices are similar
# to data frames in that they are two dimensional: they have rows and columns.
# However, like numeric, character and logical vectors, entries in matrices have
# to be all the same type. For this reason data frames are much more useful for
# storing data, since we can have characters, factors and numbers in them.

# Yet matrices have a major advantage over data frames and it’s that we can
# perform a very powerful type of mathematics operations with them called matrix
# algebra. We do not describe these operations in this book, but much of what
# happens in the background when you perform a data analysis involves matrices.
# For this reason, and others, some of the functions we will learn return
# matrices. We will describe them briefly here.

# One way matrices show up is if a function called with sapply returns two or
# more values. For example, suppose we write a function that for any number x
# returns x, x^2 and x^3:
     
cubic <- function(x) {
     c(x, x^2, x^3)
}
cubic(2)
#> [1] 2 4 8

# If we use sapply to compute these three numbers for each of the elements in a
# vector, R automatically binds the results as columns in a matrix:
     
n <- seq(1,5)
mat <- sapply(n, cubic)
mat
#>      [,1] [,2] [,3] [,4] [,5]
#> [1,]    1    2    3    4    5
#> [2,]    1    4    9   16   25
#> [3,]    1    8   27   64  125

# Accessing matrix values

# You can access specific entries in a matrix using [. If you want the second
# row, third column you use:
                                                        
mat[2,3]
#> [1] 9

# If you want the entire second row, you leave the column spot empty:
                                                        
mat[2, ]
#> [1]  1  4  9 16 25

# Notice that this returns a vector, not a matrix.
                                                   
# Similarly, if you want the entire third column, you leave the row spot entry:
                                                        
mat[ ,3]
#> [1]  3  9 27

# This is also a vector, not a matrix. You can access more than one column or
# more than one row if you like. This will give you a new matrix.
                                                   
mat[ ,2:4]
#>      [,1] [,2] [,3]
#> [1,]    2    3    4
#> [2,]    4    9   16
#> [3,]    8   27   64

# You can subset both rows and columns:
                                                        
mat[1:2,2:4]
#>      [,1] [,2] [,3]
#> [1,]    2    3    4
#> [2,]    4    9   16

# In some of our illustrations, we will convert matrices into data frames so
# that we can, for example, use them with dplyr. For this we can use the
# function as.data.frame:
                                                        
as.data.frame(mat)
#>   V1 V2 V3 V4  V5
#> 1  1  2  3  4   5
#> 2  1  4  9 16  25
#> 3  1  8 27 64 125

# You can also use the [ to access rows and columns of a data frame:

data("murders")
murders[25, 1]
#> [1] "Mississippi"

murders[2:3, ]
#>     state abb region population total
#> 2  Alaska  AK   West     710231    19
#> 3 Arizona  AZ   West    6392017   232

# ----------------------------------------------------------
# Excercises for Assessment 9
# ----------------------------------------------------------

x <- c(1,2,-3,4)
if(all(x>0)){
     print("All Positives")
} else{
     print("Not All Positives")
}

# Assign the state abbreviation when the state name is longer than 8 
# characters
new_names <- ifelse(nchar(murders$state) > 8, murders$abb, murders$state)

# Create function called `sum_n`
sum_n <- function(n){
     v <- 1:n
     sum(v)
}
# Use the function to determine the sum of integers from 1 to 5000
sum_n(5000)

# Create `altman_plot` 
altman_plot <- function(x, y){
     plot(x + y, y - x)
}
altman_plot(5,5)

# Run this code 
x <- 3
my_func <- function(y){
     x <- 5
     y+5
     print(x)
}
my_func(x)
# Print value of x 
print(x)

# Here is an example of function that adds numbers from 1 to n
example_func <- function(n){
     x <- 1:n
     sum(x)
}

# Here is the sum of the first 100 numbers
example_func(100)

# Write a function compute_s_n that with argument n and returns of 1 + 2^2 + ...+ n^2
compute_s_n <- function(n){
     s <- 0
     for (i in 1:n){
          s <- s + i^2
     }
     s
}
# Report the value of the sum when n=10
print(compute_s_n(10))

# Define a function and store it in `compute_s_n`
compute_s_n <- function(n){
     x <- 1:n
     sum(x^2)
}

# Create a vector for storing results
s_n <- vector("numeric", 25)

# write a for-loop to store the results in s_n
for (i in 1:25){
     s_n[i] <- compute_s_n(i)
}
print(s_n)

# Define the function
compute_s_n <- function(n){
     x <- 1:n
     sum(x^2)
}

# Define the vector of n
n <- 1:25

# Define the vector to store data
s_n <- vector("numeric", 25)
for(i in n){
     s_n[i] <- compute_s_n(i)
}

#  Create the plot 
plot(n, s_n)

# Define the function
compute_s_n <- function(n){
     x <- 1:n
     sum(x^2)
}

# Define the vector of n
n <- 1:25

# Define the vector to store data
s_n <- vector("numeric", 25)
for(i in n){
     s_n[i] <- compute_s_n(i)
}

# Check that s_n is identical to the formula given in the instructions.
identical(s_n[25], (25*(25+1)*((2*25)+1))/6)

