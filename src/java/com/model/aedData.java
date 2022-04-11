/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.model; 
import java.sql.*;  
import java.util.ArrayList;  
import java.util.List;  
import java.util.Vector;
import javax.servlet.http.HttpSession;
/**
 *
 * @author USER
 */
public class aedData {
    public static Connection getConnection(){  
        Connection con=null;     
            String dbName="totoro";
            String url="jdbc:mysql://localhost/"+dbName+"?";
            String userName="root";
            String password="";
        try{  
            Class.forName("com.mysql.jdbc.Driver");  
            con=DriverManager.getConnection(url,userName,password);  
        }catch(ClassNotFoundException | SQLException e){System.out.println(e);}  
        return con;  
    }  
  
    public static List<aed> getRecords(int start,int total) throws SQLException{  
       // List allData = new ArrayList();
        List<aed> list=new ArrayList<aed>();  
            Connection con=getConnection();  
            String query="SELECT * FROM `aed` limit "+(start-1)+","+total;
            Statement st = con.createStatement();
            ResultSet rs=st.executeQuery(query);
            while(rs.next()){  
                aed e=new aed();  
                e.setId(rs.getInt(1));  
                e.setLatitude(rs.getFloat(2));  
                e.setLongitude(rs.getFloat(3));  
                e.setUser(rs.getInt(4));
                e.setStatus(rs.getString(5));
                list.add(e);  
            }  
            return list;  
    }  
}
