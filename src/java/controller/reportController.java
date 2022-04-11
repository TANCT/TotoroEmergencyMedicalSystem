/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import com.model.forumData;
import com.model.post;
import com.model.post_comment;
import com.model.rating;
import com.model.ratingData;
import com.model.report;
import com.model.reportData;
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
@WebServlet(name = "reportController", urlPatterns = {"/Report"})
public class reportController extends HttpServlet {

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
        String usertype=(String)session.getAttribute("usertype");
        String action=request.getParameter("action");
        
        if(usertype==null)
        {
            response.sendRedirect("login.jsp");
        }
        
        if(action==null)
        {
            if(usertype.equals("admin"))
            {
                List<report> list=reportData.getReportList();
                List<report> reports=new ArrayList<report>();
                String[] type=request.getParameterValues("type");
                String[] status=request.getParameterValues("status");
                
                if(type!=null&&status!=null)
                {
                    for (report r:list)
                    {
                        boolean filter=false;
                        for(int i=0;i<type.length&&filter==false;i++)
                        {
                            if(type[i].equals(r.getType()))
                            {
                                for(int j=0;j<status.length&&filter==false;j++)
                                {
                                    if(status[j].equals(r.getStatus()))
                                    {
                                        reports.add(r);
                                        filter=true;
                                    }
                                }
                            }
                        }
                        
                    }
                }
                else if(type!=null)
                {
                    for (report r:list)
                    {
                        boolean filter=false;
                        for(int i=0;i<type.length&&filter==false;i++)
                        {
                            if(type[i].equals(r.getType()))
                            {
                                
                                reports.add(r);
                                filter=true;
                                
                            }
                        }
                        
                    }
                }
                else if(status!=null)
                {
                    for (report r:list)
                    {
                        boolean filter=false;
                        
                        for(int j=0;j<status.length&&filter==false;j++)
                        {
                            if(status[j].equals(r.getStatus()))
                            {
                                reports.add(r);
                                filter=true;
                            }
                                
                            
                        }
                        
                    }
                }
                else
                {
                    reports=list;
                }
                session.setAttribute("reports", reports);
                RequestDispatcher rd=request.getRequestDispatcher("/report/index.jsp");
                rd.forward(request,response);
            }
            else if(usertype.equals("user"))
            {
                List<report> list=reportData.getUserReportList((Integer) session.getAttribute("userID"));
                List<report> reports=new ArrayList<report>();
                String[] type=request.getParameterValues("type");
                String[] status=request.getParameterValues("status");
                
                if(type!=null||status!=null)
                {
                    for (report r:list)
                    {
                        boolean filter=false;
                        for(int i=0;i<type.length&&filter==false;i++)
                        {
                            if(type[i].equals(r.getType()))
                            {
                                reports.add(r);
                                filter=true;
                            }
                        }
                        for(int j=0;j<status.length&&filter==false;j++)
                        {
                            if(status[j].equals(r.getStatus()))
                            {
                                reports.add(r);
                                filter=true;
                            }
                        }
                    }
                }
                else
                {
                    reports=list;
                }
                session.setAttribute("reports", reports);
                RequestDispatcher rd=request.getRequestDispatcher("/report/index.jsp");
                rd.forward(request,response);
            }
           
        }
        else if(action.equals("CREATE"))
        {
            report newReport=new report();
            newReport.setUserId((Integer) session.getAttribute("userID"));
            newReport.setType(request.getParameter("type"));
            if(newReport.getType().equals("POST"))
            {
                newReport.setPostId(Integer.parseInt(request.getParameter("id")));
            }
            else if(newReport.getType().equals("COMMENT"))
            {
                newReport.setCommentId(Integer.parseInt(request.getParameter("id")));
            }
            else if(newReport.getType().equals("RATING"))
            {
                newReport.setRatingId(Integer.parseInt(request.getParameter("id")));
            }
            
            newReport.setProblem(request.getParameter("problem"));
            newReport.setDescription(request.getParameter("description"));
            
            reportData.createReport(newReport);
            if(newReport.getType().equals("POST")||newReport.getType().equals("COMMENT"))
            {
                response.sendRedirect("Forum");
            }
            else if(newReport.getType().equals("RATING"))
            {
                response.sendRedirect("Rating");
            }
        }
        else if(action.equals("VIEW"))
        {
             int reportId=Integer.parseInt(request.getParameter("reportId"));
             int userid=((Integer) session.getAttribute("userID"));
             
             if(usertype==null)
            {
                response.sendRedirect("login.jsp");
            }
            else if(usertype.equals("admin"))
             {
                 List<report> list=reportData.getReportListWithId(reportId);
                 session.setAttribute("report", list);
                 if(list.get(0).getType().equals("POST"))
                 {
                     post p=forumData.getPost(Integer.toString(list.get(0).getPostId()));
                     session.setAttribute("post", p);
                 }
                 else if(list.get(0).getType().equals("COMMENT"))
                 {
                     post_comment c=forumData.getComment(Integer.toString(list.get(0).getCommentId()));
                     session.setAttribute("comment", c);
                 }
                 else if(list.get(0).getType().equals("RATING"))
                 {
                     rating r=ratingData.getRating(list.get(0).getRatingId());
                     session.setAttribute("rating", r);
                 }
                 
                RequestDispatcher rd=request.getRequestDispatcher("/report/viewAdmin.jsp");
                rd.forward(request,response);
             }
             else if(usertype.equals("user"))
             {
                 report r=reportData.getReport(reportId);
                 session.setAttribute("report", r);
                 if(r.getType().equals("POST"))
                 {
                     post p=forumData.getPost(Integer.toString(r.getPostId()));
                     session.setAttribute("post", p);
                 }
                 else if(r.getType().equals("COMMENT"))
                 {
                     post_comment c=forumData.getComment(Integer.toString(r.getCommentId()));
                     session.setAttribute("comment", c);
                 }
                 else if(r.getType().equals("RATING"))
                 {
                     rating rate=ratingData.getRating(r.getRatingId());
                     session.setAttribute("rating", rate);
                 }
                 if(r.getUserId()==userid)
                 {
                     RequestDispatcher rd=request.getRequestDispatcher("/report/viewUser.jsp");
                    rd.forward(request,response);
                 }
                 else
                 {
                     response.sendRedirect("Report");
                 }
                 
             }
             
        }
        else if(action.equals("APPROVE"))
        {
            if(!usertype.equals("admin"))
            {
                response.sendRedirect("Report");
            }
            else
            {
                String type=request.getParameter("type");
                int id=Integer.parseInt(request.getParameter("id"));
                
                if(type.equals("POST"))
                {
                    reportData.approvePostReport(id);
                }
                else if(type.equals("COMMENT"))
                {
                    reportData.approveCommentReport(id);
                }
                else if(type.equals("RATING"))
                {
                    reportData.approveRatingReport(id);
                }
                
                response.sendRedirect("Report");
            }
        }
        else if(action.equals("REJECT"))
        {
            if(!usertype.equals("admin"))
            {
                response.sendRedirect("Report");
            }
            else
            {
                String type=request.getParameter("type");
                int id=Integer.parseInt(request.getParameter("id"));
                
                if(type.equals("POST"))
                {
                    reportData.rejectPostReport(id);
                }
                else if(type.equals("COMMENT"))
                {
                    reportData.rejectCommentReport(id);
                }
                else if(type.equals("RATING"))
                {
                    reportData.rejectRatingReport(id);
                }
                
                response.sendRedirect("Report");
            }
        }
        
        
        
        
        
        
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet reportController</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet reportController at " + request.getContextPath() + "</h1>");
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
            Logger.getLogger(reportController.class.getName()).log(Level.SEVERE, null, ex);
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(reportController.class.getName()).log(Level.SEVERE, null, ex);
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
            Logger.getLogger(reportController.class.getName()).log(Level.SEVERE, null, ex);
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(reportController.class.getName()).log(Level.SEVERE, null, ex);
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
