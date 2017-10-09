library(httr)
library(readxl)
library(dplyr)
library(purrr)
#####################
# Download data
#####################
url = paste0("https://inventory.data.gov/dataset/", 
             "794cd3d7-4d28-4408-8f7d-84b820dbf7f2/resource/",
             "6b78ec0c-4980-4ad8-9cbd-2d6eb9eda8e7/download/", 
             "myfoodapediadata.zip")
zipfile = tempfile(fileext = ".zip")
res = httr::GET(url, write_disk(path = zipfile), progress())
httr::stop_for_status(res)
files = unzip(zipfile = zipfile, exdir = tempdir())

data_file = file.path(tempdir(), "Food_Display_Table.xlsx")

df = read_excel(data_file)
bad_calories = df %>% filter(is.na(as.numeric(Calories)))
if (nrow(bad_calories) > 0) {
  stop("New data in calories column - non-numeric!")
}
make_num_vars = c(
  "Portion_Default", "Portion_Amount", "Factor", "Increment", "Multiplier",
  "Grains", "Whole_Grains", "Vegetables", "Orange_Vegetables", 
  "Drkgreen_Vegetables", "Starchy_vegetables", 
  "Other_Vegetables", 
  "Fruits", "Milk", "Meats", "Soy", "Drybeans_Peas", 
  "Oils", "Solid_Fats", 
  "Added_Sugars", "Alcohol", "Calories", "Saturated_Fats")

make_numeric = function(x) {
  x_num = as.numeric(x)
  bad_convert = is.na(x_num) & !is.na(x)
  if (any(bad_convert)) {
    return(x)
  } else {
    return(x_num)
  }
}

df = df %>% mutate_at(vars(Factor:Saturated_Fats), make_numeric)

pc_data = df %>% select(Grains, Vegetables, Fruits, Meats, Solid_Fats, Milk,
              Added_Sugars, Alcohol, Saturated_Fats)

