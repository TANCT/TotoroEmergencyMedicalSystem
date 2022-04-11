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
public class reportData {
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
    
    public static List<report> getReportList() throws SQLException, ClassNotFoundException
    {
        List<report> list=new ArrayList<report> ();
        Connection con=getConnection();  
        String query="SELECT * FROM report"
                + " JOIN user ON report.userid=user.userid "
                + " ORDER BY report.date DESC";
        Statement st = con.createStatement();
        ResultSet rs=st.executeQuery(query);
        
        while (rs.next())
        {
            report r=new report();
            r.setReportId(rs.getInt("reportId"));
            r.setUserId(rs.getInt("userId"));
            r.setUsername(rs.getString("name"));
            r.setType(rs.getString("type"));
            if(r.getType().equals("POST"))
            {
                r.setPostId(rs.getInt("postId"));
            }
            else if(r.getType().equals("COMMENT"))
            {
                r.setCommentId(rs.getInt("commentId"));
            }
            else if(r.getType().equals("RATING"))
            {
                r.setRatingId(rs.getInt("ratingId"));
            }
            
            r.setProblem(rs.getString("problem"));
            r.setDescription(rs.getString("description"));
            r.setStatus(rs.getString("status"));
            r.setDate(rs.getString("date"));
            
            list.add(r);
        }
        st.close();
        con.close();
        return list;
    }
    
    public static List<report> getUserReportList(int userid) throws SQLException, ClassNotFoundException
    {
        List<report> list=new ArrayList<report> ();
        Connection con=getConnection();  
        String query="SELECT * FROM report"
                + " JOIN user ON report.userId=user.userid "
                + " WHERE report.userId="+userid
                + " ORDER BY report.date DESC";
        Statement st = con.createStatement();
        ResultSet rs=st.executeQuery(query);
        
        while (rs.next())
        {
            report r=new report();
            r.setReportId(rs.getInt("reportId"));
            r.setUserId(rs.getInt("userId"));
            r.setUsername(rs.getString("name"));
            r.setType(rs.getString("type"));
            if(r.getType().equals("POST"))
            {
                r.setPostId(rs.getInt("postId"));
            }
            else if(r.getType().equals("COMMENT"))
            {
                r.setCommentId(rs.getInt("commentId"));
            }
            else if(r.getType().equals("RATING"))
            {
                r.setRatingId(rs.getInt("ratingId"));
            }
            
            r.setProblem(rs.getString("problem"));
            r.setDescription(rs.getString("description"));
            r.setStatus(rs.getString("status"));
            r.setDate(rs.getString("date"));
            
            list.add(r);
        }
        st.close();
        con.close();
        return list;
    }
    
    public static List<report> getReportListWithId(int reportId) throws SQLException, ClassNotFoundException
    {
        List<report> list=new ArrayList<report> ();
        Connection con=getConnection();  
        String query="SELECT type, postId, commentId, ratingId FROM report"
                + " WHERE report.reportId="+reportId;
        Statement st = con.createStatement();
        ResultSet rs=st.executeQuery(query);
        rs.next();
        String type=rs.getString("type");
        String query2="";
        if(type.equals("POST"))
        {
            query2="SELECT * FROM report"
                + " JOIN user ON report.userId=user.userid "
                + " WHERE report.postId="+rs.getInt("postId")
                + " ORDER BY report.date DESC";
        }
        else if(type.equals("COMMENT"))
        {
            query2="SELECT * FROM report"
                + " JOIN user ON report.userId=user.userid "
                + " WHERE report.commentId="+rs.getInt("commentId")
                + " ORDER BY report.date DESC";
        }
        else if(type.equals("RATING"))
        {
            query2="SELECT * FROM report"
                + " JOIN user ON report.userId=user.userid "
                + " WHERE report.ratingId="+rs.getInt("ratingId")
                + " ORDER BY report.date DESC";
        }
        
        st.close();
        Statement st2 = con.createStatement();
        ResultSet rs2=st2.executeQuery(query2);
        while (rs2.next())
        {
            report r=new report();
            r.setReportId(rs2.getInt("reportId"));
            r.setUserId(rs2.getInt("userId"));
            r.setUsername(rs2.getString("name"));
            r.setType(rs2.getString("type"));
            if(r.getType().equals("POST"))
            {
                r.setPostId(rs2.getInt("postId"));
            }
            else if(r.getType().equals("COMMENT"))
            {
                r.setCommentId(rs2.getInt("commentId"));
            }
            else if(r.getType().equals("RATING"))
            {
                r.setRatingId(rs2.getInt("ratingId"));
            }
            
            r.setProblem(rs2.getString("problem"));
            r.setDescription(rs2.getString("description"));
            r.setStatus(rs2.getString("status"));
            r.setDate(rs2.getString("date"));
            
            list.add(r);
        }
        
        st2.close();
        con.close();
        return list;
    }
    public static report getReport(int reportId) throws SQLException, ClassNotFoundException
    {
        Connection con=getConnection();  
        String query="SELECT * FROM report"
                + " JOIN user ON report.reportId="+reportId;
        Statement st = con.createStatement();
        ResultSet rs=st.executeQuery(query);
        
        rs.next();
        
        report r=new report();
        r.setReportId(rs.getInt("reportId"));
        r.setUserId(rs.getInt("userId"));
        r.setUsername(rs.getString("name"));
        r.setType(rs.getString("type"));
        if(r.getType().equals("POST"))
        {
            r.setPostId(rs.getInt("postId"));
        }
        else if(r.getType().equals("COMMENT"))
        {
            r.setCommentId(rs.getInt("commentId"));
        }
        else if(r.getType().equals("RATING"))
        {
            r.setRatingId(rs.getInt("ratingId"));
        }

        r.setProblem(rs.getString("problem"));
        r.setDescription(rs.getString("description"));
        r.setStatus(rs.getString("status"));
        r.setDate(rs.getString("date"));

        st.close();
        con.close();
        return r;
    }
    
