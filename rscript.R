
library(dplyr)
library(magrittr)

# Look at cars dataset
data(mtcars)
head(mtcars)

# Plot from cars dataset
plot(mtcars$mpg ~ mtcars$wt,
     main = 'MPG vs Weight',
     ylab = 'MPG',
     xlab = 'Car Weight (tons)',
     pch = 16,
     col = 'dodgerblue')


# Check if janitor package is installed
find.package('janitor')


# Get table from janitor package
library(janitor)
tabyl(mtcars, cyl) %>% 
  adorn_pct_formatting() %>% 
  arrange(desc(percent))



# Install janitor if you don't have it
install.packages('janitor')

library(janitor)
tabyl(mtcars, cyl) %>% 
  adorn_pct_formatting()%>% 
  arrange(desc(percent))