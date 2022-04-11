/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import com.model.HospitalData;
import com.model.user;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author User
 */
public class manageFriendController extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, ClassNotFoundException, SQLException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            HttpSession session=request.getSession(true);
            if(session.getAttribute("userID")==null){
               response.sendRedirect("/TotoroEmergencyMedical/login.jsp") ;
            }else{
                if(request.getParameter("action")==null){
                    response.sendRedirect("/TotoroEmergencyMedical/login.jsp") ;
                }else if(request.getParameter("action").equals("search")&&request.getParameter("name")!=null&&!request.getParameter("name").isEmpty()){
                    String name=request.getParameter("name");
                    Connection con=HospitalData.getConnection();
                    String query="SELECT * from `user` where `userid`="+String.valueOf(session.getAttribute("userID"));
                    Statement st=con.createStatement();
                    ResultSet rs=st.executeQuery(query);
                    
                    rs.next();
                    
                    String []friends;
                    if(rs.getString("friends")!=null){
                        if(rs.getString("friends").indexOf(",")!=-1){
                            friends=rs.getString("friends").split(","); 
                           
                        }else{
                            friends=new String[1];
                            friends[0]=rs.getString("friends");
                            
                        }
                        
                        
                    }else{
                        friends=null;
                        
                    }
                    
                    
                    
                    String friendList=String.valueOf(session.getAttribute("userID"));
                    if(friends!=null){
                        for(String f:friends){
                        friendList+=","+f;
                    }
                    }
                    
                    
                    con.close();
                    st.close();
                    con=HospitalData.getConnection();
                    st=con.createStatement();
                    
                    
                    query="SELECT * from `user` where `userid` NOT IN ("+friendList+") && `name` LIKE '%"+name+"%'";
                    
                    rs=st.executeQuery(query);
                    
                    ArrayList<user> users=new ArrayList<user>();
                    while(rs.next()){
                        user u=new user();
                        u.setUserid(rs.getInt("userid"));
                        out.print(String.valueOf(rs.getInt("userid")));
                        u.setName(rs.getString("name"));
                        u.setPhone(rs.getString("phone"));
                        users.add(u);
                    }
                    con.close();
                    st.close();
                    request.setAttribute("frienz", users);
                    RequestDispatcher rd=request.getRequestDispatcher("addFriends.jsp");
                    rd.forward(request, response);
                }else if(request.getParameter("action").equals("add")&&request.getParameter("id")!=null&&!request.getParameter("id").isEmpty()){
                    
                    Connection con=HospitalData.getConnection();
                    String query="select `friends` from `user` where `userid`="+String.valueOf(session.getAttribute("userID"));
                    
                    Statement st=con.createStatement();
                    ResultSet rs=st.executeQuery(query);
                    rs.next();
                    String friendList="";
                    if(rs.getString("friends")!=null&&!rs.getString("friends").isEmpty()){
                        friendList=rs.getString("friends")+",";
                    }
                    
                    con.close();
                    st.close();
                    String id=request.getParameter("id");
                    friendList=friendList+id;
                    con=HospitalData.getConnection();
                    
                    query="update `user` set `friends`='"+friendList+"'where `userid`="+String.valueOf(session.getAttribute("userID"));
                    st=con.createStatement();
                    st.executeUpdate(query);
                    con.close();
                    st.close();
                    out.print("<script>alert('Friend AddedSuccessfully');</script>");
                    response.sendRedirect("/TotoroEmergencyMedical/addFriends.jsp");
                    
                }
            }
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            processRequest(request, response);
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(manageFriendController.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(manageFriendController.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            processRequest(request, response);
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(manageFriendController.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(manageFriendController.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
