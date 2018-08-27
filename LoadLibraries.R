required.packages <- c('tidyverse', 'nycflights13', 'gapminder', 'Lahman')
new.packages <- required.packages[!(required.packages %in% installed.packages()[,"Package"])]
if(length(new.packages)) install.packages(new.packages)

lapply(required.packages, require, character.only = TRUE)