-- Création de la base
CREATE DATABASE IF NOT EXISTS cafe_db;

USE cafe_db;

-- Création des tables
-- Table Produit
CREATE TABLE produit (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nom VARCHAR(100),
    categorie VARCHAR(50),
    prix DOUBLE,
    description TEXT,
    image VARCHAR(255)
);

-- Table Contact
CREATE TABLE contact (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nom VARCHAR(100),
    email VARCHAR(100),
    message TEXT,
	lu BOOLEAN NOT NULL DEFAULT FALSE,
    date_envoi DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Table utilisateur
CREATE TABLE utilisateur (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nom VARCHAR(100),
    email VARCHAR(100) UNIQUE,
    mot_de_passe VARCHAR(100),
    role VARCHAR(20) -- "admin" ou "user"
);

-- Table commandes
CREATE TABLE commande (
    id INT AUTO_INCREMENT PRIMARY KEY,
    date_commande DATETIME NOT NULL,
    utilisateur_id INT NOT NULL,
    FOREIGN KEY (utilisateur_id) REFERENCES utilisateur(id)
);
-- Table details_commande
CREATE TABLE details_commande (
    id INT AUTO_INCREMENT PRIMARY KEY,
    commande_id INT NOT NULL,
    produit_id INT NOT NULL,
    quantite INT NOT NULL,
    prix_unitaire DOUBLE NOT NULL,
    FOREIGN KEY (commande_id) REFERENCES commande(id),
    FOREIGN KEY (produit_id) REFERENCES produit(id)
);




