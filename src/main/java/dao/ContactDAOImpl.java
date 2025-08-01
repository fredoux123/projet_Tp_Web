package dao;

import model.Contact;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import util.JdbcUtils;

public class ContactDAOImpl implements ContactDAO {

    @Override
    public void save(Contact contact) {
        String sql = "INSERT INTO contact (nom, email, message) VALUES (?, ?, ?)";

        try (Connection conn = JdbcUtils.getInstance().getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, contact.getNomComplet());
            stmt.setString(2, contact.getEmail());
            stmt.setString(3, contact.getMessage());
            System.out.println("🔍 Tentative INSERT Contact : nom=" + contact.getNomComplet()
                    + ", email=" + contact.getEmail());

            int rows = stmt.executeUpdate();
            System.out.println("✔️ Lignes insérées : " + rows);

            System.out.println("📧 Contact enregistré avec succès");
        } catch (SQLException e) {
            System.err.println("❌ Erreur lors de l'enregistrement du contact");
            e.printStackTrace();
        }
    }

    @Override
    public List<Contact> findAll() {
        List<Contact> contacts = new ArrayList<>();
        try (Connection conn = JdbcUtils.getInstance().getConnection(); PreparedStatement stmt = conn.prepareStatement("SELECT * FROM contact ORDER BY lu ASC, id DESC"); ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                Contact c = new Contact(
                        rs.getInt("id"),
                        rs.getString("nom"),
                        rs.getString("email"),
                        rs.getString("message"),
                        rs.getBoolean("lu")
                );
                contacts.add(c);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return contacts;
    }

    @Override
    public void delete(int id) {
        String sql = "DELETE FROM contact WHERE id = ?";
        try (Connection conn = JdbcUtils.getInstance().getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Override
    public void marquerCommeLu(int id) {
        String sql = "UPDATE contact SET lu = TRUE WHERE id = ?";
        try (Connection conn = JdbcUtils.getInstance().getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

}
