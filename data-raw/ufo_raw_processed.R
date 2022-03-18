library(tidyverse)
library(plotly)
library(dplyr)
library(lubridate)
library(fastR2)
library(knitr)

ufos_raw <- read_csv("data-raw/ufos-scrubbed.csv") |>
  filter(country == "us")

ufos_raw$comments <- str_wrap(ufos_raw$comments, 50)
ufos_raw$year <-format(as.Date(ufos_raw$datetime,format="%m/%d/%Y"),"%Y")
ufos_raw$month <-format(as.Date(ufos_raw$datetime,format="%m/%d/%Y"),"%Y/%m")

ufos <- ufos_raw |>
  filter(year >= '2000') |>
  select(c(datetime, latitude, longitude, month, comments, state, city, year, shape))

usethis::use_data(ufos, overwrite = TRUE)
