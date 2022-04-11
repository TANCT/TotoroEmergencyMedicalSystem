/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.model;

import static com.model.HospitalData.getConnection;
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
public class ArticleData {
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
    public static List<Article> getArticleList() throws SQLException, ClassNotFoundException
    {
        List<Article> list=new ArrayList<Article>();
        Connection con=getConnection();  
        String query="SELECT * FROM article";        
        Statement st = con.createStatement();
        ResultSet rs=st.executeQuery(query);
        
        while(rs.next())
        {
            Article newArticle=new Article();
            newArticle.setId(rs.getInt("id"));
            newArticle.setTitle(rs.getString("title"));
            newArticle.setPhoto(rs.getString("photo"));
            newArticle.setDate(rs.getString("date"));
            newArticle.setPara1(rs.getString("para1"));
            newArticle.setPara2(rs.getString("para2"));
            newArticle.setPara3(rs.getString("para3"));
            newArticle.setPara4(rs.getString("para4"));
            newArticle.setPara5(rs.getString("para5"));
            list.add(newArticle);
        }
        st.close();
        con.close();
        return list;
    }
    public static Article getArticle(String id) throws SQLException, ClassNotFoundException{
        Article article=new Article();
        Connection con=getConnection();  
        String query="SELECT * FROM article WHERE `id`="+id;
        Statement st = con.createStatement();
        ResultSet rs=st.executeQuery(query);
        while(rs.next()){
            article.setId(rs.getInt("id"));
            article.setTitle(rs.getString("title"));
            article.setPhoto(rs.getString("photo"));
            article.setDate(rs.getString("date"));
            article.setPara1(rs.getString("para1"));
            article.setPara2(rs.getString("para2"));
            article.setPara3(rs.getString("para3"));
            article.setPara4(rs.getString("para4"));
            article.setPara5(rs.getString("para5"));  
        }
        return article;
    }
}
