# Load data
rest_1_orders <- read.csv(file = "restaurant-1-orders.csv")

# Remove drink orders
rest_1_orders <- rest_1_orders[!grepl('wine', rest_1_orders$Item.Name),]
rest_1_orders <- rest_1_orders[!grepl('Water', rest_1_orders$Item.Name),]
rest_1_orders <- rest_1_orders[!grepl('Coke', rest_1_orders$Item.Name),]
rest_1_orders <- rest_1_orders[!grepl('Lemonade', rest_1_orders$Item.Name),]

# Group by Item.Name, sum Quantity, take avg Price (price should be constant, tho)
rest_1_orders$Item.Name <- as.factor(rest_1_orders$Item.Name)
name_and_quant <- data.frame(
  Item.Name = rest_1_orders$Item.Name,
  Quantity = rest_1_orders$Quantity,
  Product.Price = rest_1_orders$Product.Price
)
name_and_quant <- name_and_quant %>%
  group_by(Item.Name) %>%
  summarise(Total.Quantity = sum(Quantity),
            Product.Price = mean(Product.Price))

# Add the proportion for each Item of #-item-orders / #-all-items-ordered
total_num_items = sum(name_and_quant$Total.Quantity)
name_and_quant$Prop.of.Total = name_and_quant$Total.Quantity / total_num_items

# Include variable denoting omnivore/herbivore status (i.e., whether dish has meat or not)
name_and_quant$Meat.Veg = "Veg"
name_and_quant$Item.Name <- as.character(name_and_quant$Item.Name)
name_and_quant <- name_and_quant %>% mutate(Meat.Veg =
                                              ifelse(str_detect(Item.Name, "Fish") |
                                                       str_detect(Item.Name, "Beef") |
                                                       str_detect(Item.Name, "Chicken") |
                                                       str_detect(Item.Name, "Pork") |
                                                       str_detect(Item.Name, "Lamb") |
                                                       str_detect(Item.Name, "Goat") |
                                                       str_detect(Item.Name, "Prawn") |
                                                       str_detect(Item.Name, "Meat") |
                                                       str_detect(Item.Name, "Tandoori Mixed"),
                                                     "Meat", Meat.Veg))
