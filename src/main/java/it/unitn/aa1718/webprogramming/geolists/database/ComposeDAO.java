package it.unitn.aa1718.webprogramming.geolists.database;

import it.unitn.aa1718.webprogramming.geolists.database.models.Compose;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

/**
 * DAO pattern for Compose relation
 * @author tommaso
 */
public class ComposeDAO {

    private Compose createCompose(ResultSet rs) throws SQLException {
        return new Compose(rs.getLong("LIST"), rs.getLong("ITEM"));
    }
    
    public List<Compose> getItemsID(long listID) {
        String query = "SELECT * FROM Compose AS C WHERE C.list = " + listID;
        List<Compose> list = new ArrayList<>();
        
        try {
            Connection c = Database.openConnection();
            Statement s = c.createStatement();
            ResultSet rs = s.executeQuery(query);
            
            while (rs.next()) {
                list.add(createCompose(rs));
            }
            
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        
        return list;
    }
    
    public List<Compose> getListID(long itemID) {
        String query = "SELECT * FROM Compose AS C WHERE C.item = " + itemID;
        List<Compose> list = new ArrayList<>();
        
        try {
            Connection c = Database.openConnection();
            Statement s = c.createStatement();
            ResultSet rs = s.executeQuery(query);
            
            while (rs.next()) {
                list.add(createCompose(rs));
            }
            
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        
        return list;
    }

    public List<Compose> getAll() {
        String query = "SELECT * FROM Compose";
        List list = new ArrayList<>();
        
        try {
            Connection c = Database.openConnection();
            Statement s = c.createStatement();
            ResultSet rs = s.executeQuery(query);
            
            while (rs.next()) { 
                list.add(createCompose(rs));
            }
            
            rs.close();
            s.close();
            Database.closeConnection(c);
            
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        
        return list;
    }
    
    public boolean addItemToList(long itemID, long listID) {
        String query = "INSERT INTO Compose(LIST,ITEM) VALUES(?,?)";
        boolean success = true;
        
        try {
            Connection c = Database.openConnection();
            PreparedStatement ps = c.prepareStatement(query);
            
            ps.setLong(1, listID);
            ps.setLong(2, itemID);
            
            ps.executeUpdate();
            ps.close();
            Database.closeConnection(c);
            
        } catch (SQLException ex) {
            ex.printStackTrace();
            success = false;
        }
        
        return success;
    }
    
    public boolean removeItemFromList(long itemID, long listID){
        String query = "DELETE FROM Compose WHERE LIST=? AND ITEM=?";
        boolean success = true;
        
        try {
            Connection c = Database.openConnection();
            PreparedStatement ps = c.prepareStatement(query);
            
            ps.setLong(1, listID);
            ps.setLong(2, itemID);
            
            ps.executeUpdate();
            ps.close();
            Database.closeConnection(c);
            
        } catch (SQLException ex) {
            ex.printStackTrace();
            success = false;
        }
        
        return success;
    }
}
