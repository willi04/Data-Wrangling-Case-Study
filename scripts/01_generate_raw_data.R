#Loading librairies
library(tidyverse)

#Function to generate messy data 
generate_messy_data <- function(nom_fichier) {
  #Creating a little frame for 5 files 
  df <- data.frame(
    #Creating identification
    collector_id = 1:5,
    
    #messy data
    collection_date = c("2026-03-01", "02/03/2026", "March 3rd 2026", "2026.03.04", "05-03-26"),
    
    #Editing messy adress
    site_address = c("Rue de Prague 12000 !!", "Avenue CAR, 75001 Paris", "Zone 4 [85000]", "Point 10 - 33000", "Site 5 / 67000 / RAS"),
    
    # Generate random wight of waste
    waste_weight = runif(5, min = 10, max = 100), 
    file_source = nom_fichier
  )
  # Save this file in 'data_raw' folder
  write.csv(df, paste0("data_row/", nom_fichier), row.names = FALSE)
}

for (c in 1:5) {
  nom_fichier <- paste0("data_month_",c,".csv")
  
  generate_messy_data(nom_fichier)
}
