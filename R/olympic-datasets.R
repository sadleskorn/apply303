#' @title Total Winter Olympic Medals won by each country
#'
#' A dataset containing the total medals won by each country, assuming the country
#' has won at least 100 medals
#'
#' @format A data frame with 14 rows and 2 variables:
#' \describe{
#'   \item{Country}{name of country, as referred to by the USA}
#'   \item{totals}{total number of medals, in counts}
#' }
#' @examples
#' glimpse(total_medals)
#'
#' total_medals |>
#' plot_ly(x = ~Country, y = ~totals) %>%
#'  add_bars() |>
#'  layout(title = "Norway has more Winter Olympic Medals than All Other Countries<br> (1924 - 2014)")
NULL

#' Medal Counts for Winter Olympics by Country
#'
#' A dataset containing the medals and places won by each country, assuming the country
#' has won at least 100 total medals
#'
#' @format A data frame with 42 rows and 3 variables:
#' \describe{
#'   \item{Country}{name of country, as referred to by the USA}
#'   \item{Medal}{type of medal, factor with levels "gold", "silver" or "bronze"}
#'   \item{totals}{number of medals of that type, in counts}
#' }
#' @examples
#' head(medal_counts)
#'
#' medal_counts |>
#' mutate(Medal = forcats::fct_relevel(Medal,'bronze','silver','gold'),
#'       Country = reorder(Country, totals, sum)) |>
#'  plot_ly(x = ~Country, y = ~totals, color = ~Medal) %>%
#'  add_bars() |>
#'  layout(barmode = "stack",
#'         hovermode = "x") |>
#'  layout(title = "Norway Has the Most Gold, Silver, <br> and Bronze Winter Olympic Medals <br> (1924 - 2014)")
NULL

#' Medal Counts for Winter Olympics by Country
#'
#' A dataset containing the medals and places won by each country, assuming the country
#' has won at least 1 total medal
#'
#' @format A data frame with 117 rows and 3 variables:
#' \describe{
#'   \item{Country}{name of country, as referred to by the USA}
#'   \item{Medal}{type of medal, factor with levels "gold", "silver" or "bronze"}
#'   \item{totals}{number of medals of that type, in counts}
#' }
#' @examples
#' data(medal_counts2)
#'
#' medal_counts2 |>
#' mutate(Medal = forcats::fct_relevel(Medal,'bronze','silver','gold'),
#'       Country = reorder(Country, totals, sum)) |>
#'  plot_ly() %>%
#'  add_bars(x = ~Country, y = ~totals, color = ~Medal, colors = c("#CD7F32", "#C0C0C0", "#FFD700")) |>
#'  layout(hovermode = "x") |>
#'  layout(title = "Norway Has the Most Gold, Silver, <br> and Bronze Winter Olympic Medals <br> (1924 - 2014)") |>
#'  layout(
#'    yaxis = list(title = "Total Medals"),
#'    xaxis = list(rangeslider = list(type = "date")),
#'    updatemenus = list(list(type = "buttons", direction = "right", x = 0.9, y = 0.98,
#'                            buttons = list(
#'                              list(method = "relayout", args = list("barmode", "group"),
#'                                   label = "Dodge"),
#'                              list(method = "relayout", args = list("barmode", "stack"),
#'                                   label = "Stack")
#'                            ))))
NULL

#' Medal Counts for Winter Olympics by Country per event
#'
#' A dataset containing the medals and places won by each country,
#' in each event, assuming the country has won at least 1 total medal
#'
#' @format A data frame with 565 rows and 4 variables:
#' \describe{
#'   \item{Country}{name of country, as referred to by the USA}
#'   \item{Medal}{type of medal, factor with levels "gold", "silver" or "bronze"}
#'   \item{Sport}{name of sport, as recognized by the IOC}
#'   \item{totals}{number of medals of that type, in counts}
#' }
#' @examples
#' glimpse(medals_per_event)
#'
#' bscols(widths = c(2,NA),
#' list(
#'  filter_select("Sport", "Sport", shared_medals, ~Sport)
#' ),
#' ggplotly(shared_medals %>%
#'           ggplot(aes(Country, totals)) +
#'           geom_point(aes(color = Medal, label = Sport))  +
#'           theme(axis.text.x = element_blank(), axis.ticks.x = element_blank()) +
#'           scale_color_manual(values=c("#FFD700", "#C0C0C0", "#CD7F32")) +
#'           labs(x = "Country <br> (alphabetical)", y = "Medals Won", size = "",
#'                title = "Medals per Country <br> Split by Event")))
NULL

#' Medal Counts for Winter Olympics by Country
#'
#' A dataset containing the medals and places won by each country, assuming the country
#' has won at least 1 total medal; helpful for geospatial mapping
#'
#' @format A data frame with 36 rows and 6 variables:
#' \describe{
#'   \item{name}{name of country, as referred to by the USA}
#'   \item{iso_a3}{country code, as referred to by the UN}
#'   \item{bronze}{number of bronze medals, in counts}
#'   \item{gold}{number of gold medals, in counts}
#'   \item{silver}{number of silver medals, in counts}
#'   \item{total}{total number of medals, sum of bronze, gold, and silver}
#' }
#' @examples
#' head(medal_location2)
#'
#' plot_ly(medal_location2,
#' type='choropleth',
#' locations=medal_location2$iso_a3,
#' z=medal_location2$total, text=medal_location2$hover, colorscale="Blues",
#' reversescale = TRUE) |> # make darker countries = more medals
#'  layout(title = "Winter Olympic Medals Won per Country <br> (1924 - 2014)") |>
#'  colorbar(title = "Total Medals")
NULL

