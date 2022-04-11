/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import com.model.Hospital;
import com.model.HospitalData;
import com.model.rating;
import com.model.ratingData;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author Asus
 */
@WebServlet(name = "ratingController", urlPatterns = {"/Rating"})
public class ratingController extends HttpServlet {

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
        
        HttpSession session=request.getSession(true);
        String action=request.getParameter("action");
        
        if(action==null)
        {
            List<Hospital> list=HospitalData.getHospitalList();
            List<Hospital> hospitalList=new ArrayList<Hospital>();
            String searchKey=request.getParameter("searchKey");
            //search
            if(searchKey!=null)
            {
                for(Hospital h:list)
                {
                    if(h.getName().toLowerCase().contains(searchKey.toLowerCase()))
                    {
                        hospitalList.add(h);
                    }
                }
            }
            else
            {
                hospitalList=list;
            }
            
            session.setAttribute("hospitalList", hospitalList);
            RequestDispatcher rd=request.getRequestDispatcher("/rating/index.jsp");
            rd.forward(request,response);
        }
        else if(action.equals("VIEW"))
        {
            int hospitalId=Integer.parseInt(request.getParameter("id"));
            Hospital h=HospitalData.getHospital(hospitalId);
            session.setAttribute("hospital",h);
            List<rating> ratingList= ratingData.getRatingList(hospitalId);
            session.setAttribute("ratingList", ratingList);
            RequestDispatcher rd=request.getRequestDispatcher("/rating/viewComment.jsp");
            rd.forward(request,response);
        }
        else if(action.equals("RATE"))
        {
            rating newRating=new rating();
            newRating.setUserid((Integer) session.getAttribute("userID"));
            newRating.setHospitalId(Integer.parseInt(request.getParameter("hospitalId")));
            newRating.setComfort(Integer.parseInt(request.getParameter("comfort")));
            newRating.setCleaniness(Integer.parseInt(request.getParameter("cleaniness")));
            newRating.setService(Integer.parseInt(request.getParameter("service")));
            newRating.setSafety(Integer.parseInt(request.getParameter("safety")));
            newRating.setComment(request.getParameter("comment"));
            
            ratingData.createRating(newRating);
            
            response.sendRedirect("Rating?action=VIEW&id="+newRating.getHospitalId());
        }
        
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet ratingController</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ratingController at " + request.getContextPath() + "</h1>");
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
            Logger.getLogger(ratingController.class.getName()).log(Level.SEVERE, null, ex);
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(ratingController.class.getName()).log(Level.SEVERE, null, ex);
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
            Logger.getLogger(ratingController.class.getName()).log(Level.SEVERE, null, ex);
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(ratingController.class.getName()).log(Level.SEVERE, null, ex);
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
