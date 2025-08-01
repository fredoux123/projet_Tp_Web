/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

/**
 *
 * @author gorgu
 */
import java.util.List;
import model.Contact;

public interface ContactDAO {
    void save(Contact contact);
    List<Contact> findAll();
    void delete(int id);
    void marquerCommeLu(int id);
}
