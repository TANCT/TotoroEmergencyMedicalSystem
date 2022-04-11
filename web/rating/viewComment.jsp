<%-- 
    Document   : viewComment
    Created on : Dec 25, 2021, 10:08:09 PM
    Author     : Asus
--%>

<%@page import="com.model.Hospital"%>
<%@page import="com.model.rating"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Totoro Rating</title>
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
                <% 
                    List<rating> ratingList=(ArrayList<rating>) session.getAttribute("ratingList");
                    Hospital h=(Hospital) session.getAttribute("hospital");
                %>
                <div class="rating-hospital">
            <button class="rating-button"><a style="color: white;" href="Rating">Back</a></button>
                <% if(h.getPhoto()!=null){ %>
                    <img src="<%=h.getPhoto()%>" alt="photo" width="90%">
                <% }else{ %>
                    <img src="https://st4.depositphotos.com/14953852/22772/v/600/depositphotos_227725020-stock-illustration-image-available-icon-flat-vector.jpg" alt="photo" width="90%">
                    <%}%>
                <h1><u><%=h.getName() %></u></h1>
                <p><%=h.getPhone() %></p>
                <% if(h.getRatingNo()>0){ %>
                <p>Rating: <% 
                    for(int i=1; i<= h.getAvgRating();i++)
                    {   %>
                    <img src="images/rate.png" alt="star" width="20" height="20">
                 <%   }}
                %></p>
                
                </div>
               <%
                   for(rating r:ratingList)
                   {
               %>
                            <div class="rating-box">
                                
                                <div class="rating-photo">
                                    <h3><%=r.getUsername()%> | <%=r.getDate() %></h3>
                                    <% 
                                        for(int i=1; i<= r.getAvg();i++)
                                        {   %>
                                        <img src="images/rate.png" alt="star" width="20" height="20">
                                     <%   }
                                    %>
                                    <div class="rating-rate">
                                        <p>Comfort: <%=r.getComfort() %></p>
                                        <p>Cleaniness: <%=r.getCleaniness() %></p>
                                        <p>Service: <%=r.getService() %></p>
                                        <p>Safety: <%=r.getSafety() %></p>
                                        <a href="report/report.jsp?type=RATING&id=<%=r.getRatingId()%>">Report</a>
                                    </div>
                                    
                                </div>
                                    
                                <div class="rating-info">
                                    <p><%=r.getComment() %></p>
                                </div>
                                    
                                
                            </div>
                                <% } %>
                    
            </div>
        </div>
            <jsp:include page="../footer.jsp" />  
    </body>
</html>
