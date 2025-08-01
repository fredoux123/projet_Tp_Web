package dao;

import model.Produit;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import util.JdbcUtils;

public class ProduitDAOImpl implements ProduitDAO {

    @Override
    public List<Produit> findAll() {
        List<Produit> liste = new ArrayList<>();
        try (Connection conn = JdbcUtils.getInstance().getConnection(); Statement stmt = conn.createStatement(); ResultSet rs = stmt.executeQuery("SELECT * FROM produit")) {

            System.out.println("✅ Connexion OK à MySQL");

            while (rs.next()) {
                liste.add(extractProduit(rs));
            }
            System.out.println("📦 Produits récupérés : " + liste.size());
        } catch (SQLException e) {
            System.err.println("❌ Erreur lors de la connexion ou de la récupération des produits");
            e.printStackTrace();
        }
        return liste;
    }

    @Override
    public List<Produit> findByCategorie(String cat) {
        List<Produit> liste = new ArrayList<>();
        try (Connection conn = JdbcUtils.getInstance().getConnection(); PreparedStatement ps = conn.prepareStatement("SELECT * FROM produit WHERE categorie=?")) {
            ps.setString(1, cat);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    liste.add(extractProduit(rs));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return liste;
    }

    @Override
    public Produit findById(int id) {
        try (Connection conn = JdbcUtils.getInstance().getConnection(); PreparedStatement ps = conn.prepareStatement("SELECT * FROM produit WHERE id=?")) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return extractProduit(rs);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    @Override
    public void addProduit(Produit p) {
        try (Connection conn = JdbcUtils.getInstance().getConnection(); PreparedStatement ps = conn.prepareStatement(
                "INSERT INTO produit(nom, categorie, prix, description, image) VALUES (?, ?, ?, ?, ?)")) {
            ps.setString(1, p.getNom());
            ps.setString(2, p.getCategorie());
            ps.setDouble(3, p.getPrix());
            ps.setString(4, p.getDescription());
            ps.setString(5, p.getImage());
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    public void updateProduit(Produit p) {
        try (Connection conn = JdbcUtils.getInstance().getConnection(); PreparedStatement ps = conn.prepareStatement(
                "UPDATE produit SET nom=?, categorie=?, prix=?, description=?, image=? WHERE id=?")) {
            ps.setString(1, p.getNom());
            ps.setString(2, p.getCategorie());
            ps.setDouble(3, p.getPrix());
            ps.setString(4, p.getDescription());
            ps.setString(5, p.getImage());
            ps.setInt(6, p.getId());
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    public void deleteProduit(int id) {
        try (Connection conn = JdbcUtils.getInstance().getConnection(); PreparedStatement ps = conn.prepareStatement("DELETE FROM produit WHERE id=?")) {
            ps.setInt(1, id);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    private Produit extractProduit(ResultSet rs) throws SQLException {
        return new Produit(
                rs.getInt("id"),
                rs.getString("nom"),
                rs.getString("categorie"),
                rs.getDouble("prix"),
                rs.getString("description"),
                rs.getString("image")
        );
    }
}
