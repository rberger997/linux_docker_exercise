
library(dplyr)
library(magrittr)

# Look at cars dataset
head(mtcars)

# Plot from cars dataset
plot(mtcars$mpg ~ mtcars$wt,
     main = 'MPG vs Weight',
     ylab = 'MPG',
     xlab = 'Car Weight (tons)')



# Get table from janitor package
library(janitor)


# Install janitor if you don't have it
install.packages('janitor')

library(janitor)
tabyl(mtcars, cyl) %>% 
  adorn_pct_formatting()

