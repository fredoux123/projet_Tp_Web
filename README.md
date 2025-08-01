# 🧾 TP2 - Projet Web : Gestion d’une Cafétéria

## 1. 🎯 Contexte du projet
Ce projet s’inscrit dans le cadre d’un TP de développement d’une application web dynamique à architecture **MVC**.  
Le thème choisi est la gestion d'une **cafétéria**, avec deux profils d’utilisateurs :
- 👤 **Client** (utilisateur régulier)
- 🛠️ **Admin** (gestionnaire)

---

## 2. ✅ Objectifs fonctionnels

### a) Pour les utilisateurs (clients) :
- 📝 Créer un compte (inscription)
- 🔐 Se connecter via un formulaire sécurisé
- 📜 Parcourir le menu de la cafétéria
- 🔎 Filtrer les produits par catégorie (plats, boissons, desserts)
- 🔍 Rechercher un produit par mot-clé
- 🛒 Ajouter un produit au panier
- 🧾 Valider ses commandes
- ✉️ Envoyer un message via le formulaire de contact

### b) Pour l’admin (en plus des opérations client) :
- ➕ Ajouter de nouveaux produits
- 🛠️ Modifier les produits existants
- ❌ Supprimer un produit du menu
- 📬 Consulter les messages envoyés
- 📦 Voir la liste des commandes passées
- 🔍 Accéder aux détails d’une commande
- 🔔 Voir le nombre de messages non lus (badge dynamique)

---

## 3. 🧱 Architecture et organisation du projet

### a. Architecture MVC
- **Model** : `Utilisateur`, `Produit`, `Commande`, `Contact`, etc.
- **View** : JSP (`menu.jsp`, `accueil.jsp`, `contact.jsp`, `panier.jsp`, etc.)
- **Controller** : Servlets (`LoginServlet`, `RegisterServlet`, `ServletPanier`, etc.)

### b. Structure des fichiers
- `WEB-INF/classes/i18n` :  
  - `messages_fr.properties`  
  - `messages_en.properties`
- `css`, `images`, `js`, `includes` : Ressources bien séparées
- `admin/` : Pages d’administration protégées
- Autres : Pages utilisateur accessibles librement

### c. Accès à la base de données
- Utilisation de **JDBC** avec le **DAO pattern** pour :
  - Lire / Insérer / Modifier / Supprimer : produits, utilisateurs, commandes, messages
  - Connexion centralisée via `JdbcUtils`
- Base de données : **MySQL**

---

## 4. 🌐 Internationalisation (i18n)
- Langues supportées :
  - 🇫🇷 Français
  - 🇬🇧 Anglais
- Ressources :
  - `messages_fr.properties`
  - `messages_en.properties`
- Filtrage via un `LocaleFilter` (`?lang=fr`, `?lang=en`)
- Utilisation dans les JSP via `bundle.getString("clé")`

---

## 5. 🧪 Fonctionnalités techniques réalisées
- 🔐 Connexion / inscription sécurisée
- 🧮 Affichage dynamique du menu avec filtrage (catégorie + recherche)
- 🛍️ Ajout au panier avec session
- ❗ Gestion des erreurs (login incorrect, validations manquantes)
- 🔔 Notification de messages non lus pour l’admin
- 🛡️ Validation des formulaires côté serveur
- 💬 Modals Bootstrap intégrés (Login/Register)
- ✅ Messages de succès dynamiques (Bootstrap Alerts)
- 💻 Responsive Design avec **Bootstrap 5**
- 📁 Séparation stricte des fichiers : `JS`, `CSS`, `Includes`, `Images`, `JSP`
- 🔐 Sécurisation des pages admin (`/WEB-INF/admin/`)