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
 * @author User
 */
public class NotificationData {
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
    
    public static List<Notification> getNotificationHistory(int to) throws SQLException, ClassNotFoundException
    {
        List<Notification> list=new ArrayList<Notification>();
        Connection con=getConnection();  
        String query="SELECT*FROM `notification` INNER JOIN `user` ON `notification`.`from` = `user`.`userid` where `to`="+String.valueOf(to)+" ORDER BY `date` DESC";       
        Statement st = con.createStatement();
        ResultSet rs=st.executeQuery(query);
        
        while(rs.next())
        {
            Notification noti=new Notification();
            noti.setFriendName(rs.getString("name"));
            noti.setId(rs.getInt("id"));
            noti.setTitle(rs.getString("title"));
            noti.setBody(rs.getString("body"));
            noti.setDate(rs.getString("date"));
            noti.setFrom(rs.getInt("from"));
            noti.setTo(rs.getInt("to"));
            noti.setStatus(rs.getString("status"));
            list.add(noti);
        }
        st.close();
        con.close();
        return list;
    }
    
}
