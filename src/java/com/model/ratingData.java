/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author Asus
 */
public class ratingData {
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
    
    public static List<rating> getRatingList(int hospitalId) throws SQLException, ClassNotFoundException
    {
        List<rating> list=new ArrayList<rating>();
        Connection con=getConnection();  
        String query="SELECT * from rating "
                + "JOIN user ON rating.userid=user.userid "
                + "WHERE rating.hide=0 AND rating.hospitalId="+hospitalId
                + " ORDER BY rating.date DESC";
        Statement st = con.createStatement();
        ResultSet rs=st.executeQuery(query);
        
        while(rs.next())
        {
            rating newrating=new rating();
            newrating.setRatingId(rs.getInt("ratingId"));
            newrating.setHospitalId(rs.getInt("hospitalId"));
            newrating.setUserid(rs.getInt("userid"));
            newrating.setComfort(rs.getInt("comfort"));
            newrating.setCleaniness(rs.getInt("cleaniness"));
            newrating.setService(rs.getInt("service"));
            newrating.setSafety(rs.getInt("safety"));
            newrating.setComment(rs.getString("comment"));
            newrating.setAvg(rs.getFloat("avg"));
            newrating.setDate(rs.getString("date"));
            newrating.setUsername(rs.getString("name"));
            
            list.add(newrating);
        }
        st.close();
        con.close();
        return list;
    }
    
    public static void createRating(rating newRating) throws ClassNotFoundException, SQLException
    {
        Connection con=getConnection();  
        String query="INSERT INTO rating (hospitalId,userid,comfort,cleaniness,service,safety,comment,avg) VALUES (?,?,?,?,?,?,?,?)";
        PreparedStatement st = con.prepareStatement(query);
        
        st.setInt(1,newRating.getHospitalId());
        st.setInt(2, newRating.getUserid());
        st.setInt(3, newRating.getComfort());
        st.setInt(4, newRating.getCleaniness());
        st.setInt(5, newRating.getService());
        st.setInt(6, newRating.getSafety());
        st.setString(7, newRating.getComment());
        float avg=(newRating.getComfort()+newRating.getCleaniness()+newRating.getService()+newRating.getSafety())/4;
        st.setFloat(8, avg);
        st.executeUpdate();
        
        Hospital hospitalUpdate=HospitalData.getHospital(newRating.getHospitalId());
        String query2="UPDATE hospital SET ratingNo=?, avgRating=? WHERE id="+newRating.getHospitalId();
        PreparedStatement st2 = con.prepareStatement(query2);
        
        int ratingNo=hospitalUpdate.getRatingNo()+1;
        float avgRating=((hospitalUpdate.getAvgRating()*hospitalUpdate.getRatingNo())+avg)/ratingNo;
        
        st2.setInt(1,ratingNo );
        st2.setFloat(2, avgRating);
        
        st2.executeUpdate();
        
        st.close();
        st2.close();
        con.close();
    }
    
    public static rating getRating(int ratingId) throws SQLException, ClassNotFoundException
    {
        Connection con=getConnection();  
        String query="SELECT * from rating "
                + "JOIN user ON rating.userid=user.userid "
                + "WHERE rating.ratingId="+ratingId
                + " ORDER BY rating.date DESC";
        Statement st = con.createStatement();
        ResultSet rs=st.executeQuery(query);
        
        rs.next();
        
        rating newrating=new rating();
        newrating.setRatingId(rs.getInt("ratingId"));
        newrating.setHospitalId(rs.getInt("hospitalId"));
        newrating.setUserid(rs.getInt("userid"));
        newrating.setComfort(rs.getInt("comfort"));
        newrating.setCleaniness(rs.getInt("cleaniness"));
        newrating.setService(rs.getInt("service"));
        newrating.setSafety(rs.getInt("safety"));
        newrating.setComment(rs.getString("comment"));
        newrating.setAvg(rs.getFloat("avg"));
        newrating.setDate(rs.getString("date"));
        newrating.setUsername(rs.getString("name"));

        st.close();
        con.close();
        return newrating;
    }
}
