
## 📄 Project: Waste Collection Data Pipeline

### (Pipeline de Données de Collecte de Déchets)

---

### 🇫🇷 Version Française

**Description :**
Ce projet automatise le nettoyage et l'analyse de données provenant de multiples capteurs de collecte de déchets. Il transforme des fichiers CSV bruts et hétérogènes en un jeu de données propre, anonymisé et prêt pour l'analyse statistique.

**Points Clés du Pipeline :**

* **Ingestion Massive :** Fusion automatique de fichiers multiples via `lapply` et `do.call`.
* **Nettoyage Regex :** Extraction précise des codes postaux au milieu de chaînes de caractères complexes.
* **Normalisation Temporelle :** Conversion de plus de 5 formats de dates différents en format standard ISO (`YYYY-MM-DD`).
* **Conformité RGPD :** Anonymisation des identifiants collecteurs par hachage aléatoire.
* **Qualité des Données :** Gestion des doublons "métier" (priorité aux mesures maximales) et détection des valeurs manquantes.

**Résultat Visuel :**
Le script génère une distribution des poids collectés, permettant d'identifier immédiatement la performance moyenne (environ 50kg) et les pics de collecte (jusqu'à 99.47kg).

---

### 🇬🇧 English Version

**Description:**
This project automates the cleaning and analysis of data from multiple waste collection sensors. It transforms raw, heterogeneous CSV files into a clean, anonymized dataset ready for statistical modeling.

**Technical Highlights:**

* **Bulk Ingestion:** Automated merging of multiple files using `lapply` and `do.call`.
* **Regex Cleaning:** Precise extraction of ZIP codes from complex, "dirty" address strings.
* **Temporal Normalization:** Conversion of 5+ different date formats into standard ISO format (`YYYY-MM-DD`).
* **GDPR Compliance:** Anonymization of collector IDs via random mapping and hashing.
* **Data Integrity:** Advanced deduplication logic (keeping the maximum weight for identical timestamps).

**Visual Output:**
The pipeline generates a distribution of collected weights, highlighting average performance (approx. 50kg) and peak collection events (up to 99.47kg).

---

### 🛠️ Structure du Projet / Project Structure

* `/data_raw`: Fichiers CSV bruts (Raw data)
* `/data_clean`: Fichier final nettoyé (Final cleaned dataset)
* `01_setup.R`: Préparation de l'environnement
* `02_merging.R`: Fusion des fichiers
* `03_cleaning.R`: Nettoyage, Regex et Anonymisation
* `04_visualization.R`: Génération du graphique final

---