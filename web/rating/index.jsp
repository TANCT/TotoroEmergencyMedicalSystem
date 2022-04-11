<%-- 
    Document   : index
    Created on : Dec 25, 2021, 7:07:27 PM
    Author     : Asus
--%>

<%@page import="com.model.Hospital"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
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
            <div class="rating-search">
                <form action="Rating" method="POST">
                    
                        <input type="image" src="images/search.png" alt="Submit" width="20" height="20">
                        <input type="text" name="searchKey" placeholder="Search hospital..." style="height: 35px;font-size: large; width: 80%">
                </form>
            </div>
            <div class="rating-main">
                <% 
                    List<Hospital> hospitalList=(ArrayList<Hospital>) session.getAttribute("hospitalList");
                    
                %>
                
               <%
                   for(Hospital h:hospitalList)
                   {
               %>
                            <div class="rating-box">
                                <div class="rating-photo">
                                    <% if(h.getPhoto()!=null){ %>
                                        <img src="<%=h.getPhoto()%>" alt="photo" height=100px>
                                    <% }else{ %>
                                        <img src="https://st4.depositphotos.com/14953852/22772/v/600/depositphotos_227725020-stock-illustration-image-available-icon-flat-vector.jpg" alt="photo" height=100px>
                                        <%}%>
                                </div>
                                <div class="rating-info">
                                    <h3><%=h.getName() %></h3>
                                    <% if(h.getRatingNo()>0){ %>
                                    <p>Rating: <% 
                                        for(int i=1; i<= h.getAvgRating();i++)
                                        {   %>
                                        <img src="images/rate.png" alt="star" width="20" height="20">
                                     <%   }
                                    %></p>
                                    <p><%= h.getRatingNo() %> people rated this hospital</p>
                                    <%}else{%>
                                    <p>No rating</p>
                                    <p>Be the first to rate this hospital</p>
                                    <%}%>
                                </div>
                                <div class="create" style="text-align: center">
                                    <% if(h.getRatingNo()>0){ %>
                                    <button onclick="document.location='Rating?action=VIEW&id=<%=h.getId() %>'">View Comment</button> 
                                    <%}%>
                                    <br><br>
                                    <% if(session.getAttribute("username")!=null){ %>
                                    <button onclick="document.location='rating/addRating.jsp?id=<%=h.getId() %>&name=<%=h.getName() %>'">Rate</button>
                                    <%}%>
                                </div>
                            </div>
                                <% } %>
                    
            </div>
        </div>
            <jsp:include page="../footer.jsp" />  
    </body>
</html>
