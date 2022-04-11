<%-- 
    Document   : NotificationHistory
    Created on : Jan 18, 2022, 4:36:54 PM
    Author     : User
--%>

<%@page import="com.model.Notification"%>
<%@page import="java.util.List"%>
<%@page import="java.util.List"%>
<%@page import="com.model.NotificationData"%>
<%@page import="java.time.format.DateTimeFormatter"%>
<%@page import="java.time.Duration"%>
<%@page import="java.time.LocalDateTime"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link type="stylesheet" href="/TotoroEmergencyMedical/css/style.css">
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
        <%if(session.getAttribute("userID")==null){
             response.sendRedirect("/TotoroEmergencyMedical/login.jsp");
         }else{
            int id=(Integer)session.getAttribute("userID");
            List<Notification> list=NotificationData.getNotificationHistory(id);
        %>
             <div id="refresh"></div>
             
             
             <div id="content" style="margin-left: 20%;margin-right:20%;background-color:#ace5ee;padding:5%;border-radius:8px;min-height:600px; height:auto;">
                 <h1 align="center" style="color:white;" >Notification</h1><br>
                 <ul>
                     <%for(Notification n:list){%>
                     <% DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
                        LocalDateTime dateTime = LocalDateTime.parse(n.getDate(),formatter);
                        LocalDateTime now= LocalDateTime.now();
                        Duration diff = Duration.between(dateTime,now);
                        String time="";
                        double sec=diff.getSeconds();
                        double min=0,hrs=0,days=0,week=0,month=0,year=0;
                        if(sec<60){
                            time=String.format("%.0f", sec)+" second(s) ago";
                        }
                        if(sec>=60&&sec<3600){
                            sec=sec/60;
                            time=String.format("%.0f", sec)+" minute(s) ago";
                        }
                        if(sec>=3600&&sec<86400){
                            sec=sec/3600;
                            time=String.format("%.0f", sec)+" hour(s) ago";
                        }
                        if(sec>=86400&&sec<604800){
                            sec=sec/86400;
                            time=String.format("%.0f", sec)+" day(s) ago";
                        }
                        if(sec>=604800&& sec<2592000){
                            sec=sec/604800;
                            time=String.format("%.0f", sec)+" week(s) ago";
                        }
                        if(sec>=2592000&&sec<31536000){
                            sec=sec/2592000;
                            time=String.format("%.0f", sec)+" month(s) ago";
                        }
                        if(sec>=31536000){
                            sec=sec/31536000;
                            time=String.format("%.0f", sec)+" year(s) ago";
                        }
                        
                     %>
                     <a href="trackFriend.jsp?id=<%= n.getId() %>"style="color:#0093af;">
                         <li style="width:100%;border:1px solid white;padding:10px;border-radius:8px;background-color:white;"><%=n.getFriendName()%> &nbsp;<span><%=n.getTitle()%></span>&nbsp;at &nbsp;<span><%=n.getDate()%></span>&nbsp;&nbsp;&nbsp;<%if(n.getStatus().equals("unread")){%><span style="border-radius:8px; padding:2px; background-color: red;color:white;">Unread</span><%}%><br>
                             <%if(!n.getBody().isEmpty()){%>
                         <br><span style="color:#00b9fb;">Additional: <%=n.getBody()%></span><br>
                         <%}%>
                         <br><span style="color:grey;"><%=time%></span>
                     </li>  
                     
                     </a>
                     <br>
                     <%}%>
                     
                 </ul>
                 
                 
                 
             </div>
         
         
                    
         <%}%>
         <jsp:include page="footer.jsp" />  
    </body>
</html>
