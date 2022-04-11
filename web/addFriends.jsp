<%-- 
    Document   : addFriends
    Created on : Jan 24, 2022, 9:38:43 PM
    Author     : User
--%>

<%@page import="com.model.user"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link type="stylesheet" href="css/style.css">
        <link type="stylesheet" href="css/page.css">
        <script src="http://code.jquery.com/jquery-latest.js"></script>
        <script>
            $(document).ready(function(){
                $("#refresh").load("header.jsp");
            setInterval(function(){
                  $("#refresh").load("header.jsp");
            }, 3000);
            });
        </script>
    </head>
    <body>
        <div id="refresh"></div>
        <div id="content" style="display:flex;flex-direction: column;align-content:center;align-items:center;justify-content: center;margin-top: 100px;background-color:#ace5ee;;margin-left:10%;margin-right:10%;min-height:400px;border-radius:8px;padding-top: 5px;padding-bottom:5px;">
            <br>
            <h1 style="color:white;">Find your friends</h1>
            <br>
            <form method="post" action="manageFriendController">
                <input type="hidden" name="action" value="search">
                <input type="text" name="name" style="padding:5px;" size="50" required>
                <br><br>
                <div style="display:flex;justify-content: center;"><input type="submit" value="Search" style="padding:10px;background-color: #29C5F6;color:white;border-radius:8px;border:white;"></div>
            </form>
            <br>
            
                <%if(request.getAttribute("frienz")!=null){
                ArrayList<user> frienz=(ArrayList<user>)request.getAttribute("frienz");
                if(frienz.size()>=1){
                for(user u: frienz){
                %>
                <div style="display:flex;flex-direction: column;align-items:center;background-color: white;padding:10px;border-radius:8px;min-width: 300px;">
                    <span><b><%=u.getName()%></b></span>
                    <span><%=u.getPhone()%></span><br>
                    <span><a href="/TotoroEmergencyMedical/manageFriendController?id=<%=String.valueOf(u.getUserid())%>&&action=add"><button style="padding:10px;background-color:#0492c2;color:white;border-radius:8px; border:white;">Add Friend</button></a></span>
                </div> 
                <br><br>
                <%}
              }else{%>
              <p>Not Found</p> 
                <%}
            }%>
            
            
            
            
        </div>
        
        <jsp:include page="footer.jsp" />  
    </body>
</html>
