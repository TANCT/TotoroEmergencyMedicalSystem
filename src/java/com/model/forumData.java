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
import java.util.HashSet;
import java.util.List;
import java.util.Set;

/**
 *
 * @author Asus
 */
public class forumData {
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
    
    public static List<post> getPosts() throws SQLException, ClassNotFoundException{  
       // List allData = new ArrayList();
            List<post> list=new ArrayList<post>();  
            Connection con=getConnection();  
            String query="SELECT *, name from post"
                    + " INNER JOIN user ON post.userid=user.userid"
                    + " WHERE post.hide=0"
                    + " ORDER BY post.date DESC";
            Statement st = con.createStatement();
            ResultSet rs=st.executeQuery(query);
            while(rs.next()){  
                post newpost=new post();  
                newpost.setUserid(rs.getInt("userid"));
                newpost.setUsername(rs.getString("name"));
                newpost.setCategory(rs.getString("category"));
                newpost.setDate(rs.getString("date"));
                newpost.setPostId(rs.getInt("postId"));
                newpost.setSubject(rs.getString("subject"));
                newpost.setDescription(rs.getString("description"));
                newpost.setPhoto(rs.getString("photo"));
                newpost.setUrl(rs.getString("url"));
                newpost.setCommentNo(rs.getInt("commentNo"));
                newpost.setInitialdate(rs.getString("initialdate"));
                list.add(newpost);  
            }  
            st.close();
            con.close();
            return list;  
            
    }  
    public static post getPost(String postId) throws ClassNotFoundException, SQLException
    {
        post p=new post();
        Connection con=getConnection();  
        String query="SELECT * from post "
                    + "JOIN user ON post.userid=user.userid "
                    + " WHERE post.postId="+postId;        
        Statement st = con.createStatement();
        ResultSet rs=st.executeQuery(query);
        rs.next();
        
        p.setUserid(rs.getInt("userid"));
        p.setUsername(rs.getString("name"));
        p.setCategory(rs.getString("category"));
        p.setDate(rs.getString("date"));
        p.setPostId(rs.getInt("postId"));
        p.setSubject(rs.getString("subject"));
        p.setDescription(rs.getString("description"));
        p.setPhoto(rs.getString("photo"));
        p.setUrl(rs.getString("url"));
        p.setCommentNo(rs.getInt("commentNo"));
        p.setInitialdate(rs.getString("initialdate"));
        
        st.close();
        con.close();
        return p;
    }
    public static List<post_comment> getComments(String postId) throws ClassNotFoundException, SQLException
    {
        List<post_comment> comments=new ArrayList<post_comment>();
        Connection con=getConnection();  
        String query="SELECT * from post_comment "
                    + "JOIN user ON post_comment.userid=user.userid "
                    + " WHERE post_comment.hide=0 AND post_comment.postId="+postId
                    + " ORDER BY post_comment.date DESC";       
        Statement st = con.createStatement();
        ResultSet rs=st.executeQuery(query);
        
        while(rs.next())
        {
            post_comment c=new post_comment();
            c.setCommentId(rs.getInt("commentId"));
            c.setComment(rs.getString("comment"));
            c.setDate(rs.getString("date"));
            c.setPostId(rs.getInt("postId"));
            c.setUserid(rs.getInt("userid"));
            c.setUsername(rs.getString("name"));
            comments.add(c);
        }
        
       
        st.close();
        con.close();
        return comments;
    }
    
    public static void createPost(post newPost) throws ClassNotFoundException, SQLException
    {
        Connection con=getConnection();  
        String query="INSERT INTO post (subject,description,category,photo,url,userid) VALUES (?,?,?,?,?,?)";
        PreparedStatement st = con.prepareStatement(query);
        
        st.setString(1,newPost.getSubject());
        st.setString(2, newPost.getDescription());
        st.setString(3, newPost.getCategory());
        
        if(newPost.getPhoto().length()!=0)
        {
            st.setString(4, newPost.getPhoto());
        }
        else
        {
            st.setString(4, null);
        }
        if(newPost.getUrl().length()!=0)
        {
            st.setString(5, newPost.getUrl());
        }
        else
        {
            st.setString(5,null);
        }
        
        st.setInt(6,newPost.getUserid());
        st.executeUpdate();
        st.close();
        con.close();
    }
    public static void editPost(post editPost) throws ClassNotFoundException, SQLException
    {
        Connection con=getConnection();  
        String query="Update post set subject=?,description=?,category=?,photo=?,url=? where postId="+editPost.getPostId();
        PreparedStatement st = con.prepareStatement(query);
        
        st.setString(1,editPost.getSubject());
        st.setString(2, editPost.getDescription());
        st.setString(3, editPost.getCategory());
        
        if(editPost.getPhoto().length()!=0)
        {
            st.setString(4, editPost.getPhoto());
        }
        else
        {
            st.setString(4, null);
        }
        if(editPost.getUrl().length()!=0)
        {
            st.setString(5, editPost.getUrl());
        }
        else
        {
            st.setString(5,null);
        }
        
        st.executeUpdate();
        st.close();
        con.close();
    }
    public static void deletePost(int postId) throws ClassNotFoundException, SQLException
    {
        Connection con=getConnection();  
        String query_comment="DELETE FROM post_comment WHERE postId="+postId;
        String query="DELETE FROM post WHERE postId="+postId;
        Statement st=con.createStatement();
        st.execute(query_comment);
        st.executeUpdate(query);
        
        st.close();
        con.close();
    }
    
    public static void comment(post_comment newComment) throws ClassNotFoundException, SQLException
    {
        Connection con=getConnection();  
        String query="INSERT INTO post_comment (postId,userid,comment) VALUES (?,?,?)";
        PreparedStatement st = con.prepareStatement(query);
        
        st.setInt(1,newComment.getPostId());
        st.setInt(2,newComment.getUserid());
        st.setString(3,newComment.getComment());
        
        st.executeUpdate();
        
        String query2="Update post set commentNo=commentNo+1 where postId="+newComment.getPostId();
        Statement st2=con.createStatement();
        st2.executeUpdate(query2);
        
        st.close();
        st2.close();
        con.close();
    }
    
    public static post_comment getComment(String commentId) throws ClassNotFoundException, SQLException
    {
        
        Connection con=getConnection();  
        String query="SELECT * from post_comment "
                    + "JOIN user ON post_comment.userid=user.userid "
                    + " WHERE post_comment.commentId="+commentId;    
        Statement st = con.createStatement();
        ResultSet rs=st.executeQuery(query);
        
        rs.next();
        
        post_comment c=new post_comment();
        c.setCommentId(rs.getInt("commentId"));
        c.setComment(rs.getString("comment"));
        c.setDate(rs.getString("date"));
        c.setPostId(rs.getInt("postId"));
        c.setUserid(rs.getInt("userid"));
        c.setUsername(rs.getString("name"));

       
        st.close();
        con.close();
        return c;
    }
}


