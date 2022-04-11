package com.totoro;

import com.model.user;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.swing.JOptionPane;

/**
 *
 * @author USER
 */
public class loginServlet extends HttpServlet {

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
            String username = request.getParameter("username");
            String userpwd = request.getParameter("password");
            HttpSession session=request.getSession(true);
            String query="";
            String driver="com.mysql.jdbc.Driver";           
            String dbName="totoro";
            String url="jdbc:mysql://localhost/"+dbName+"?";
            String userName="root";
            String password="";
        //query="SELECT `userid` FROM `user` WHERE `name`='"+user+"'";
        
        Class.forName(driver);
        Connection con=DriverManager.getConnection(url,userName,password);
        query="SELECT * FROM `user` WHERE `name`=? AND `password`=?";
        PreparedStatement pst = con.prepareStatement(query);
        //Statement st=con.createStatement();
        pst.setString(1, username);
        pst.setString(2, userpwd);
        ResultSet rs=pst.executeQuery();
        
                if(rs.next()){
                        session.setAttribute("username",username);
                        int id = Integer.parseInt(rs.getString(5));
                        session.setAttribute("userID",id);
                        String usertype=rs.getString("usertype");
                        session.setAttribute("usertype",usertype);
int shareState = rs.getInt("sharing");
String sharingStatus = "Not sharing location";
if(shareState==1){
sharingStatus="Sharing location...";
}
String phone = rs.getString("phone");
            String friends = rs.getString("friends");
            String email = rs.getString("email");
            String bio = rs.getString("bio");
            String profilepic = rs.getString("profilepic");
               
            user user;
                user = new user();
            user.setName(username);
            user.setPassword(userpwd);
            user.setPhone(phone);
            user.setFriends(friends);
            user.setUserid(id);
            user.setUsertype(usertype);
            user.setEmail(email);
            user.setBio(bio);
            user.setProfilepic(profilepic);
            user.setSharing(shareState);
            session.setAttribute("user",user);
            session.setAttribute("shareState",sharingStatus);
session.setAttribute("shareState",sharingStatus);
                        response.sendRedirect("index.jsp");
                }else{
                    out.println("<script type=\"text/javascript\">");
   out.println("alert('Wrong ID or password. Please try again.');");
   out.println("location='login.jsp';");
   out.println("</script>");
                }
               
                 pst.close();
                 con.close();
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet loginServlet</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet loginServlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
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
            Logger.getLogger(loginServlet.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(loginServlet.class.getName()).log(Level.SEVERE, null, ex);
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
            Logger.getLogger(loginServlet.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(loginServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

}