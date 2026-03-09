# 1. On prépare la fenêtre graphique
# On choisit une couleur sympa (ex: "seagreen" pour l'environnement)
color_env <- "seagreen3"

# 2. Création de l'histogramme
hist(full_data_anon$waste_weight, 
     main = "Distribution du Poids des Déchets Collectés",
     xlab = "Poids (kg)", 
     ylab = "Fréquence (Nombre de collectes)",
     col = color_env,
     border = "white",
     breaks = 10) # On définit 10 barres pour voir la précision

# 3. On ajoute la "Ligne de Performance" (Moyenne)
# lty = 2 pour une ligne pointillée, lwd = 3 pour l'épaisseur
abline(v = mean(full_data_anon$waste_weight, na.rm = TRUE), 
       col = "red", 
       lty = 2, 
       lwd = 3)

# 4. On ajoute une petite légende pour faire "pro"
legend("topright", legend = "Moyenne", col = "red", lty = 2, lwd = 3)