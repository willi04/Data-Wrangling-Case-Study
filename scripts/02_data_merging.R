#Import files
file_to_import <- list.files("data_row", pattern = ".csv", full.names = TRUE)

list_of_dfs <- lapply(file_to_import, read.csv)

full_data <- do.call(rbind, list_of_dfs)

dim(full_data)

