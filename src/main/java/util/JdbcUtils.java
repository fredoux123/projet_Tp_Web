/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

/**
 *
 * @author gorgu
 */
public class JdbcUtils {

    private static final String URL = "jdbc:mysql://localhost:3306/cafe_db";
    private static final String USER = "root";
    private static final String PASSWORD = "";

    private static JdbcUtils instance;

    static {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            System.out.println("Driver MySQL chargé avec succès");
        } catch (ClassNotFoundException e) {
            System.err.println("Erreur de chargement du driver MySQL");
            e.printStackTrace();
        }
    }

    // Constructeur privé
    private JdbcUtils() {
    }

    // Accès unique à l'instance
    public static JdbcUtils getInstance() {
        if (instance == null) {
            synchronized (JdbcUtils.class) {
                if (instance == null) {
                    instance = new JdbcUtils();
                }
            }
        }
        return instance;
    }

    // Méthode de récupération de connexion
    public Connection getConnection() throws SQLException {
        return DriverManager.getConnection(URL, USER, PASSWORD);
    }
}
