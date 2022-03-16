olympics0 <- utils::read.csv('data-raw/winter-olympics.csv')

total_medals <- olympics0 |>
  dplyr::group_by(Country) |>
  dplyr::summarise(totals = n()) |>
  dplyr::filter(totals >= 100) |>
  dplyr::mutate(Country = stats::reorder(Country, totals, max)) |>
  dplyr::ungroup()

medal_counts <- olympics0 |>
  dplyr::group_by(Country, Medal) |>
  dplyr::summarise(totals = n()) |>
  dplyr::filter(totals >= 30) |>
  dplyr::mutate(Medal = forcats::fct_relevel(Medal,'gold','silver','bronze'),
         Country = stats::reorder(Country, totals, max)
  ) |>
  dplyr::ungroup()

medal_counts2 <- olympics0 |>
  dplyr::group_by(Country, Medal) |>
  dplyr::summarise(totals = n()) |>
  dplyr::mutate(Medal = forcats::fct_relevel(Medal,'gold','silver','bronze'),
         Country = stats::reorder(Country, totals, max)
  ) |>
  dplyr::ungroup()

medals_per_event <- olympics0 |>
  dplyr::group_by(Country, Medal, Sport) |>
  dplyr::summarise(totals = n()) |>
  dplyr::mutate(
    Country = reorder(Country, totals, max)
  ) |>
  dplyr::ungroup()

medal_location <- olympics0 |>
  dplyr::group_by(Country) |>
  dplyr::summarise(totals = n()) |>
  dplyr::rename(name = Country) |>
  dplyr::left_join(world) |>
  dplyr::select(name, iso_a3, totals)

world <- rnaturalearth::ne_countries(returnclass = "sf")

medal_location2 <- olympics0 |>
  dplyr::group_by(Country, Medal) |>
  dplyr::summarise(totals = n()) |>
  dplyr::mutate(Medal = forcats::fct_relevel(Medal,'gold','silver','bronze'),
         name = stats::reorder(Country, totals, max)
  ) |>
  ungroup()

medal_location2 <- medal_location2 |>
  dplyr::left_join(world) |>
  dplyr::select(name, totals, Medal, iso_a3)

medal_location2 <- medal_location2 |>
  dplyr::mutate(iso_a3 = dplyr::if_else(name == "Britain", "GBR", iso_a3),
         iso_a3 = dplyr::if_else(name == "Liechtenstein", "LIE", iso_a3),
         iso_a3 = dplyr::if_else(name == "Czech Republic", "CZE", iso_a3)) |>
  dplyr::filter(!is.na(iso_a3)) |>
  tidyr::pivot_wider(names_from = Medal, values_from = totals)

medal_location2 <- medal_location2 |>
  dplyr::mutate(bronze = base::ifelse(is.na(bronze), 0, bronze),
         silver = base::ifelse(is.na(silver), 0, silver),
         gold = base::ifelse(is.na(gold), 0, gold),
         total = gold + silver + bronze)

usethis::use_data(total_medals, overwrite = TRUE)
usethis::use_data(medal_counts, overwrite = TRUE)
usethis::use_data(medal_counts2, overwrite = TRUE)
usethis::use_data(medal_location2, overwrite = TRUE)
usethis::use_data(medals_per_event, overwrite = TRUE)
