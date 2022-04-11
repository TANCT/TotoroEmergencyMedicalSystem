<%-- 
    Document   : editContact
    Created on : Dec 22, 2021, 7:59:28 PM
    Author     : User
--%>

<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link rel="stylesheet" href="../../css/page.css">
        <link rel="stylesheet" href="../../css/style.css">
         <script src="http://code.jquery.com/jquery-latest.js"></script>
         <link href="https://fonts.googleapis.com/css2?family=Pushster&display=swap" rel="stylesheet">
        <script>
             $(document).ready(function(){
                
                $("#refresh").load("../../header.jsp");
            setInterval(function(){
                  $("#refresh").load("../../header.jsp");
            }, 3000);
            });
        </script>
        <style>
            #content{
                margin-left:10%;
                margin-right:10%;
                display:flex;
                flex-direction: column;
                align-items: center;
                
            }
            h1{
                font-size:30px;
                font-family: 'Pushster', cursive;
                color:#ff4500;
            }
            table,tr,th,td{
                border:none;
                font-size:20px;
                padding:10px;
            }
            th{
                text-align: left;
               
            }
            table{
                width:70%;
                display:block;
            }
            input{
                font-size: 20px;
                padding:5px;
            }
            input[type=submit]{
                padding:10px;
                background-color:#00b2ff;
                color:white;
                width:90px;
                border:2px solid white;
                
               
                
            }
            #center{
                display:flex;
                justify-content: center;
            }
            
        </style>
    </head>
    <body>
        
        <% 
                if(session.getAttribute("usertype")==null){%>
                    <script>alert('Please Login First');location.href='/TotoroEmergencyMedical/login.jsp';</script>
                   <% 
                }else if(!session.getAttribute("usertype").equals("admin")){%>
        <script>alert('Only Admin can access');location.href='/TotoroEmergencyMedical/login.jsp'</script><%}
        else if(request.getParameter("id")==null){
                    response.sendRedirect("viewContact.jsp");
                }else{
                String driver="com.mysql.jdbc.Driver";           
                String dbName="totoro";
                String url="jdbc:mysql://localhost/"+dbName+"?";
                String userName="root";
                String password="";
                String id=request.getParameter("id");
                String query="SELECT*FROM `hospital` where `id`="+id; 

                Class.forName(driver);
                Connection con=DriverManager.getConnection(url,userName,password);
                Statement st=con.createStatement();
                ResultSet rs=st.executeQuery(query);
               
                
            %>
        <div id="refresh"></div>
        <div id="content">
            <h1 align="center">Edit Contact</h1><br>
        <form action="/TotoroEmergencyMedical/hospitalController" method="post">
            <input type='hidden' value='edit' name='action'>
            <table>
            <%while(rs.next()){%>
            <input type="hidden" name="id" value="<%=String.valueOf(rs.getInt("id"))%>"
            <tr>
                <th>Name</th>
                <td><input type="text" name="name" value="<%=rs.getString("name")%>"></td>
            </tr>
            <tr>
                <th>Phone</th>
                <td><input type="text" name="phone" value="<%=rs.getString("phone")%>"></td>
            </tr>
            <tr>
                <th>Latitude</th>
                <td><input type="text" name="lat" value="<%=String.valueOf(rs.getFloat("lat"))%>"></td>
            </tr>
            <tr>
                <th>Longitude</th>
                <td><input type="text" name="lon" value="<%=String.valueOf(rs.getFloat("lon"))%>"></td>
            </tr>
            
            <%}%>
           
            </table><br>
            <div id="center">
            <input type="submit" value="Submit" >
            </div>
        </form>
            </div>
        <jsp:include page="../../footer.jsp" />  
        <%}%>
    </body>
</html>