    public static void createReport(report newReport) throws ClassNotFoundException, SQLException
    {
        Connection con=getConnection();  
        String query="";
        if(newReport.getType().equals("POST"))
        {
             query="INSERT INTO report (userId,type,postId,problem,description) "
                + "VALUES (?,?,?,?,?)";    
            
        }
        else if(newReport.getType().equals("COMMENT"))
        {
             query="INSERT INTO report (userId,type,commentId,problem,description) "
                + "VALUES (?,?,?,?,?)";    
        }
        else if(newReport.getType().equals("RATING"))
        {
             query="INSERT INTO report (userId,type,ratingId,problem,description) "
                + "VALUES (?,?,?,?,?)";    
        }
        
        PreparedStatement st = con.prepareStatement(query);
        
        st.setInt(1, newReport.getUserId());
        st.setString(2,newReport.getType());
        
        if(newReport.getType().equals("POST"))
        {
            st.setInt(3, newReport.getPostId());
            
        }
        else if(newReport.getType().equals("COMMENT"))
        {
            st.setInt(3, newReport.getCommentId());
        }
        else if(newReport.getType().equals("RATING"))
        {
            st.setInt(3, newReport.getRatingId());
        }
        
        st.setString(4, newReport.getProblem());
        st.setString(5, newReport.getDescription());
        
        st.executeUpdate();
        st.close();
        con.close();
    }
    
    public static void approvePostReport(int id) throws ClassNotFoundException, SQLException
    {
        Connection con=getConnection();  
        
        String query="UPDATE report SET status='APPROVED' WHERE postId="+id;
        Statement st = con.createStatement();
        st.executeUpdate(query);
        
        String query2="UPDATE post SET hide='1' WHERE postId="+id;
        Statement st2 = con.createStatement();
        st2.executeUpdate(query2);
        st.close();
        st2.close();
        con.close();
    }
    
    public static void rejectPostReport(int id) throws ClassNotFoundException, SQLException
    {
        Connection con=getConnection();  
        
        String query="UPDATE report SET status='REJECTED' WHERE postId="+id;
        Statement st = con.createStatement();
        st.executeUpdate(query);
        
        String query2="UPDATE post SET hide='0' WHERE postId="+id;
        Statement st2 = con.createStatement();
        st2.executeUpdate(query2);
        st.close();
        st2.close();
        con.close();
    }
    
    public static void approveCommentReport(int id) throws ClassNotFoundException, SQLException
    {
        Connection con=getConnection();  
        
        String query="UPDATE report SET status='APPROVED' WHERE commentId="+id;
        Statement st = con.createStatement();
        st.executeUpdate(query);
        
        String query2="UPDATE post_comment SET hide='1' WHERE commentId="+id;
        Statement st2 = con.createStatement();
        st2.executeUpdate(query2);
        st.close();
        st2.close();
        con.close();
    }
    
    public static void rejectCommentReport(int id) throws ClassNotFoundException, SQLException
    {
        Connection con=getConnection();  
        
        String query="UPDATE report SET status='REJECTED' WHERE commentId="+id;
        Statement st = con.createStatement();
        st.executeUpdate(query);
        
        String query2="UPDATE post_comment SET hide='0' WHERE commentId="+id;
        Statement st2 = con.createStatement();
        st2.executeUpdate(query2);
        st.close();
        st2.close();
        con.close();
    }
    
    public static void approveRatingReport(int id) throws ClassNotFoundException, SQLException
    {
        Connection con=getConnection();  
        
        String query="UPDATE report SET status='APPROVED' WHERE ratingId="+id;
        Statement st = con.createStatement();
        st.executeUpdate(query);
        
        String query2="UPDATE rating SET hide='1' WHERE ratingId="+id;
        Statement st2 = con.createStatement();
        st2.executeUpdate(query2);
        st.close();
        st2.close();
        con.close();
    }
    public static void rejectRatingReport(int id) throws ClassNotFoundException, SQLException
    {
        Connection con=getConnection();  
        
        String query="UPDATE report SET status='REJECTED' WHERE ratingId="+id;
        Statement st = con.createStatement();
        st.executeUpdate(query);
        
        String query2="UPDATE rating SET hide='0' WHERE ratingId="+id;
        Statement st2 = con.createStatement();
        st2.executeUpdate(query2);
        st.close();
        st2.close();
        con.close();
    }
}
