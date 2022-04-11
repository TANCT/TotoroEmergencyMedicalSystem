/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import com.model.forumData;
import com.model.post;
import com.model.post_comment;
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
@WebServlet(name = "forumController", urlPatterns = {"/Forum"})
public class forumController extends HttpServlet {

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
            List<post> list=forumData.getPosts();
            List<post> posts=new ArrayList<post>();
            String category=request.getParameter("category");
            String searchKey=request.getParameter("searchKey");
            String id=request.getParameter("id");
            //search with category
            if(category!=null)
            {
                for(post p:list)
                {
                    if(category.equals(p.getCategory()))
                    {
                        posts.add(p);
                    }
                }
            }
            //search with searchkey
            else if (searchKey!=null)
            {
                for(post p:list)
                {
                    searchKey=searchKey.toLowerCase();
                    if(p.getSubject().toLowerCase().contains(searchKey)||
                            p.getDescription().toLowerCase().contains(searchKey)||
                            p.getUsername().toLowerCase().contains(searchKey))
                    {
                        posts.add(p);
                    }
                }
            }
            //search with user
            else if(id!=null)
            {
                for(post p:list)
                {
                    if(p.getUserid()==Integer.parseInt(id))
                    {
                        posts.add(p);
                    }
                }
            }
            else
            {
                posts=list;
            }
            
            session.setAttribute("posts", posts);
            RequestDispatcher rd=request.getRequestDispatcher("/forum/index.jsp");
            rd.forward(request,response);
        }
        else if (action.equals("VIEW"))
        {
            String postId=request.getParameter("postId");
            post p=forumData.getPost(postId);
            List<post_comment> comments=forumData.getComments(postId);
            session.setAttribute("post", p);
            session.setAttribute("comments", comments);
            
            RequestDispatcher rd=request.getRequestDispatcher("/forum/viewPost.jsp");
            rd.forward(request,response);
        }
        else if (action.equals("CREATE"))
        {
            post newPost=new post();
            newPost.setUserid((Integer) session.getAttribute("userID"));
            newPost.setCategory(request.getParameter("category"));
            newPost.setSubject(request.getParameter("subject"));
            newPost.setDescription(request.getParameter("description"));
            newPost.setPhoto(request.getParameter("photo"));
            newPost.setUrl(request.getParameter("url"));
            forumData.createPost(newPost);
            
           response.sendRedirect("Forum");
            
        }
        else if(action.equals("EDIT"))
        {
            if(request.getParameter("edited")==null||!request.getParameter("edited").equals("done"))
            {
                String postId=request.getParameter("postId");
                post p=forumData.getPost(postId);
                session.setAttribute("post", p);
                RequestDispatcher rd=request.getRequestDispatcher("/forum/editPost.jsp");
                rd.forward(request,response);
            }
            else
            {
                post editPost=new post();
                editPost.setPostId(Integer.parseInt(request.getParameter("postId")));
                editPost.setUserid((Integer) session.getAttribute("userID"));
                editPost.setCategory(request.getParameter("category"));
                editPost.setSubject(request.getParameter("subject"));
                editPost.setDescription(request.getParameter("description"));
                editPost.setPhoto(request.getParameter("photo"));
                editPost.setUrl(request.getParameter("url"));
                forumData.editPost(editPost);
                
                response.sendRedirect("Forum");
            }
        }
        else if(action.equals("DELETE"))
        {
                if(request.getParameter("deleted")==null||!request.getParameter("deleted").equals("confirm"))
                {
                    String postId=request.getParameter("postId");
                    post p=forumData.getPost(postId);
                    session.setAttribute("post", p);
                    RequestDispatcher rd=request.getRequestDispatcher("/forum/deletePost.jsp");
                    rd.forward(request,response);
                }
                else
                {
                    forumData.deletePost(Integer.parseInt(request.getParameter("postId")));

                    response.sendRedirect("Forum");
                }

        }
        else if(action.equals("COMMENT"))
        {
            post_comment newComment=new post_comment();
            newComment.setUserid((Integer) session.getAttribute("userID"));
            newComment.setPostId(Integer.parseInt(request.getParameter("postId")));
            newComment.setComment(request.getParameter("comment"));
            
            forumData.comment(newComment);
            
            response.sendRedirect("Forum?action=VIEW&postId="+newComment.getPostId());
            
        }
        
        
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet forumController</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet forumController at " + request.getContextPath() + "</h1>");
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
            Logger.getLogger(forumController.class.getName()).log(Level.SEVERE, null, ex);
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(forumController.class.getName()).log(Level.SEVERE, null, ex);
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
            Logger.getLogger(forumController.class.getName()).log(Level.SEVERE, null, ex);
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(forumController.class.getName()).log(Level.SEVERE, null, ex);
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
