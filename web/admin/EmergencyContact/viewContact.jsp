<%-- 
    Document   : viewContact
    Created on : Dec 22, 2021, 7:45:17 PM
    Author     : User
--%>

<%@page import="java.util.List"%>
<%@page import="com.model.HospitalData"%>
<%@page import="com.model.Hospital"%>

<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.DriverManager"%>
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
        <script>
            $(document).ready(function(){
                
                $("#refresh").load("../../header.jsp");
            setInterval(function(){
                  $("#refresh").load("../../header.jsp");
            }, 3000);
            });
        </script>
        <style>
            .con{
                
                margin-left: 5%;
                margin-right:5%;
               
            }
            td{
                padding:5px;
            }
            button{
                padding:5px;
                width:70px;
                border-radius:10%;
                background-color: #d35400;
                color:white;
                border-color: white;
            }
            .btn{
                display:flex;
                flex-wrap: wrap;
                align-content: space-around;
                justify-content:space-around;
            }
            thead{
                background-color:#e74c3c;
            }
            tbody{
                background-color: #fadbd8;
            }
            td{
                text-align:center;
            }
            table{
                width:70%;
            }
            .center{
                display:flex;
                justify-content: center;
            }
            
           
        </style>
    </head>
    <body>
        <%if(session.getAttribute("usertype")==null){%>
        <script>alert('Please Login First');location.href='/TotoroEmergencyMedical/login.jsp';</script>
            <%
        }else if(!session.getAttribute("usertype").equals("admin")){%>
        <script>alert('Only Admin can access');location.href='/TotoroEmergencyMedical/login.jsp'</script>
            <%}else{
            
        /*String driver="com.mysql.jdbc.Driver";
        String dbName="totoro";
        String url="jdbc:mysql://localhost/"+dbName+"?";
        String userName="root";
        String password="";
        String query="SELECT * FROM `hospital`";
        
        
        Class.forName(driver);//load and register driver
        Connection con=DriverManager.getConnection(url,userName,password);
        Statement st=HospitalData.getConnection().createStatement();
        ResultSet rs=st.executeQuery(query);*/
        List<Hospital> hospitals=HospitalData.getHospitalList();
//        for(int i=0; i<hospitals.size();i++){
//            Hospital h=new Hospital(hospitals.get(i).getName(), hospitals.get(i).getPhone(), hospitals.get(i).getLat(),hospitals.get(i).getLon() );
//            h.setId(hospitals.get(i).getID());
//            
//            hospitals.add(h);
//            
//        }%>
        <div id="refresh"></div>
        <div class="con">
            <br><br>
        <h1 align="center">Emergency Hospital Contact</h1>
        <br>
        <div class='center'>
        <table>
            <thead>
                <tr style="overflow-y: scroll">
                    <th width="5%" height="20px">Id</th>
                    <th width="40%" height="20px">Name</th>
                    <th width="20%" height="20px">Contact</th>
                    <th width="20%" height="20px">Latitude</th>
                    <th width="20%" height="20px">Longitude</th>
                    <th width="60%"></th>
                    
                </tr>
            </thead>
            <tbody>
                <%
                    for(Hospital h:hospitals){
                    
                    
                    
                %>
                <tr>
                    <td><%=String.valueOf(h.getId())%></td>
                <td><%=h.getName()%></td>
                <td><%=h.getPhone()%></td>
                <td><%=String.valueOf(h.getLat())%></td>
                <td><%=String.valueOf(h.getLon())%></td>
                <td class="btn"> 
                <a href="/TotoroEmergencyMedical/admin/EmergencyContact/editContact.jsp?id=<%=String.valueOf(h.getId())%>"><button type="button">Edit</button></a>
                <a href="/TotoroEmergencyMedical/hospitalController?id=<%=String.valueOf(h.getId())%>&&action=delete"><button type="button">Delete</button></a>
                </td>
                </tr>
            <%}%>
            
            </tbody>
            
        </table>
         </div>
            <br>
            <a class="center" href="/TotoroEmergencyMedical/admin/EmergencyContact/createContact.jsp"><button>Create</button></a>
            </div>
            <jsp:include page="../../footer.jsp" /> 
            <%}%>
    </body>
    
</html>
