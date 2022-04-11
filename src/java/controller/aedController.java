/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import com.model.aed;
import com.model.user;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.Vector;
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
 * @author USER
 */
public class aedController extends HttpServlet {

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
            throws ServletException, IOException, SQLException {
        response.setContentType("text/html;charset=UTF-8");
        
        
        
         String action = request.getParameter("action");
        HttpSession session=request.getSession(true);
        
        String query="";
        String query2="";
            String driver="com.mysql.jdbc.Driver";           
            String dbName="totoro";
            String url="jdbc:mysql://localhost/"+dbName+"?";
            String userName="root";
            String password="";
            
            try {
                Class.forName(driver);
            } catch (ClassNotFoundException ex) {
                Logger.getLogger(aedController.class.getName()).log(Level.SEVERE, null, ex);
            }
            Connection con=DriverManager.getConnection(url,userName,password);
        
            query="SELECT * FROM `aed` inner join `user` where aed.user=user.userid";
            //query2="SELECT COUNT(*) FROM `aed`";
            Statement st=con.createStatement();
            //Statement st2=con.createStatement();
            ResultSet rs=st.executeQuery(query);
            //ResultSet rs2=st2.executeQuery(query2);
            Vector<aed> aedList = new Vector<aed>();
            ArrayList<String> userList = new ArrayList<String>();
            Vector<user> userStorage = new Vector<user>();
            String uName ="";
            while(rs.next()){
                aed addItem = new aed();
                user nameItem = new user();
                    addItem.setId(rs.getInt("id"));
                    addItem.setLatitude(rs.getFloat("latitude"));
                    addItem.setLongitude(rs.getFloat("longitude"));
                    addItem.setUser(rs.getInt("user"));
                    addItem.setStatus(rs.getString("status"));
                    nameItem.setName(rs.getString("name"));
                    userStorage.addElement(nameItem);
                    aedList.addElement(addItem);
            }
            
            session.setAttribute("userList",userStorage);
            session.setAttribute("list", aedList );
            Vector<aed> aedSessionList = (Vector<aed>)session.getAttribute("list");
            if(aedSessionList==null){
                response.sendRedirect("/trackAED.jsp");
            }
            
        if (action.equals("ADD"))
            {
                String latitude = request.getParameter("la");
                String longitude  = request.getParameter("long");
                float lati = Float.parseFloat(latitude);
                float longi = Float.parseFloat(longitude);
                query="INSERT INTO aed(latitude,longitude,user) VALUES(?,?,?)";
                PreparedStatement pst = con.prepareStatement(query);
                pst.setFloat(1, lati);
                pst.setFloat(2, longi);
                String user = session.getAttribute("userID").toString();
                int uID = Integer.parseInt(user);
                pst.setInt(3,uID);
                pst.executeUpdate();
                
                aed item = new aed();
                //user itemUser = new user();
                item.setLatitude(lati);
                item.setLongitude(longi);
                item.setUser(uID);
                aedList.addElement(item);
                //userStorage.addElement();
                
               /* query="SELECT * FROM `aed` inner join `user` where aed.user=user.userid";
            //query2="SELECT COUNT(*) FROM `aed`";
            Statement st4=con.createStatement();
            //Statement st2=con.createStatement();
            ResultSet rs4=st4.executeQuery(query);
                while(rs4.next()){
                aed addItem = new aed();
                user nameItem = new user();
                    addItem.setId(rs4.getInt("id"));
                    addItem.setLatitude(rs4.getFloat("latitude"));
                    addItem.setLongitude(rs4.getFloat("longitude"));
                    addItem.setUser(rs4.getInt("user"));
                    nameItem.setName(rs4.getString("name"));
                    userStorage.addElement(nameItem);
                    aedList.addElement(addItem);
            }*/
                session.setAttribute("list", aedList);
                
                /*query2="SELECT * FROM `user` where `userid`="+uID;
                Statement st3=con.createStatement();
                ResultSet rs3=st3.executeQuery(query2);
                String name;
                user newName = new user();
                while(rs3.next()){
                    name = rs3.getString("name");
                    newName.setName(name);
                }
                userStorage.addElement(newName);
                session.setAttribute("userList",userStorage);*/
                
                response.sendRedirect("/TotoroEmergencyMedical/aedController?action=VIEW&page=1");
            }
        else if(action.equals("VIEW")){
            String pg = request.getParameter("page");
            int pageid=Integer.parseInt(pg);  
            query="SELECT * FROM `aed` left join `user` ON `aed`.`user`=`user`.`userid`";
            Statement st5=con.createStatement();
            ResultSet rs5=st5.executeQuery(query);
            while(rs5.next()){
                    uName=rs5.getString("name");
                    userList.add(uName);
            }
            session.setAttribute("user",userList);
            RequestDispatcher rd = request.getRequestDispatcher("/aed/viewAEDList.jsp?page="+pageid);
            rd.forward(request,response);
            
            
        }
        else if(action.equals("DELETE")){
            String id=request.getParameter("id");
            query2="DELETE FROM `aed` WHERE id="+id;
            Statement st2 = con.createStatement();
            st2.executeUpdate(query2);
            int aedID = Integer.parseInt(id);
            for(int j=0; j<aedList.size(); j++)
            {
                if(aedList.elementAt(j).getId()==aedID){
                   aedList.remove(j);
                   userStorage.remove(j);
                }
            }
            session.setAttribute("list", aedList );
            session.setAttribute("userList",userStorage);
            response.sendRedirect("/TotoroEmergencyMedical/aedController?action=VIEW&page=1");
        }
        else if(action.equals("UPDATE")){
            String id=request.getParameter("id");
            String latitude = request.getParameter("lat");
            String longitude  = request.getParameter("long");
            String state = "";
            if(request.getParameter("newStatus")!=null){
                state="Active";
            }else{
                state="Inactive";
            }
            int realID = Integer.parseInt(id);
            float lati = Float.parseFloat(latitude);
            float longi = Float.parseFloat(longitude);
        
            query="UPDATE aed SET id=?,latitude=?,longitude=?,status=? where id="+realID;
            PreparedStatement ps = con.prepareStatement(query);
            ps.setInt(1,realID);
            ps.setFloat(2,lati);
            ps.setFloat(3, longi);
            ps.setString(4,state);
            ps.executeUpdate();
            
            response.sendRedirect("/TotoroEmergencyMedical/aedController?action=VIEW&page=1");
            
        }
                
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet aedController</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet aedController at " + request.getContextPath() + "</h1>");
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
