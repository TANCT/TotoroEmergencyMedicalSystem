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
public class NewsData {
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
    public static List<News> getNewsList() throws SQLException, ClassNotFoundException
    {
        List<News> list=new ArrayList<News>();
        Connection con=getConnection();  
        String query="SELECT * FROM news";        
        Statement st = con.createStatement();
        ResultSet rs=st.executeQuery(query);
        
        while(rs.next())
        {
            News news=new News();
            news.setId(rs.getInt("id"));
            news.setTitle(rs.getString("title"));
            news.setPhoto(rs.getString("photo"));
            news.setDate(rs.getString("date"));
            news.setPara1(rs.getString("para1"));
            news.setPara2(rs.getString("para2"));
            news.setPara3(rs.getString("para3"));
            news.setPara4(rs.getString("para4"));
            news.setPara5(rs.getString("para5"));
            list.add(news);
        }
        st.close();
        con.close();
        return list;
    }
    public static News getNews(String id) throws SQLException, ClassNotFoundException{
        News news=new News();
        Connection con=getConnection();  
        String query="SELECT * FROM news WHERE `id`="+id;
        Statement st = con.createStatement();
        ResultSet rs=st.executeQuery(query);
        while(rs.next()){
            news.setId(rs.getInt("id"));
            news.setTitle(rs.getString("title"));
            news.setPhoto(rs.getString("photo"));
            news.setDate(rs.getString("date"));
            news.setPara1(rs.getString("para1"));
            news.setPara2(rs.getString("para2"));
            news.setPara3(rs.getString("para3"));
            news.setPara4(rs.getString("para4"));
            news.setPara5(rs.getString("para5"));  
        }
        return news;
    }
}
