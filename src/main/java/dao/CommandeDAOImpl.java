package dao;

import model.Commande;
import model.DetailCommande;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import util.JdbcUtils;

public class CommandeDAOImpl implements CommandeDAO {

    @Override
    public void sauvegarderCommande(Commande commande) {
        String insertCommande = "INSERT INTO commande (date_commande, utilisateur_id) VALUES (?, ?)";
        String insertDetail = "INSERT INTO details_commande (commande_id, produit_id, quantite, prix_unitaire) VALUES (?, ?, ?, ?)";

        try (Connection conn = JdbcUtils.getInstance().getConnection()) {
            conn.setAutoCommit(false);

            PreparedStatement psCommande = conn.prepareStatement(insertCommande, Statement.RETURN_GENERATED_KEYS);
            psCommande.setTimestamp(1, new Timestamp(commande.getDateCommande().getTime()));
            psCommande.setInt(2, commande.getUtilisateurId());
            psCommande.executeUpdate();

            ResultSet rs = psCommande.getGeneratedKeys();
            if (rs.next()) {
                int commandeId = rs.getInt(1);
                for (DetailCommande d : commande.getDetails()) {
                    PreparedStatement psDetail = conn.prepareStatement(insertDetail);
                    psDetail.setInt(1, commandeId);
                    psDetail.setInt(2, d.getProduitId());
                    psDetail.setInt(3, d.getQuantite());
                    psDetail.setDouble(4, d.getPrixUnitaire());
                    psDetail.executeUpdate();
                }
            }

            conn.commit();
        } catch (SQLException e) {
            e.printStackTrace();
        }

    }

    @Override
    public List<Commande> findAll() {
        List<Commande> commandes = new ArrayList<>();
        String sql = "SELECT c.id, c.date_commande, c.utilisateur_id, "
                + "u.nom, u.email, "
                + "SUM(dc.quantite * dc.prix_unitaire) AS montant_total "
                + "FROM commande c "
                + "JOIN utilisateur u ON c.utilisateur_id = u.id "
                + "JOIN details_commande dc ON c.id = dc.commande_id "
                + "GROUP BY c.id, c.date_commande, c.utilisateur_id, u.nom, u.email";

        try (Connection conn = JdbcUtils.getInstance().getConnection(); PreparedStatement ps = conn.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Commande c = new Commande();
                c.setId(rs.getInt("id"));
                c.setDateCommande(rs.getTimestamp("date_commande"));
                c.setUtilisateurId(rs.getInt("utilisateur_id"));
                c.setUtilisateurNom(rs.getString("nom"));
                c.setUtilisateurEmail(rs.getString("email"));
                c.setMontant(rs.getDouble("montant_total"));

                commandes.add(c);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return commandes;
    }

    @Override
    public Commande findById(int id) {
        String sql = "SELECT c.id, c.date_commande, c.utilisateur_id, u.nom, u.email, "
                + "SUM(dc.quantite * dc.prix_unitaire) AS montant_total "
                + "FROM commande c "
                + "JOIN utilisateur u ON c.utilisateur_id = u.id "
                + "JOIN details_commande dc ON c.id = dc.commande_id "
                + "WHERE c.id = ? "
                + "GROUP BY c.id, u.id, u.nom, u.email";

        try (Connection conn = JdbcUtils.getInstance().getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    Commande c = new Commande();
                    c.setId(rs.getInt("id"));
                    c.setDateCommande(rs.getTimestamp("date_commande"));
                    c.setUtilisateurId(rs.getInt("utilisateur_id"));
                    c.setMontant(rs.getDouble("montant_total"));
                    c.setUtilisateurNom(rs.getString("nom"));
                    c.setUtilisateurEmail(rs.getString("email"));
                    c.setMontant(rs.getDouble("montant_total"));
                    // charger détails :
                    c.setDetails(getDetailsForCommande(c.getId(), conn));
                    return c;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    private List<DetailCommande> getDetailsForCommande(int commandeId, Connection conn) throws SQLException {
        String sql = "SELECT dc.produit_id, dc.quantite, dc.prix_unitaire, p.nom AS produit_nom "
                + "FROM details_commande dc "
                + "JOIN produit p ON dc.produit_id = p.id "
                + "WHERE dc.commande_id = ?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, commandeId);
            try (ResultSet rs = ps.executeQuery()) {
                List<DetailCommande> details = new ArrayList<>();
                while (rs.next()) {
                    DetailCommande d = new DetailCommande();
                    d.setProduitId(rs.getInt("produit_id"));
                    d.setQuantite(rs.getInt("quantite"));
                    d.setPrixUnitaire(rs.getDouble("prix_unitaire"));
                    d.setProduitNom(rs.getString("produit_nom")); 
                    details.add(d);
                }
                return details;
            }
        }
    }

}
