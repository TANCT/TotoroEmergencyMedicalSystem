/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import com.model.HospitalData;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Statement;
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
public class hospitalController extends HttpServlet {

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
            throws ServletException, IOException, SQLException, ClassNotFoundException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            HttpSession session=request.getSession(true);
            if(session.getAttribute("usertype")==null)
            {
                out.println("<script>alert('Please Login First');location.href='/TotoroEmergencyMedical/login.jsp'</script>");
                //response.sendRedirect("/TotoroEmergencyMedical/login.jsp");
            }else if(!session.getAttribute("usertype").equals("admin")){
                out.println("<script>alert('Only Admin can access');location.href='/TotoroEmergencyMedical/login.jsp'</script>");
            }else if(request.getParameter("action")==null){
                response.sendRedirect("/TotoroEmergencyMedical/admin/EmergencyContact/viewContact.jsp");
            }else{
                String action= request.getParameter("action");
                if(action.equals("create")){
                    if(request.getParameter("name")==null){
                        response.sendRedirect("/TotoroEmergencyMedical/admin/EmergencyContact/viewContact.jsp");
                    }else{
                        String name=request.getParameter("name");
                        String phone=request.getParameter("phone");
                        String lat=request.getParameter("lat");
                        String lon=request.getParameter("lon");
                        String query="INSERT INTO `hospital`(`name`,`phone`,`lat`,`lon`)VALUES('"+name+"','"+phone+"',"+lat+","+lon+")";
                        Connection con=HospitalData.getConnection();
                        Statement st=con.createStatement();
                        st.executeUpdate(query);
                        st.close();
                        con.close();
                        response.sendRedirect("/TotoroEmergencyMedical/admin/EmergencyContact/viewContact.jsp");
                    }
                }else if(action.equals("edit")){
                    if(request.getParameter("id")==null){
                        response.sendRedirect("/TotoroEmergencyMedical/admin/EmergencyContact/viewContact.jsp");
                    }else{
                        String id=request.getParameter("id");
                        String name=request.getParameter("name");
                        String phone=request.getParameter("phone");
                        String lat=request.getParameter("lat");
                        String lon=request.getParameter("lon");                   
                        String query="UPDATE `hospital` SET `name`='"+name+"',`phone`='"+phone+"',`lat`="+lat+",`lon`="+lon+" where `id`="+id;                       
                        Connection con=HospitalData.getConnection();
                        Statement st=con.createStatement();
                        st.executeUpdate(query);
                        st.close();
                        con.close();
                        response.sendRedirect("/TotoroEmergencyMedical/admin/EmergencyContact/viewContact.jsp");
                    }
                    
                }else if(action.equals("delete")){
                    if(request.getParameter("id")==null){
                            response.sendRedirect("/TotoroEmergencyMedical/admin/EmergencyContact/viewContact.jsp");
                        }else{                            
                            String id=request.getParameter("id");
                            String query="DELETE FROM `hospital` WHERE `id`="+id;                        
                            Connection con=HospitalData.getConnection();
                            Statement st=con.createStatement();
                            st.executeUpdate(query);
                            st.close();
                            con.close();
                            response.sendRedirect("/TotoroEmergencyMedical/admin/EmergencyContact/viewContact.jsp");
                        }
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
        } catch (SQLException ex) {
            Logger.getLogger(hospitalController.class.getName()).log(Level.SEVERE, null, ex);
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(hospitalController.class.getName()).log(Level.SEVERE, null, ex);
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
            Logger.getLogger(hospitalController.class.getName()).log(Level.SEVERE, null, ex);
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(hospitalController.class.getName()).log(Level.SEVERE, null, ex);
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
