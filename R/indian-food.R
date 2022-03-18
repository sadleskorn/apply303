#' @title Takeout orders from an Indian restaurant.
#'
#' A dataset containing the total quantity of each dish ordered, as well as the dish's price and status as vegetarian or meat.
#'
#' @format A dataframe with 238 rows and 5 variables:
#' \describe{
#' \item{Item.Name}{Name of the dish}
#' \item{Total.Quantity}{Number of times the dish was ordered}
#' \item{Product.Price}{Price of the dish}
#' \item{Prop.of.Total}{Proportion of all orders}
#' \item{Meat.Veg}{Whether the dish is vegetarian (Veg) or not (Meat)} }
#'
#' @examples
#' glimpse(name_and_quant)
#'
#' name_and_quant %>% group_by(Meat.Veg) %>%
#' summarise(Num.Dishes.Sold = sum(Total.Quantity),
#' Total.Revenue = sum(Total.Quantity * Product.Price))

"name_and_quant"
