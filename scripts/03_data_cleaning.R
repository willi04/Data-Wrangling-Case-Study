# Utilisation d'une Regex un peu plus musclée
# \b signifie "boundary" (limite de mot) : cela évite de prendre 5 chiffres 
# qui seraient au milieu d'une série de 10 chiffres par exemple.

pattern_postal <- "\\b\\d{5}\\b"

# Extraction sécurisée
matches <- regmatches(full_data$site_address, regexpr(pattern_postal, full_data$site_address))

# Que faire si une ligne n'a PAS de code postal ?
# Voici l'astuce de pro :
full_data$zip_code <- sapply(regmatches(full_data$site_address, regexpr(pattern_postal, full_data$site_address)), 
                             function(x) if(length(x) > 0) x else NA)

# Normalisation des formats de date
# 1. On tente le format avec des points : 2026.03.04
dot_dates <- as.Date(full_data$collection_date, format = "%Y.%m.%d")
full_data$date_clean[is.na(full_data$date_clean)] <- dot_dates[is.na(full_data$date_clean)]

# 2. On tente le format court avec tirets : 05-03-26 (%y pour l'année sur 2 chiffres)
short_dash_dates <- as.Date(full_data$collection_date, format = "%d-%m-%y")
full_data$date_clean[is.na(full_data$date_clean)] <- short_dash_dates[is.na(full_data$date_clean)]

# Vérification finale du score
final_count <- sum(!is.na(full_data$date_clean))
print(paste("Dates sauvées :", final_count, "sur 25"))

print(full_data[, c("collection_date", "date_clean")])

View(full_data)

# Traçage des doublons
#+# 1. On compte combien de lignes sont des copies conformes
nb_doublons <- sum(duplicated(full_data))
print(paste("Nombre de doublons parfaits détectés :", nb_doublons))

# 2. On crée un tableau propre sans ces copies
full_data_unique <- unique(full_data)
print(full_data_unique)

#////////////////////
# --- ÉTAPE 1 : On s'assure d'avoir nos IDs ---
# On repart du tableau fusionné (celui qui avait 25 ou 20 lignes)

# --- ÉTAPE 2 : Création de la table de correspondance ---
# On extrait les IDs AVANT de supprimer quoi que ce soit
unique_ids <- unique(full_data$collector_id)

# Sécurité : on vérifie si unique_ids n'est pas vide
if(length(unique_ids) == 0) {
  stop("ERREUR : La colonne collector_id est vide ou absente !")
}

# On génère les codes secrets
anonymized_keys <- paste0("ID_", sample(1000:9999, length(unique_ids)))

# On crée la table de mapping
mapping_table <- data.frame(original = unique_ids, secret = anonymized_keys)

# --- ÉTAPE 3 : La Fusion (Merge) ---
# On ajoute la colonne 'secret' au grand tableau
full_data_anon <- merge(full_data, mapping_table, 
                        by.x = "collector_id", 
                        by.y = "original", 
                        all.x = TRUE)

# --- ÉTAPE 4 : Le Nettoyage Final ---
# MAINTENANT on peut supprimer l'ancienne colonne sensible
full_data_anon$collector_id <- NULL

# On renomme 'secret' en 'collector_id' pour que ce soit propre
names(full_data_anon)[names(full_data_anon) == "secret"] <- "collector_id"

# Vérification
print(head(full_data_anon))
View(full_data_anon)

#+++++++++++++++
# 1. On crée le dossier de sortie s'il n'existe pas
if (!dir.exists("data_clean")) {
  dir.create("data_clean")
}

# 2. On exporte le tableau final en CSV
# row.names = FALSE évite d'ajouter une colonne de chiffres inutile à gauche
write.csv(full_data_anon, "data_clean/waste_collection_final.csv", row.names = FALSE)

print("Fichier final sauvegardé dans data_clean/ !")

################################
# On extrait le nom du jour (ex: "Lundi", "Monday")
full_data_anon$day_name <- weekdays(full_data_anon$date_clean)

# On crée une colonne Weekend (VRAI si c'est Samedi ou Dimanche)
# Attention : le nom dépend de la langue de votre système !
full_data_anon$is_weekend <- full_data_anon$day_name %in% c("samedi", "dimanche", "Saturday", "Sunday")

# Vérification rapide
table(full_data_anon$day_name, full_data_anon$is_weekend)