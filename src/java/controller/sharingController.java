/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;
import java.lang.String;
import java.util.ArrayList;
import java.util.ListIterator;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author USER
 */
public class sharingController extends HttpServlet {

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

String act=request.getParameter("action");
if(act.equals("stop")){
HttpSession session=request.getSession(true);
 int id=(Integer)session.getAttribute("userID");
String name=(String)session.getAttribute("username");
        String query="";
            String driver="com.mysql.jdbc.Driver";           
            String dbName="totoro";
            String url="jdbc:mysql://localhost/"+dbName+"?";
            String userName="root";
            String password="";
            
            Class.forName(driver);
            Connection con=DriverManager.getConnection(url,userName,password);
        
            query="UPDATE user SET sharing=? where userid="+id;
            PreparedStatement ps = con.prepareStatement(query);
            ps.setInt(1,0);
            ps.executeUpdate();
            String sharingStatus="Not sharing location";
            session.setAttribute("shareState",sharingStatus);

String findNotiQuery ="";
findNotiQuery = "SELECT * FROM `notification` WHERE `from`=? AND `status`=?";
PreparedStatement pst = con.prepareStatement(findNotiQuery);
        pst.setInt(1, id);
        pst.setString(2, "unread");
        ResultSet rs=pst.executeQuery();
ArrayList<Integer> friend=new ArrayList<Integer>();
while(rs.next()){
friend.add(rs.getInt("to"));
}
pst.close();
/*ListIterator<Integer> it = friend.listIterator();
int j=0;
while (it.hasNext()) {
  int t = it.next();
  int prev = it.previous();
    if(t==prev){
    friend.remove(t);

}else{
break;
}
}
try{
for(int j=0;j<friend.size();j++){

if(friend.get(j+1)!=null){
if(friend.get(j)==friend.get(j+1)){
friend.remove(j+1);
}
}else{
break;
}
}
}
catch(Exception e){ 
     System.out.println("<h1>Servlet sharingController at " + friend+ "</h1>");
    }*/
String query3="";
for(int i=0; i<friend.size();i++){
                
                query3="INSERT INTO `notification`(`title`,`from`,`to`)VALUES(?,?,?)";
                PreparedStatement st=con.prepareStatement(query3);
                st.setString(1,new String(name+" had stop sharing the location."));
                st.setInt(2,id);
                st.setInt(3,friend.get(i));
                st.executeUpdate();
                st.close();
                
            }

            response.sendRedirect("index.jsp");
}

        try (PrintWriter out = response.getWriter()) {

            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet sharingController</title>");            
            out.println("</head>");
            out.println("<body>");

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
        } catch (SQLException ex) {
            Logger.getLogger(aedController.class.getName()).log(Level.SEVERE, null, ex);
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(sharingController.class.getName()).log(Level.SEVERE, null, ex);
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
        } catch (SQLException ex) {
            Logger.getLogger(aedController.class.getName()).log(Level.SEVERE, null, ex);
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(sharingController.class.getName()).log(Level.SEVERE, null, ex);
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
