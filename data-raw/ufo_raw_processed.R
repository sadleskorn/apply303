
### Inspect Data
ufos_raw <- read_csv("ufo_raw.csv") %>%
  filter(country == "us")

ufos_raw <- utils::read.csv("data-raw/ufos-scrubbed.csv") %>%
  dplyr::filter(country == "us")


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


