<%-- 
    Document   : viewAdmin
    Created on : Jan 28, 2022, 5:24:03 PM
    Author     : Asus
--%>

<%@page import="com.model.rating"%>
<%@page import="com.model.post_comment"%>
<%@page import="com.model.post"%>
<%@page import="com.model.report"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Totoro Report</title>
        <style><%@include file="../css/style.css"%></style>
        <style><%@include file="../css/page.css"%></style>
        <style><%@include file="../css/rating.css"%></style>
        <style><%@include file="../css/forum.css"%></style>
        <script src="http://code.jquery.com/jquery-latest.js"></script>
        <script> $(document).ready(function(){
                
                $("#refresh").load("/TotoroEmergencyMedical/header.jsp");
            setInterval(function(){
                  $("#refresh").load("/TotoroEmergencyMedical/header.jsp");
            }, 3000);
            });</script>
        
    </head>
    <body>
        <div id="refresh"></div>
        <jsp:include page="../header.jsp" />
        
        <div class="container">
            <div class="rating-main">
                <button class="rating-button"><a style="color: white;" href="Report">Back</a></button>
                <div class="rating-hospital">
                <% 
                    List<report> list=(ArrayList<report>) session.getAttribute("report");
                    String type=list.get(0).getType();
                    int id=-1;
                    
                    if(list.get(0).getType().equals("POST"))
                    {
                        post p=(post)session.getAttribute("post"); 
                        id=p.getPostId(); %>
                        
                            <p>Post# <a href="Forum?action=VIEW&postId=<%=p.getPostId()%>"><%=p.getPostId()%></a></p>
                        <p><a href="Forum?id=<%=p.getUserid()%>"><%=p.getUsername()%></a> | <%=p.getCategory()%> | <%=p.getInitialdate() %></p>
                        <p><u><%=p.getSubject()%></u></p>
                        <p><%=p.getDescription()%></p>
                        <% if(p.getPhoto()!=null){ %>
                        <div class="photo">
                            <img src="<%=p.getPhoto()%>" alt="photo" height=200px>
                        </div>
                     <% } %>       
                     <% if(p.getUrl()!=null){ %>
                        <div class="url">
                            <b>Attach:</b> <a href="<%=p.getUrl()%>" ><%=p.getUrl()%></a>
                        </div>
                    <% } %>

                        
                    <%}
                    else if(list.get(0).getType().equals("COMMENT"))
                    {
                        post_comment c=(post_comment)session.getAttribute("comment");
                        id=c.getCommentId();
                    %>
                        
                            <p>Comment to Post# <a href="Forum?action=VIEW&postId=<%=c.getPostId()%>"><%=c.getPostId()%></a></p>
                         <p><a href="Forum?id=<%=c.getUserid() %>"><%=c.getUsername() %></a> | <%=c.getDate() %></p>
                         <p><%=c.getComment() %></p><br>
                        
                   <% }
                    else if(list.get(0).getType().equals("RATING"))
                    {
                        rating r=(rating)session.getAttribute("rating");
                        id=r.getRatingId();
                   %>
                        
                        
                            <p>Rating to Hospital#<a href="Rating?action=VIEW&id=<%=r.getHospitalId()%>"><%=r.getHospitalId() %></a></p>
                        <p><%=r.getUsername()%> | <%=r.getDate() %></p>
                        <% 
                            for(int i=1; i<= r.getAvg();i++)
                            {   %>
                            <img src="images/rate.png" alt="star" width="20" height="20">
                         <%   }
                        %>
                        <p>Comfort: <%=r.getComfort() %></p>
                        <p>Cleaniness: <%=r.getCleaniness() %></p>
                        <p>Service: <%=r.getService() %></p>
                        <p>Safety: <%=r.getSafety() %></p>
                        <p><%=r.getComment() %></p>
                        

                  <%  }
                    
                %>
                <br>
                <button class="rating-button" style="background: green;"><a style="color: white; " href="Report?action=APPROVE&type=<%=type%>&id=<%=id%>">Hide Content</a></button>
                <button class="rating-button" style="background: red;"><a style="color: white; " href="Report?action=REJECT&type=<%=type%>&id=<%=id%>">Reject Report</a></button>
                <br>
                </div>
               <%
                   for(report report:list)
                   {
               %>
                            <div class="rating-box">
                                
                                <div class="rating-photo">
                                    <h3><%=report.getUsername()%></h3>
                                    <p><%=report.getDate() %></p>
                                    <p><%=report.getStatus() %></p>
                                    
                                    
                                </div>
                                    
                                <div class="rating-info">
                                    <p><u><%=report.getProblem() %></u></p>
                                    <p><%=report.getDescription() %></p>
                                </div>
                                    
                                
                            </div>
                                <% } %>
                                

            </div>
        </div>
            <jsp:include page="../footer.jsp" />  
    </body>
</html>
