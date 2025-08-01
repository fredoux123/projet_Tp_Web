

-- Insersion admin 
INSERT INTO utilisateur (nom, email, mot_de_passe, role) VALUES
('Gorgui', 'gorgui@cafeducentre.com', 'admin123', 'admin'),
('Fredy', 'fredy@cafeducentre.com', 'admin123', 'admin');


-- Données initiales pour produit
INSERT INTO Produit (nom, categorie, prix, description, image) VALUES
('Café Espresso', 'Boisson', 2.50, 'Un café court et intense', 'cafe_espresso.jpg'),
('Sandwich Jambon-Fromage', 'Plat', 5.90, 'Pain frais, jambon, fromage fondu', 'sandwitch_jambon.jpg'),
('Salade César', 'Plat', 7.20, 'Poulet grillé, salade romaine, croûtons', 'salade_cesar.jpg'),
('Thé Vert', 'Boisson', 2.00, 'Thé vert bio infusé', 'the_vert.jpg');


-- Quelques messages envoyés par des utilisateurs
INSERT INTO Contact (nom, email, message, lu) VALUES
('Alice Dupont', 'alice@example.com', 'Bonjour, vos horaires sont-ils toujours à jour ?', FALSE),
('Marc Lemoine', 'marc@example.com', 'Puis-je réserver pour un groupe ?', TRUE),
('Sophie Martin', 'sophie@example.com', 'Votre café est excellent ! Merci 😊', TRUE);


-- Commandes passées par les utilisateurs
INSERT INTO commandes (date_commande, utilisateur_id) VALUES
(NOW() - INTERVAL 2 DAY, 1),
(NOW() - INTERVAL 1 DAY, 2);

-- Détails pour commande de Gorgui
INSERT INTO details_commande (commande_id, produit_id, quantite, prix_unitaire) VALUES
(1, 1, 2, 2.50),  -- 2 Espresso
(1, 2, 1, 5.90);  -- 1 Sandwich

-- Détails pour commande de Fredy
INSERT INTO details_commande (commande_id, produit_id, quantite, prix_unitaire) VALUES
(2, 3, 1, 7.20),  -- 1 Salade
(2, 4, 2, 2.00);  -- 2 Thé Vert
