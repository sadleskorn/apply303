
library(tidyverse)
library(plotly)
library(dplyr)
library(lubridate)
library(fastR2)
library(knitr)



ufos_raw <- read_csv("ufos-scrubbed.csv") %>%
  filter(country == "us")
head(ufos_raw) %>% kable("html")

#Data transformation
ufos_raw$comments <- str_wrap(ufos_raw$comments, 50)
ufos_raw$year <-format(as.Date(ufos_raw$datetime,format="%m/%d/%Y"),"%Y")
ufos_raw$month <-format(as.Date(ufos_raw$datetime,format="%m/%d/%Y"),"%Y/%m")


### Filter down data to just the columns we need for visualization.
#Select just the data needed
ufos <- ufos_raw %>%
  filter(year >= '2000') %>%
  select(c(datetime, latitude, longitude, month, comments, state, city, year, shape))

usethis::use_data(ufos, overwrite = TRUE)
