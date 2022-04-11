/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author User
 */
public class notificationController extends HttpServlet {

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
            if(session.getAttribute("username")==null){
                response.sendRedirect("login.jsp");
            }else if(request.getParameterValues("friend")==null){
                response.sendRedirect("findFriend.jsp");
            }else{
            int from=(Integer)session.getAttribute("userID");
            String []friends=request.getParameterValues("friend");
            String body=request.getParameter("body");
            
            String driver="com.mysql.jdbc.Driver";
            String dbName="totoro";
            String url="jdbc:mysql://localhost/"+dbName+"?";
            String userName="root";
            String password="";
            String query="";
             String locate = request.getParameter("location");
            Class.forName(driver);//load and register driver

            Connection con=DriverManager.getConnection(url,userName,password);
            
            for(int i=0; i<friends.length;i++){
                
                query="INSERT INTO `notification`(`title`,`body`,`from`,`to`,`location`)VALUES(?,?,?,?,?)";
                PreparedStatement st=con.prepareStatement(query);
                st.setString(1,new String("Asking for Help"));
                st.setString(2,body);
                st.setInt(3,from);
                st.setInt(4,Integer.parseInt(friends[i]));
st.setString(5,locate);
                st.executeUpdate();
                st.close();
                
            }
            
            con.close();

            response.sendRedirect("findFriend.jsp");
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
            Logger.getLogger(notificationController.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(notificationController.class.getName()).log(Level.SEVERE, null, ex);
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
            Logger.getLogger(notificationController.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(notificationController.class.getName()).log(Level.SEVERE, null, ex);
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
