<%-- 
    Document   : header
    Created on : Dec 19, 2021, 5:39:54 PM
    Author     : User
--%>

<%@page import="java.util.ArrayList"%>
<%@page import="java.io.File"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.util.Date"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <!--<meta http-equiv="refresh" content="30"/>-->
        <meta charset="UTF-8" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
       
        <link rel="stylesheet" href="/TotoroEmergencyMedical/css/style.css" />   
        
        
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        <link href="https://fonts.googleapis.com/css2?family=Roboto+Slab:wght@600&display=swap" rel="stylesheet">
        <title>Document</title>
        <script>
            function toggleServices(){
                var x = document.getElementById("dropdown");
                    if (x.style.display === "block") {
                      x.style.display = "none";
                    } else {
                      x.style.display = "block";
                    }
            }
            function toggleNotification(){
                var x = document.getElementById("notidropdown");
                    if (x.style.display === "block") {
                      x.style.display = "none";
                    } else {
                      x.style.display = "block";
                    }
            }
        </script>
    
    </head>
    
    <body>
        
       <%
       
        if(session.getAttribute("username")==null){
             response.sendRedirect("/TotoroEmergencyMedical/login.jsp");
         }else{
            
        
        String username=(String)session.getAttribute("username");
        int id=(Integer)session.getAttribute("userID");
        String usertype=(String)session.getAttribute("usertype");
        
        String query;
        String q=request.getParameter("name");
        String driver="com.mysql.jdbc.Driver";           
        String dbName="totoro";
        String url="jdbc:mysql://localhost/"+dbName+"?";
        String userName="root";
        String password="";

        query="SELECT COUNT(*) FROM `notification` where `to`="+String.valueOf(id)+" and `status`='unread'"; 

        Class.forName(driver);
        Connection con=DriverManager.getConnection(url,userName,password);
        Statement st=con.createStatement();
        ResultSet rs=st.executeQuery(query);
        rs.next();
    %>
        <nav class="navbar" style="z-index: 10;">
     <!-- LOGO -->
     <div class="logo" style="font-size:20px;padding-left:20px;font-family: 'Roboto Slab', serif;">Totoro Emergency Medical System</div>
     
     <!-- NAVIGATION MENU -->
     <div class="nav-items">
         <ul class="fold">
         
         <div class="noti" id="noti">
             <li class="notilist" style="padding-top:1px;">
             <a  class="notification" onclick="toggleNotification()">
            <span><i class="fa fa-bell" style="font-size:25px;color:white;"></i></span>
            <span class="badge">
                <%if(!rs.getString(1).equals("0")){%>
                <%=rs.getString(1)%>
                <%}%>
            </span>
            </a>
            <%
                String query2="SELECT*FROM `notification` INNER JOIN `user` ON `notification`.`from` = `user`.`userid` where `to`="+String.valueOf(id)+" and `status`='unread' ORDER BY `date`DESC LIMIT 6";
                Statement st2=con.createStatement();
                ResultSet rs2=st2.executeQuery(query2);
               
            %>
             <ul class="notidropdown" id="notidropdown" style="padding:0px;background-color:#ff748c;">
                <% int i=0; 
                while(rs2.next()){%>
                
                    <li style="border-bottom:2px solid white; background-color:#fff3f5;margin-top:0px;"><a style="color:black;" href="trackFriend.jsp?id=<%= rs2.getInt("id") %>"><%=rs2.getString("name")%><br><span style="font-size:16px; color:#ff6666;"><%=rs2.getString("title")%></span><br><span style="color:#ffa7b6;font-size:14px;"><%=rs2.getString("date")%></span></a></li>
                <%i+=1;
                    }
                if(i==0){%>
                    <li style=" background-color:#fff3f5;margin-top:0px; color:black;border-top-left-radius: 8px;border-top-right-radius: 8px; height:20px;"></li>
                    <li style="border-bottom:2px solid white; background-color:#fff3f5;margin-top:0px; color:black; height:60px;">No new notification</li>
                    <%}%>
                <li><a  style="color:white;" href="NotificationHistory.jsp">View All Notification</a></li>
           </ul> 
            </li>
         </div> 
       </ul>
         
     <ul class="nav-links">
       <!-- USING CHECKBOX HACK -->
       <input type="checkbox" id="checkbox_toggle" class="hidden"/>
       <label for="checkbox_toggle" class="hamburger">&#9776;</label>
       <!-- NAVIGATION MENUS -->
       <div class="menu">
        
        <li><a id="#home" href="/TotoroEmergencyMedical/index.jsp" >Home</a></li>
        
         
         <li><a href="/TotoroEmergencyMedical/findFriend.jsp">Emergency</a></li>
         <li><a href="/TotoroEmergencyMedical/addFriends.jsp">Add Friends</a></li>
         <li class="services">
             <a onclick="toggleServices()">Services</a>
           <!-- DROPDOWN MENU -->
           <ul class="dropdown" id="dropdown">
               <%if(usertype.equals("admin")){%>
                   <li><a href="/TotoroEmergencyMedical/admin/EmergencyContact/viewContact.jsp">Manage Emergency Contact</a></li>
                    <li><a href="/TotoroEmergencyMedical/admin/article/viewArticle.jsp">Manage Article</a></li>
                    <li><a href="/TotoroEmergencyMedical/admin/news/viewNews.jsp">Manage News</a></li>
                    <li><a href="/TotoroEmergencyMedical/aedController?action=VIEW&page=1">Manage AED</a></li>
                    <li><a href="/TotoroEmergencyMedical/aed/viewAEDList.jsp">Manage Rating</a></li>
                    <li><a href="/TotoroEmergencyMedical/Forum">Forum</a></li>
                    <li><a href="/TotoroEmergencyMedical/Rating">Rating</a></li>
                    <li><a href="/TotoroEmergencyMedical/Report">Manage Report</a></li>
               <%}else{%>
                    <li><a href="/TotoroEmergencyMedical/trackAED.jsp">Track AED Location </a></li>
                    <li><a href="/TotoroEmergencyMedical/aed/addAED.jsp">Register an AED</a></li>
                    <li><a href="/TotoroEmergencyMedical/Forum">Forum</a></li>
                    <li><a href="/TotoroEmergencyMedical/Rating">Rating</a></li>
                    <li><a href="/TotoroEmergencyMedical/Report">Manage Report</a></li>
                    <li><a href="/">User 4</a></li>
             <%}%>
           </ul>
         </li>
         <li><a href="/TotoroEmergencyMedical/logout.jsp"">LogOut</a></li>
         
       </div>
     </ul>
     </div>
   </nav>
           <br><br><br><br>  
           <%}%>
    </body>
</html>
