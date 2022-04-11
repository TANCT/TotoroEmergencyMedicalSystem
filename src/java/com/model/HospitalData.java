/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author Asus
 */
public class HospitalData {
    public static Connection getConnection() throws ClassNotFoundException, SQLException{  
            String driver="com.mysql.jdbc.Driver";           
            String dbName="totoro";
            String url="jdbc:mysql://localhost/"+dbName+"?";
            String userName="root";
            String password="";
            Class.forName(driver);
            Connection con=DriverManager.getConnection(url,userName,password);
            return con;
    }  
    
    public static List<Hospital> getHospitalList() throws SQLException, ClassNotFoundException
    {
        List<Hospital> list=new ArrayList<Hospital>();
        Connection con=getConnection();  
        String query="SELECT * FROM hospital";        
        Statement st = con.createStatement();
        ResultSet rs=st.executeQuery(query);
        
        while(rs.next())
        {
            Hospital newHospital=new Hospital();
            newHospital.setId(rs.getInt("id"));
            newHospital.setName(rs.getString("name"));
            newHospital.setPhone(rs.getString("phone"));
            newHospital.setLat(rs.getFloat("lat"));
            newHospital.setLon(rs.getFloat("lon"));
            newHospital.setAvgRating(rs.getFloat("avgRating"));
            newHospital.setRatingNo(rs.getInt("ratingNo"));
            newHospital.setPhoto(rs.getString("photo"));
            list.add(newHospital);
        }
        st.close();
        con.close();
        return list;
    }
    
    public static Hospital getHospital(int id) throws SQLException, ClassNotFoundException
    {
        Hospital hospital=new Hospital();
        Connection con=getConnection();  
        String query="SELECT * FROM hospital"
                + " WHERE hospital.id="+id;
        Statement st = con.createStatement();
        ResultSet rs=st.executeQuery(query);
        
        rs.next();

        hospital.setId(rs.getInt("id"));
        hospital.setName(rs.getString("name"));
        hospital.setPhone(rs.getString("phone"));
        hospital.setLat(rs.getFloat("lat"));
        hospital.setLon(rs.getFloat("lon"));
        hospital.setAvgRating(rs.getFloat("avgRating"));
        hospital.setRatingNo(rs.getInt("ratingNo"));
        hospital.setPhoto(rs.getString("photo"));
        
        st.close();
        con.close();
        return hospital;
    }
}
