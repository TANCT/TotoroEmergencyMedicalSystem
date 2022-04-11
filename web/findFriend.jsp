<%-- 
    Document   : findFriend
    Created on : Dec 18, 2021, 3:17:41 PM
    Author     : User
--%>

<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Arrays"%>
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
        <link rel="stylesheet" href="css/page.css">
        <link href="https://fonts.googleapis.com/css2?family=Pushster&display=swap" rel="stylesheet">
        <!--<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script-->
        <script src="http://code.jquery.com/jquery-latest.js"></script>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        
        <script>
          getLocation();
            function getLocation() {
              if (navigator.geolocation) {
                navigator.geolocation.getCurrentPosition(showPosition);
              } 
            }

            function showPosition(position) {
              document.geolocation.lat.value=position.coords.latitude.toString();
              document.geolocation.lon.value=position.coords.longitude.toString();
              document.friendrequest.location.value=position.coords.latitude + "," + position.coords.longitude;
            }
           
            $(document).ready(function(){
                $("#refresh").load("header.jsp");
            setInterval(function(){
                  $("#refresh").load("header.jsp");
            }, 3000);
            });
           
            
            function selectAll(){
                var allRows = document.getElementsByName("friend");
                for (var i=0; i < allRows.length; i++) {
                    if (allRows[i].type === 'checkbox') 
                    {
                        allRows[i].checked = true;
                    }
                }
            }
            function deselectAll(){
                var allRows = document.getElementsByName("friend");
                for (var i=0; i < allRows.length; i++) {
                    if (allRows[i].type === 'checkbox') 
                    {
                        allRows[i].checked = false;
                    }
                }
            }

        </script>
        <style>
            #content{
                   margin-top:20px;
                   margin-left:100px;
                   margin-right:100px;
                   display:flex;
                   flex-direction: column;
                   justify-content: space-around;
               }
               body{
                   background-color: lightcyan;
               }
              
               .sidebtn{
                   font-weight: bold;
                   padding:10px;
                   background-color: lightgreen;
                   color:white;
                   font-size:20px;
                   border:1px solid white;
                   
               }
               .form{
                   display: flex;
                   justify-content: space-between;
               }
               
               #title{
                   font-family: 'Pushster', cursive;
                   color:#ff4500;
                   font-size:40px;
                   
                   
               }
               .sharelocation{
                   display:flex;
                   flex-direction: column;
                   align-items: center;
                   align-content: center;
                   border:10px solid white;
                   min-height:600px;
               }
               h3{
                    font-size:30px;
                    color:#48aaad;
                }
                .form2{
                    font-size: 24px;
                }
                .double-button{
                    display:flex;
                    justify-content: center;
                    
                }
                .double-button button{
                    font-weight: bold;
                    padding:10px;
                    font-size:20px;
                }
                #btn-1{
                    background-color:#26abff;
                    color:white;
                    width:120px;
                    border:1px solid white;
                }
                #btn-2{
                    background-color:white;
                    color:#26abff;
                    width:120px;
                    border:1px solid #26abff;
                }
                #submit{
                    font-weight: bold;
                    padding:10px;
                    font-size:20px;
                    background-color:cyan;
                    color:white;
                    width:120px;
                    border:1px solid white;
                    
                }
                #center-div{
                    display: flex;
                    justify-content: flex-end;
                }
                table,tr,td{
                    border:none;
                }
                td a{
                    font-weight:bold;
                    color:#009dff;
                    text-decoration: underline;
                }
                @media (max-width: 768px) {
                    #content{
                   margin-top:20px;
                   margin-left:20px;
                   margin-right:20px;
                   display:flex;
                   flex-direction: column;
               }
               .form{
                   display: flex;
                   flex-direction: column;
               }
               .sidebtn{
                   font-size:14px;
               }
                
                
        </style>
        
    </head>
    <body>
        <%if(session.getAttribute("username")==null){
            response.sendRedirect("login.jsp");
        }else{
          String userID=String.valueOf(session.getAttribute("userID"));
          %>
        <div id="refresh"></div>
        
        
        <div id="content">
            
            <div class="form">
                <h1 id="title">Emergency Contact</h1>
                <form   name="geolocation" method="post" action="geolocation.jsp">
                    
                    <input type="hidden" name="lat" value="0" readonly="true">
                    <input type="hidden" name="lon" value="0" readonly="true">
                     
                    <input type="submit" value="Show nearby Hospital Contact" class="sidebtn">
                    

                </form>
            </div> 
            <br><br><br>
            
                

            <%  
                String query="";
                String q=request.getParameter("name");
                String driver="com.mysql.jdbc.Driver";           
                String dbName="totoro";
                String url="jdbc:mysql://localhost/"+dbName+"?";
                String userName="root";
                String password="";
                Class.forName(driver);
                Connection con=DriverManager.getConnection(url,userName,password);
                query="SELECT `friends` from `user` where `userid`="+userID;
                Statement st=con.createStatement();
                ResultSet rs=st.executeQuery(query);
                rs.next();
                if(rs.getString(1)!=null){
                    
                
                String []friends=rs.getString(1).split(",");
                List<String> friendList=Arrays.asList(friends);
                
                st.close();
                
                Statement st2=con.createStatement();
                query="SELECT * FROM `user` ORDER BY `name`";    
                ResultSet rs2=st2.executeQuery(query);
                
            %>
            <div class="sharelocation">
                <br><br>
                <h3>Notify Friends</h3><br><br>
                <form name="friendrequest" method="post" action="/TotoroEmergencyMedical/notificationController" class="form2">
                    <!--<input type="text" name="search">-->
                    <h4>Select Friends to notify:</h4><br>
                    
                    <table>
                    <%while(rs2.next()){%>
                    
                    <%if(friendList.contains(String.valueOf(rs2.getInt("userid")))){
                    %>
                   
                    
                    <tr>
                        <td><input type="checkbox" name="friend" value="<%=rs2.getString("userid")%>"></td>
                        <td>&nbsp;<%=rs2.getString("name")%> &nbsp;&nbsp;  </td>
                        <td><i class="fa fa-phone" style="font-size:24px;color:red"></i>&nbsp;<a href="tel:<%=rs2.getString("phone")%>"  title="Click to call"><%=rs2.getString("phone")%></a></td>
                    
                    
                    </tr>
                   
                    
                    <% }
                    }%> 
                    </table>
                    <br>
                    <div class="double-button">
                    <button type="button" id="btn-1" onClick="selectAll()">Select All</button><button type="button" id="btn-2" onClick="deselectAll()">Clear All</button>
                    </div>
                    <br><br>
                    
                    Special Requirement(Optional)<br><br>
                    <textarea rows="4" cols="100" maxlength="50" name="body" style="padding:10px;"></textarea>
                     <br><br>
                     <input type="hidden" name="location">
                     <div id="center-div">
                     <input type="submit" value="Submit" id="submit">
                     </div>
                     <br><br>
                </form>
              <%}else{%>
        <h2 >No Friends yet</h2>
        <%}%>      
            
        </div>
       
        <jsp:include page="footer.jsp" />  
        
        
        
            <%}%>
        
    </body>
</html>
