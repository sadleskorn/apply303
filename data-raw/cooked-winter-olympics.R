library(dplyr)
library(tidyr)
library(ggplot2)
library(sf)
library(rnaturalearth)
library(stats)
library(MASS)
library(broom)
library(forecast)
library(shiny)
library(htmltools)
library(htmlwidgets)
library(plotly)
library(ggformula)
olympics0 <- read.csv('data-raw/winter-olympics.csv')

total_medals <- olympics0 |>
  group_by(Country) |>
  summarise(totals = n()) |>
  filter(totals >= 100) |>
  mutate(Country = reorder(Country, totals, max)) |>
  ungroup()

medal_counts <- olympics0 |>
  group_by(Country, Medal) |>
  summarise(totals = n()) |>
  filter(totals >= 30) |>
  mutate(Medal = forcats::fct_relevel(Medal,'gold','silver','bronze'),
         Country = reorder(Country, totals, max)
  ) |>
  ungroup()

medal_counts2 <- olympics0 |>
  group_by(Country, Medal) |>
  summarise(totals = n()) |>
  mutate(Medal = forcats::fct_relevel(Medal,'gold','silver','bronze'),
         Country = reorder(Country, totals, max)
  ) |>
  ungroup()

medals_per_event <- olympics0 |>
  group_by(Country, Medal, Sport) |>
  summarise(totals = n()) |>
  mutate(
    Country = reorder(Country, totals, max)
  ) |>
  ungroup()

medal_location <- olympics0 |>
  group_by(Country) |>
  summarise(totals = n()) |>
  rename(name = Country) |>
  left_join(world) |>
  select(name, iso_a3, totals)

medal_location <- medal_location |>
  mutate(iso_a3 = if_else(name == "Britain", "GBR", iso_a3),
         iso_a3 = if_else(name == "Liechtenstein", "LIE", iso_a3),
         iso_a3 = if_else(name == "Czech Republic", "CZE", iso_a3)) |>
  filter(!is.na(iso_a3))

world <- ne_countries(returnclass = "sf")

medal_location2 <- olympics0 |>
  group_by(Country, Medal) |>
  summarise(totals = n()) |>
  mutate(Medal = forcats::fct_relevel(Medal,'gold','silver','bronze'),
         name = reorder(Country, totals, max)
  ) |>
  ungroup()

medal_location2 <- medal_location2 |>
  left_join(world) |>
  select(name, totals, Medal, iso_a3)

medal_location2 <- medal_location2 |>
  mutate(iso_a3 = if_else(name == "Britain", "GBR", iso_a3),
         iso_a3 = if_else(name == "Liechtenstein", "LIE", iso_a3),
         iso_a3 = if_else(name == "Czech Republic", "CZE", iso_a3)) |>
  filter(!is.na(iso_a3)) |>
  pivot_wider(names_from = Medal, values_from = totals)

medal_location2 <- medal_location2 |>
  mutate(bronze = ifelse(is.na(bronze), 0, bronze),
         silver = ifelse(is.na(silver), 0, silver),
         gold = ifelse(is.na(gold), 0, gold),
         total = gold + silver + bronze)
