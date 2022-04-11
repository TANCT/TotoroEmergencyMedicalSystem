/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import com.model.ArticleData;
import com.model.NewsData;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.Statement;
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
public class newsController extends HttpServlet {

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
            if(session.getAttribute("usertype")==null)
            {
                out.println("<script>alert('Please Login First');location.href='/TotoroEmergencyMedical/login.jsp'</script>");
                //response.sendRedirect("/TotoroEmergencyMedical/login.jsp");
            }else if(!session.getAttribute("usertype").equals("admin")){
                out.println("<script>alert('Only Admin can access');location.href='/TotoroEmergencyMedical/login.jsp'</script>");
            }else if(request.getParameter("action")==null){
                response.sendRedirect("/TotoroEmergencyMedical/admin/news/viewNews.jsp");
            }else{
                String action= request.getParameter("action");
                if(action.equals("create")){
                    if(request.getParameter("title")==null){
                        response.sendRedirect("/TotoroEmergencyMedical/admin/news/viewNews.jsp");
                    }else{
                        String title=request.getParameter("title");
                        String img=request.getParameter("photo");
                        String para1="",para2="",para3="",para4="",para5="";
                        String subtitle="", body="",li1="",li2="",li3="",li4="",li5="",li6="",li7="",li8="";
                        boolean list=false;
                        //Paragraph 1
                        if(request.getParameter("subtitle1")!=null&&!request.getParameter("subtitle1").isEmpty()){
                            subtitle=request.getParameter("subtitle1");


                        }
                        if(request.getParameter("body1")!=null&&!request.getParameter("body1").isEmpty()){
                            body=request.getParameter("body1");
                         

                        }
                        if(request.getParameter("ul1-1")!=null&&!request.getParameter("ul1-1").isEmpty()){
                            li1=request.getParameter("ul1-1");
                            list=true;
                        }
                        if(request.getParameter("ul1-2")!=null&&!request.getParameter("ul1-2").isEmpty()){
                            li2=request.getParameter("ul1-2");
                            list=true;

                        }
                        if(request.getParameter("ul1-3")!=null&&!request.getParameter("ul1-3").isEmpty()){
                            li3=request.getParameter("ul1-3");
                            list=true;
                        }
                        if(request.getParameter("ul1-4")!=null&&!request.getParameter("ul1-4").isEmpty()){
                            li4=request.getParameter("ul1-4");
                            list=true;
                        }
                        if(request.getParameter("ul1-5")!=null&&!request.getParameter("ul1-5").isEmpty()){
                            li5=request.getParameter("ul1-5");
                            list=true;
                        }
                        if(request.getParameter("ul1-6")!=null&&!request.getParameter("ul1-6").isEmpty()){
                            li6=request.getParameter("ul1-6");
                            list=true;
                        }
                        if(request.getParameter("ul1-7")!=null&&!request.getParameter("ul1-7").isEmpty()){
                            li7=request.getParameter("ul1-7");
                            list=true;
                        }
                        if(request.getParameter("ul1-8")!=null&&!request.getParameter("ul1-8").isEmpty()){
                            li8=request.getParameter("ul1-8");
                            list=true;

                        }

                        if(!subtitle.isEmpty()){
                            para1+="<b>"+subtitle+"</b><br><br>";
                        }
                        if(!body.isEmpty()){
                            para1+="<p>"+body+"</p><br><br>";
                        }

                        if(list==true){
                            para1+="<ul>";
                            if(!li1.isEmpty())
                            {
                                para1+="<li>"+li1+"</li>";
                            }
                            if(!li2.isEmpty()){
                                para1+="<li>"+li2+"</li>";
                            }
                            if(!li3.isEmpty()){
                                para1+="<li>"+li3+"</li>";
                            }
                            if(!li4.isEmpty()){
                                para1+="<li>"+li4+"</li>";
                            }
                            if(!li5.isEmpty()){
                                para1+="<li>"+li5+"</li>";
                            }
                            if(!li6.isEmpty()){
                                para1+="<li>"+li6+"</li>";
                            }
                            if(!li7.isEmpty()){
                                para1+="<li>"+li7+"</li>";
                            }
                            if(!li8.isEmpty()){
                                para1+="<li>"+li8+"</li>";
                            }
                            para1+="</ul><br><br>"; 
                            list=false;
                        }
                    subtitle=""; 
                    body="";
                    li1="";
                    li2="";
                    li3="";
                    li4="";
                    li5="";
                    li6="";
                    li7="";
                    li8="";
                    //Paragraph 2
                    if(request.getParameter("subtitle2")!=null&&!request.getParameter("subtitle2").isEmpty()){
                            subtitle=request.getParameter("subtitle2");


                        }
                        if(request.getParameter("body2")!=null&&!request.getParameter("body2").isEmpty()){
                            body=request.getParameter("body2");
                            

                        }
                        if(request.getParameter("ul2-1")!=null&&!request.getParameter("ul2-1").isEmpty()){
                            li1=request.getParameter("ul2-1");
                            list=true;
                        }
                        if(request.getParameter("ul2-2")!=null&&!request.getParameter("ul2-2").isEmpty()){
                            li2=request.getParameter("ul2-2");
                            list=true;

                        }
                        if(request.getParameter("ul2-3")!=null&&!request.getParameter("ul2-3").isEmpty()){
                            li3=request.getParameter("ul2-3");
                            list=true;
                        }
                        if(request.getParameter("ul2-4")!=null&&!request.getParameter("ul2-4").isEmpty()){
                            li4=request.getParameter("ul2-4");
                            list=true;
                        }
                        if(request.getParameter("ul2-5")!=null&&!request.getParameter("ul2-5").isEmpty()){
                            li5=request.getParameter("ul2-5");
                            list=true;
                        }
                        if(request.getParameter("ul2-6")!=null&&!request.getParameter("ul2-6").isEmpty()){
                            li6=request.getParameter("ul2-6");
                            list=true;
                        }
                        if(request.getParameter("ul2-7")!=null&&!request.getParameter("ul2-7").isEmpty()){
                            li7=request.getParameter("ul2-7");
                            list=true;
                        }
                        if(request.getParameter("ul2-8")!=null&&!request.getParameter("ul2-8").isEmpty()){
                            li8=request.getParameter("ul2-8");
                            list=true;

                        }

                        if(!subtitle.isEmpty()){
                            para2+="<b>"+subtitle+"</b><br><br>";
                        }
                        if(!body.isEmpty()){
                            para2+="<p>"+body+"</p><br><br>";
                        }

                        if(list==true){
                            para2+="<ul>";
                            if(!li1.isEmpty())
                            {
                                para2+="<li>"+li1+"</li>";
                            }
                            if(!li2.isEmpty()){
                                para2+="<li>"+li2+"</li>";
                            }
                            if(!li3.isEmpty()){
                                para2+="<li>"+li3+"</li>";
                            }
                            if(!li4.isEmpty()){
                                para2+="<li>"+li4+"</li>";
                            }
                            if(!li5.isEmpty()){
                                para2+="<li>"+li5+"</li>";
                            }
                            if(!li6.isEmpty()){
                                para2+="<li>"+li6+"</li>";
                            }
                            if(!li7.isEmpty()){
                                para2+="<li>"+li7+"</li>";
                            }
                            if(!li8.isEmpty()){
                                para2+="<li>"+li8+"</li>";
                            }
                            para2+="</ul><br><br>"; 
                            list=false;
                        }
                    subtitle=""; 
                    body="";
                    li1="";
                    li2="";
                    li3="";
                    li4="";
                    li5="";
                    li6="";
                    li7="";
                    li8="";
                    //Paragraph 3
                    if(request.getParameter("subtitle3")!=null&&!request.getParameter("subtitle3").isEmpty()){
                            subtitle=request.getParameter("subtitle3");


                        }
                        if(request.getParameter("body3")!=null&&!request.getParameter("body3").isEmpty()){
                            body=request.getParameter("body3");
                            

                        }
                        if(request.getParameter("ul3-1")!=null&&!request.getParameter("ul3-1").isEmpty()){
                            li1=request.getParameter("ul3-1");
                            list=true;
                        }
                        if(request.getParameter("ul3-2")!=null&&!request.getParameter("ul3-2").isEmpty()){
                            li2=request.getParameter("ul3-2");
                            list=true;

                        }
                        if(request.getParameter("ul3-3")!=null&&!request.getParameter("ul3-3").isEmpty()){
                            li3=request.getParameter("ul3-3");
                            list=true;
                        }
                        if(request.getParameter("ul3-4")!=null&&!request.getParameter("ul3-4").isEmpty()){
                            li4=request.getParameter("ul3-4");
                            list=true;
                        }
                        if(request.getParameter("ul3-5")!=null&&!request.getParameter("ul3-5").isEmpty()){
                            li5=request.getParameter("ul3-5");
                            list=true;
                        }
                        if(request.getParameter("ul3-6")!=null&&!request.getParameter("ul3-6").isEmpty()){
                            li6=request.getParameter("ul3-6");
                            list=true;
                        }
                        if(request.getParameter("ul3-7")!=null&&!request.getParameter("ul3-7").isEmpty()){
                            li7=request.getParameter("ul3-7");
                            list=true;
                        }
                        if(request.getParameter("ul3-8")!=null&&!request.getParameter("ul3-8").isEmpty()){
                            li8=request.getParameter("ul3-8");
                            list=true;

                        }

                        if(!subtitle.isEmpty()){
                            para3+="<b>"+subtitle+"</b><br><br>";
                        }
                        if(!body.isEmpty()){
                            para3+="<p>"+body+"</p><br><br>";
                            
                        }

                        if(list==true){
                            para3+="<ul>";
                            if(!li1.isEmpty())
                            {
                                para3+="<li>"+li1+"</li>";
                            }
                            if(!li2.isEmpty()){
                                para3+="<li>"+li2+"</li>";
                            }
                            if(!li3.isEmpty()){
                                para3+="<li>"+li3+"</li>";
                            }
                            if(!li4.isEmpty()){
                                para3+="<li>"+li4+"</li>";
                            }
                            if(!li5.isEmpty()){
                                para3+="<li>"+li5+"</li>";
                            }
                            if(!li6.isEmpty()){
                                para3+="<li>"+li6+"</li>";
                            }
                            if(!li7.isEmpty()){
                                para3+="<li>"+li7+"</li>";
                            }
                            if(!li8.isEmpty()){
                                para3+="<li>"+li8+"</li>";
                            }
                            para3+="</ul><br><br>"; 
                            list=false;
                        }
                    subtitle=""; 
                    body="";
                    li1="";
                    li2="";
                    li3="";
                    li4="";
                    li5="";
                    li6="";
                    li7="";
                    li8="";
                    //Paragraph 4
                    if(request.getParameter("subtitle4")!=null&&!request.getParameter("subtitle4").isEmpty()){
                            subtitle=request.getParameter("subtitle4");


                        }
                        if(request.getParameter("body4")!=null&&!request.getParameter("body4").isEmpty()){
                            body=request.getParameter("body4");
                            

                        }
                        if(request.getParameter("ul4-1")!=null&&!request.getParameter("ul4-1").isEmpty()){
                            li1=request.getParameter("ul4-1");
                            list=true;
                        }
                        if(request.getParameter("ul4-2")!=null&&!request.getParameter("ul4-2").isEmpty()){
                            li2=request.getParameter("ul4-2");
                            list=true;

                        }
                        if(request.getParameter("ul4-3")!=null&&!request.getParameter("ul4-3").isEmpty()){
                            li3=request.getParameter("ul4-3");
                            list=true;
                        }
                        if(request.getParameter("ul4-4")!=null&&!request.getParameter("ul4-4").isEmpty()){
                            li4=request.getParameter("ul4-4");
                            list=true;
                        }
                        if(request.getParameter("ul4-5")!=null&&!request.getParameter("ul4-5").isEmpty()){
                            li5=request.getParameter("ul4-5");
                            list=true;
                        }
                        if(request.getParameter("ul4-6")!=null&&!request.getParameter("ul4-6").isEmpty()){
                            li6=request.getParameter("ul4-6");
                            list=true;
                        }
                        if(request.getParameter("ul4-7")!=null&&!request.getParameter("ul4-7").isEmpty()){
                            li7=request.getParameter("ul4-7");
                            list=true;
                        }
                        if(request.getParameter("ul4-8")!=null&&!request.getParameter("ul4-8").isEmpty()){
                            li8=request.getParameter("ul4-8");
                            list=true;

                        }

                        if(!subtitle.isEmpty()){
                            para4+="<b>"+subtitle+"</b><br><br>";
                        }
                        if(!body.isEmpty()){
                            para4+="<p>"+body+"</p><br><br>";
                        }

                        if(list==true){
                            para4+="<ul>";
                            if(!li1.isEmpty())
                            {
                                para4+="<li>"+li1+"</li>";
                            }
                            if(!li2.isEmpty()){
                                para4+="<li>"+li2+"</li>";
                            }
                            if(!li3.isEmpty()){
                                para4+="<li>"+li3+"</li>";
                            }
                            if(!li4.isEmpty()){
                                para4+="<li>"+li4+"</li>";
                            }
                            if(!li5.isEmpty()){
                                para4+="<li>"+li5+"</li>";
                            }
                            if(!li6.isEmpty()){
                                para4+="<li>"+li6+"</li>";
                            }
                            if(!li7.isEmpty()){
                                para4+="<li>"+li7+"</li>";
                            }
                            if(!li8.isEmpty()){
                                para4+="<li>"+li8+"</li>";
                            }
                            para4+="</ul><br><br>"; 
                            list=false;
                        }
                    subtitle=""; 
                    body="";
                    li1="";
                    li2="";
                    li3="";
                    li4="";
                    li5="";
                    li6="";
                    li7="";
                    li8="";
                    //Paragraph 5
                    if(request.getParameter("subtitle5")!=null&&!request.getParameter("subtitle5").isEmpty()){
                            subtitle=request.getParameter("subtitle5");


                        }
                        if(request.getParameter("body5")!=null&&!request.getParameter("body5").isEmpty()){
                            body=request.getParameter("body5");
                            

                        }
                        if(request.getParameter("ul5-1")!=null&&!request.getParameter("ul5-1").isEmpty()){
                            li1=request.getParameter("ul5-1");
                            list=true;
                        }
                        if(request.getParameter("ul5-2")!=null&&!request.getParameter("ul5-2").isEmpty()){
                            li2=request.getParameter("ul5-2");
                            list=true;

                        }
                        if(request.getParameter("ul5-3")!=null&&!request.getParameter("ul5-3").isEmpty()){
                            li3=request.getParameter("ul5-3");
                            list=true;
                        }
                        if(request.getParameter("ul5-4")!=null&&!request.getParameter("ul5-4").isEmpty()){
                            li4=request.getParameter("ul5-4");
                            list=true;
                        }
                        if(request.getParameter("ul5-5")!=null&&!request.getParameter("ul5-5").isEmpty()){
                            li5=request.getParameter("ul5-5");
                            list=true;
                        }
                        if(request.getParameter("ul5-6")!=null&&!request.getParameter("ul5-6").isEmpty()){
                            li6=request.getParameter("ul5-6");
                            list=true;
                        }
                        if(request.getParameter("ul5-7")!=null&&!request.getParameter("ul5-7").isEmpty()){
                            li7=request.getParameter("ul5-7");
                            list=true;
                        }
                        if(request.getParameter("ul5-8")!=null&&!request.getParameter("ul5-8").isEmpty()){
                            li8=request.getParameter("ul5-8");
                            list=true;

                        }

                        if(!subtitle.isEmpty()){
                            para5+="<b>"+subtitle+"</b><br><br>";
                        }
                        if(!body.isEmpty()){
                            para5+="<p>"+body+"</p><br><br>";
                        }

                        if(list==true){
                            para5+="<ul>";
                            if(!li1.isEmpty())
                            {
                                para5+="<li>"+li1+"</li>";
                            }
                            if(!li2.isEmpty()){
                                para5+="<li>"+li2+"</li>";
                            }
                            if(!li3.isEmpty()){
                                para5+="<li>"+li3+"</li>";
                            }
                            if(!li4.isEmpty()){
                                para5+="<li>"+li4+"</li>";
                            }
                            if(!li5.isEmpty()){
                                para5+="<li>"+li5+"</li>";
                            }
                            if(!li6.isEmpty()){
                                para5+="<li>"+li6+"</li>";
                            }
                            if(!li7.isEmpty()){
                                para5+="<li>"+li7+"</li>";
                            }
                            if(!li8.isEmpty()){
                                para5+="<li>"+li8+"</li>";
                            }
                            para5+="</ul><br><br>"; 
                            list=false;
                        }
                    
                    String query="INSERT INTO news(`title`,`photo`,`para1`,`para2`,`para3`,`para4`,`para5`)VALUES(?,?,?,?,?,?,?)";                    

                    Connection con=NewsData.getConnection();
                    PreparedStatement st=con.prepareStatement(query);
                    st.setString(1,title);
                    st.setString(2,img);
                    st.setString(3,para1);
                    st.setString(4,para2);
                    st.setString(5,para3);
                    st.setString(6,para4);
                    st.setString(7,para5);
                    st.executeUpdate();
                    st.close();
                    con.close();

                    response.sendRedirect("/TotoroEmergencyMedical/admin/news/viewNews.jsp");
                
                }
                        
                    
                }else if(action.equals("edit")){
                    if(request.getParameter("id")==null){
                        response.sendRedirect("/TotoroEmergencyMedical/admin/news/viewNews.jsp");
                    }else{
                        String id=request.getParameter("id");
                        String title=request.getParameter("title");
                        String img=request.getParameter("photo");
                        String para1="",para2="",para3="",para4="",para5="";
                        String subtitle="", body="",li1="",li2="",li3="",li4="",li5="",li6="",li7="",li8="";
                        boolean list=false;
                        //Paragraph 1
                        if(request.getParameter("subtitle1")!=null&&!request.getParameter("subtitle1").isEmpty()){
                            subtitle=request.getParameter("subtitle1");


                        }
                        if(request.getParameter("body1")!=null&&!request.getParameter("body1").isEmpty()){
                            body=request.getParameter("body1");
                            body=body.replaceAll("apos", "&#39;");

                        }
                        if(request.getParameter("ul1-1")!=null&&!request.getParameter("ul1-1").isEmpty()){
                            li1=request.getParameter("ul1-1");
                            list=true;
                        }
                        if(request.getParameter("ul1-2")!=null&&!request.getParameter("ul1-2").isEmpty()){
                            li2=request.getParameter("ul1-2");
                            list=true;

                        }
                        if(request.getParameter("ul1-3")!=null&&!request.getParameter("ul1-3").isEmpty()){
                            li3=request.getParameter("ul1-3");
                            list=true;
                        }
                        if(request.getParameter("ul1-4")!=null&&!request.getParameter("ul1-4").isEmpty()){
                            li4=request.getParameter("ul1-4");
                            list=true;
                        }
                        if(request.getParameter("ul1-5")!=null&&!request.getParameter("ul1-5").isEmpty()){
                            li5=request.getParameter("ul1-5");
                            list=true;
                        }
                        if(request.getParameter("ul1-6")!=null&&!request.getParameter("ul1-6").isEmpty()){
                            li6=request.getParameter("ul1-6");
                            list=true;
                        }
                        if(request.getParameter("ul1-7")!=null&&!request.getParameter("ul1-7").isEmpty()){
                            li7=request.getParameter("ul1-7");
                            list=true;
                        }
                        if(request.getParameter("ul1-8")!=null&&!request.getParameter("ul1-8").isEmpty()){
                            li8=request.getParameter("ul1-8");
                            list=true;

                        }

                        if(!subtitle.isEmpty()){
                            para1+="<b>"+subtitle+"</b><br><br>";
                        }
                        if(!body.isEmpty()){
                            para1+="<p>"+body+"</p><br><br>";
                        }

                        if(list==true){
                            para1+="<ul>";
                            if(!li1.isEmpty())
                            {
                                para1+="<li>"+li1+"</li>";
                            }
                            if(!li2.isEmpty()){
                                para1+="<li>"+li2+"</li>";
                            }
                            if(!li3.isEmpty()){
                                para1+="<li>"+li3+"</li>";
                            }
                            if(!li4.isEmpty()){
                                para1+="<li>"+li4+"</li>";
                            }
                            if(!li5.isEmpty()){
                                para1+="<li>"+li5+"</li>";
                            }
                            if(!li6.isEmpty()){
                                para1+="<li>"+li6+"</li>";
                            }
                            if(!li7.isEmpty()){
                                para1+="<li>"+li7+"</li>";
                            }
                            if(!li8.isEmpty()){
                                para1+="<li>"+li8+"</li>";
                            }
                            para1+="</ul><br><br>"; 
                            list=false;
                        }
                    subtitle=""; 
                    body="";
                    li1="";
                    li2="";
                    li3="";
                    li4="";
                    li5="";
                    li6="";
                    li7="";
                    li8="";
                    //Paragraph 2
                    if(request.getParameter("subtitle2")!=null&&!request.getParameter("subtitle2").isEmpty()){
                            subtitle=request.getParameter("subtitle2");


                        }
                        if(request.getParameter("body2")!=null&&!request.getParameter("body2").isEmpty()){
                            body=request.getParameter("body2");
                            body=body.replaceAll("apos", "&#39;");

                        }
                        if(request.getParameter("ul2-1")!=null&&!request.getParameter("ul2-1").isEmpty()){
                            li1=request.getParameter("ul2-1");
                            list=true;
                        }
                        if(request.getParameter("ul2-2")!=null&&!request.getParameter("ul2-2").isEmpty()){
                            li2=request.getParameter("ul2-2");
                            list=true;

                        }
                        if(request.getParameter("ul2-3")!=null&&!request.getParameter("ul2-3").isEmpty()){
                            li3=request.getParameter("ul2-3");
                            list=true;
                        }
                        if(request.getParameter("ul2-4")!=null&&!request.getParameter("ul2-4").isEmpty()){
                            li4=request.getParameter("ul2-4");
                            list=true;
                        }
                        if(request.getParameter("ul2-5")!=null&&!request.getParameter("ul2-5").isEmpty()){
                            li5=request.getParameter("ul2-5");
                            list=true;
                        }
                        if(request.getParameter("ul2-6")!=null&&!request.getParameter("ul2-6").isEmpty()){
                            li6=request.getParameter("ul2-6");
                            list=true;
                        }
                        if(request.getParameter("ul2-7")!=null&&!request.getParameter("ul2-7").isEmpty()){
                            li7=request.getParameter("ul2-7");
                            list=true;
                        }
                        if(request.getParameter("ul2-8")!=null&&!request.getParameter("ul2-8").isEmpty()){
                            li8=request.getParameter("ul2-8");
                            list=true;

                        }

                        if(!subtitle.isEmpty()){
                            para2+="<b>"+subtitle+"</b><br><br>";
                        }
                        if(!body.isEmpty()){
                            para2+="<p>"+body+"</p><br><br>";
                        }

                        if(list==true){
                            para2+="<ul>";
                            if(!li1.isEmpty())
                            {
                                para2+="<li>"+li1+"</li>";
                            }
                            if(!li2.isEmpty()){
                                para2+="<li>"+li2+"</li>";
                            }
                            if(!li3.isEmpty()){
                                para2+="<li>"+li3+"</li>";
                            }
                            if(!li4.isEmpty()){
                                para2+="<li>"+li4+"</li>";
                            }
                            if(!li5.isEmpty()){
                                para2+="<li>"+li5+"</li>";
                            }
                            if(!li6.isEmpty()){
                                para2+="<li>"+li6+"</li>";
                            }
                            if(!li7.isEmpty()){
                                para2+="<li>"+li7+"</li>";
                            }
                            if(!li8.isEmpty()){
                                para2+="<li>"+li8+"</li>";
                            }
                            para2+="</ul><br><br>"; 
                            list=false;
                        }
                    subtitle=""; 
                    body="";
                    li1="";
                    li2="";
                    li3="";
                    li4="";
                    li5="";
                    li6="";
                    li7="";
                    li8="";
                    //Paragraph 3
                    if(request.getParameter("subtitle3")!=null&&!request.getParameter("subtitle3").isEmpty()){
                            subtitle=request.getParameter("subtitle3");


                        }
                        if(request.getParameter("body3")!=null&&!request.getParameter("body3").isEmpty()){
                            body=request.getParameter("body3");
                            body=body.replaceAll("apos", "&#39;");

                        }
                        if(request.getParameter("ul3-1")!=null&&!request.getParameter("ul3-1").isEmpty()){
                            li1=request.getParameter("ul3-1");
                            list=true;
                        }
                        if(request.getParameter("ul3-2")!=null&&!request.getParameter("ul3-2").isEmpty()){
                            li2=request.getParameter("ul3-2");
                            list=true;

                        }
                        if(request.getParameter("ul3-3")!=null&&!request.getParameter("ul3-3").isEmpty()){
                            li3=request.getParameter("ul3-3");
                            list=true;
                        }
                        if(request.getParameter("ul3-4")!=null&&!request.getParameter("ul3-4").isEmpty()){
                            li4=request.getParameter("ul3-4");
                            list=true;
                        }
                        if(request.getParameter("ul3-5")!=null&&!request.getParameter("ul3-5").isEmpty()){
                            li5=request.getParameter("ul3-5");
                            list=true;
                        }
                        if(request.getParameter("ul3-6")!=null&&!request.getParameter("ul3-6").isEmpty()){
                            li6=request.getParameter("ul3-6");
                            list=true;
                        }
                        if(request.getParameter("ul3-7")!=null&&!request.getParameter("ul3-7").isEmpty()){
                            li7=request.getParameter("ul3-7");
                            list=true;
                        }
                        if(request.getParameter("ul3-8")!=null&&!request.getParameter("ul3-8").isEmpty()){
                            li8=request.getParameter("ul3-8");
                            list=true;

                        }

                        if(!subtitle.isEmpty()){
                            para3+="<b>"+subtitle+"</b><br><br>";
                        }
                        if(!body.isEmpty()){
                            para3+="<p>"+body+"</p><br><br>";
                        }

                        if(list==true){
                            para3+="<ul>";
                            if(!li1.isEmpty())
                            {
                                para3+="<li>"+li1+"</li>";
                            }
                            if(!li2.isEmpty()){
                                para3+="<li>"+li2+"</li>";
                            }
                            if(!li3.isEmpty()){
                                para3+="<li>"+li3+"</li>";
                            }
                            if(!li4.isEmpty()){
                                para3+="<li>"+li4+"</li>";
                            }
                            if(!li5.isEmpty()){
                                para3+="<li>"+li5+"</li>";
                            }
                            if(!li6.isEmpty()){
                                para3+="<li>"+li6+"</li>";
                            }
                            if(!li7.isEmpty()){
                                para3+="<li>"+li7+"</li>";
                            }
                            if(!li8.isEmpty()){
                                para3+="<li>"+li8+"</li>";
                            }
                            para3+="</ul><br><br>"; 
                            list=false;
                        }
                    subtitle=""; 
                    body="";
                    li1="";
                    li2="";
                    li3="";
                    li4="";
                    li5="";
                    li6="";
                    li7="";
                    li8="";
                    //Paragraph 4
                    if(request.getParameter("subtitle4")!=null&&!request.getParameter("subtitle4").isEmpty()){
                            subtitle=request.getParameter("subtitle4");


                        }
                        if(request.getParameter("body4")!=null&&!request.getParameter("body4").isEmpty()){
                            body=request.getParameter("body4");
                            body=body.replaceAll("apos", "&#39;");

                        }
                        if(request.getParameter("ul4-1")!=null&&!request.getParameter("ul4-1").isEmpty()){
                            li1=request.getParameter("ul4-1");
                            list=true;
                        }
                        if(request.getParameter("ul4-2")!=null&&!request.getParameter("ul4-2").isEmpty()){
                            li2=request.getParameter("ul4-2");
                            list=true;

                        }
                        if(request.getParameter("ul4-3")!=null&&!request.getParameter("ul4-3").isEmpty()){
                            li3=request.getParameter("ul4-3");
                            list=true;
                        }
                        if(request.getParameter("ul4-4")!=null&&!request.getParameter("ul4-4").isEmpty()){
                            li4=request.getParameter("ul4-4");
                            list=true;
                        }
                        if(request.getParameter("ul4-5")!=null&&!request.getParameter("ul4-5").isEmpty()){
                            li5=request.getParameter("ul4-5");
                            list=true;
                        }
                        if(request.getParameter("ul4-6")!=null&&!request.getParameter("ul4-6").isEmpty()){
                            li6=request.getParameter("ul4-6");
                            list=true;
                        }
                        if(request.getParameter("ul4-7")!=null&&!request.getParameter("ul4-7").isEmpty()){
                            li7=request.getParameter("ul4-7");
                            list=true;
                        }
                        if(request.getParameter("ul4-8")!=null&&!request.getParameter("ul4-8").isEmpty()){
                            li8=request.getParameter("ul4-8");
                            list=true;

                        }

                        if(!subtitle.isEmpty()){
                            para4+="<b>"+subtitle+"</b><br><br>";
                        }
                        if(!body.isEmpty()){
                            para4+="<p>"+body+"</p><br><br>";
                        }

                        if(list==true){
                            para4+="<ul>";
                            if(!li1.isEmpty())
                            {
                                para4+="<li>"+li1+"</li>";
                            }
                            if(!li2.isEmpty()){
                                para4+="<li>"+li2+"</li>";
                            }
                            if(!li3.isEmpty()){
                                para4+="<li>"+li3+"</li>";
                            }
                            if(!li4.isEmpty()){
                                para4+="<li>"+li4+"</li>";
                            }
                            if(!li5.isEmpty()){
                                para4+="<li>"+li5+"</li>";
                            }
                            if(!li6.isEmpty()){
                                para4+="<li>"+li6+"</li>";
                            }
                            if(!li7.isEmpty()){
                                para4+="<li>"+li7+"</li>";
                            }
                            if(!li8.isEmpty()){
                                para4+="<li>"+li8+"</li>";
                            }
                            para4+="</ul><br><br>"; 
                            list=false;
                        }
                    subtitle=""; 
                    body="";
                    li1="";
                    li2="";
                    li3="";
                    li4="";
                    li5="";
                    li6="";
                    li7="";
                    li8="";
                    //Paragraph 5
                    if(request.getParameter("subtitle5")!=null&&!request.getParameter("subtitle5").isEmpty()){
                            subtitle=request.getParameter("subtitle5");


                        }
                        if(request.getParameter("body5")!=null&&!request.getParameter("body5").isEmpty()){
                            body=request.getParameter("body5");
                            body=body.replaceAll("apos", "&#39;");

                        }
                        if(request.getParameter("ul5-1")!=null&&!request.getParameter("ul5-1").isEmpty()){
                            li1=request.getParameter("ul5-1");
                            list=true;
                        }
                        if(request.getParameter("ul5-2")!=null&&!request.getParameter("ul5-2").isEmpty()){
                            li2=request.getParameter("ul5-2");
                            list=true;

                        }
                        if(request.getParameter("ul5-3")!=null&&!request.getParameter("ul5-3").isEmpty()){
                            li3=request.getParameter("ul5-3");
                            list=true;
                        }
                        if(request.getParameter("ul5-4")!=null&&!request.getParameter("ul5-4").isEmpty()){
                            li4=request.getParameter("ul5-4");
                            list=true;
                        }
                        if(request.getParameter("ul5-5")!=null&&!request.getParameter("ul5-5").isEmpty()){
                            li5=request.getParameter("ul5-5");
                            list=true;
                        }
                        if(request.getParameter("ul5-6")!=null&&!request.getParameter("ul5-6").isEmpty()){
                            li6=request.getParameter("ul5-6");
                            list=true;
                        }
                        if(request.getParameter("ul5-7")!=null&&!request.getParameter("ul5-7").isEmpty()){
                            li7=request.getParameter("ul5-7");
                            list=true;
                        }
                        if(request.getParameter("ul5-8")!=null&&!request.getParameter("ul5-8").isEmpty()){
                            li8=request.getParameter("ul5-8");
                            list=true;

                        }

                        if(!subtitle.isEmpty()){
                            para5+="<b>"+subtitle+"</b><br><br>";
                        }
                        if(!body.isEmpty()){
                            para5+="<p>"+body+"</p><br><br>";
                        }

                        if(list==true){
                            para5+="<ul>";
                            if(!li1.isEmpty())
                            {
                                para5+="<li>"+li1+"</li>";
                            }
                            if(!li2.isEmpty()){
                                para5+="<li>"+li2+"</li>";
                            }
                            if(!li3.isEmpty()){
                                para5+="<li>"+li3+"</li>";
                            }
                            if(!li4.isEmpty()){
                                para5+="<li>"+li4+"</li>";
                            }
                            if(!li5.isEmpty()){
                                para5+="<li>"+li5+"</li>";
                            }
                            if(!li6.isEmpty()){
                                para5+="<li>"+li6+"</li>";
                            }
                            if(!li7.isEmpty()){
                                para5+="<li>"+li7+"</li>";
                            }
                            if(!li8.isEmpty()){
                                para5+="<li>"+li8+"</li>";
                            }
                            para5+="</ul><br><br>"; 
                            list=false;
                        }                   
                    String query="UPDATE `news` SET `title`='"+title+"',`photo`='"+img+"',`para1`='"+para1+"',`para2`='"+para2+"',`para3`='"+para3+"',`para4`='"+para4+"',`para5`='"+para5+"' WHERE `id`="+id;;

                    Connection con=NewsData.getConnection();
                    Statement st=con.createStatement();

                    st.executeUpdate(query);
                    st.close();
                    con.close();

                    response.sendRedirect("/TotoroEmergencyMedical/admin/news/viewNews.jsp");

                    }
                    
                }else if(action.equals("delete")){
                    if(request.getParameter("id")==null){
                        response.sendRedirect("/TotoroEmergencyMedical/admin/news/viewNews.jsp");
                    }else{
                        
                        String id=request.getParameter("id");
                        String query="DELETE FROM `news` WHERE `id`="+id;

                        

                        Connection con=NewsData.getConnection();
                        Statement st=con.createStatement();


                        st.executeUpdate(query);


                        st.close();
                        con.close();
                        response.sendRedirect("/TotoroEmergencyMedical/admin/news/viewNews.jsp");
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
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(newsController.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(newsController.class.getName()).log(Level.SEVERE, null, ex);
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
            Logger.getLogger(newsController.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(newsController.class.getName()).log(Level.SEVERE, null, ex);
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
