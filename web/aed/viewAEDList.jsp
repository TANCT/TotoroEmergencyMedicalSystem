<%-- 
    Document   : viewAEDList
    Created on : Dec 24, 2021, 9:34:37 PM
    Author     : USER
--%>

<%@page import="java.util.ArrayList"%>
<%@page import="java.lang.String"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Vector"%>
<%@page import="com.model.aed"%>
<%@page import="com.model.aedData"%>
<%@page import="com.model.user"%>
<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    ArrayList<String> userSessionList = (ArrayList<String>)session.getAttribute("user");
            String spageid=request.getParameter("page");  
            int pageid=Integer.parseInt(spageid);  
            int total=5;  
            if(pageid==0){
                spageid="1";
                pageid=1;
            }
            if(pageid==1){}  
            else{  
                pageid=pageid-1;  
                pageid=pageid*total+1;  
            }  
            List<aed> list=aedData.getRecords(pageid,total); 
    %>
<!DOCTYPE html>
<html>
    <head>
        <link href="../images/totoroLogo.png" rel="icon">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Manage AED</title>
        <style>
            table, th, td{
               border:1px solid black;
               border-collapse:collapse;
               
            }
            th, td{
                padding-top:7px;
                padding-bottom: 7px;
            }
            th{
                background-color: lightblue;
            }
            table{
                width:70%;
               margin:0 auto 0 auto;
               text-align: center;
            }
            .edit{
                background-color:cyan; 
                border-radius: 20px;
                width:70px;
                height:40px;
                font-weight: bold; 
                border-color: white;
            }
            .delete{
                background-color:red; 
                border-radius: 20px;
                width:70px;
                height:40px;
                font-weight: bold; 
                border-color: white;
            }
            .create{
                align-items: center;
  background-color: #0A66C2;
  border: 0;
  border-radius: 100px;
  box-sizing: border-box;
  color: #ffffff;
  cursor: pointer;
  display: inline-flex;
  font-family: -apple-system, system-ui, system-ui, "Segoe UI", Roboto, "Helvetica Neue", "Fira Sans", Ubuntu, Oxygen, "Oxygen Sans", Cantarell, "Droid Sans", "Apple Color Emoji", "Segoe UI Emoji", "Segoe UI Symbol", "Lucida Grande", Helvetica, Arial, sans-serif;
  font-size: 16px;
  font-weight: 600;
  justify-content: center;
  line-height: 20px;
  max-width: 480px;
  min-height: 40px;
  min-width: 0px;
  overflow: hidden;
  padding: 0px;
  padding-left: 20px;
  padding-right: 20px;
  text-align: center;
  touch-action: manipulation;
  transition: background-color 0.167s cubic-bezier(0.4, 0, 0.2, 1) 0s, box-shadow 0.167s cubic-bezier(0.4, 0, 0.2, 1) 0s, color 0.167s cubic-bezier(0.4, 0, 0.2, 1) 0s;
  user-select: none;
  -webkit-user-select: none;
  vertical-align: middle;
            }
            
            .pagination {
  display: inline-block;
}

.pagination a {
  color: black;
  float: left;
  padding: 8px 16px;
  text-decoration: none;
}

.pagination a.active {
  background-color: #6fc7e3;
  color: white;
}

.pagination a:hover:not(.active) {background-color: #ddd;}

        </style>
        <style><%@include file="/css/page.css" %></style>
        <style><%@include file="/css/style.css" %></style>
        <script src="https://code.jquery.com/jquery-3.5.0.js"></script>
    </head>
    <body style="text-align:center;">
         <jsp:include page="../header.jsp" />  
        <h1>Automated External Defibrillator (AED)</h1>
        <br><br>
        <%
             /*String query="";
            String driver="com.mysql.jdbc.Driver";           
            String dbName="totoro";
            String url="jdbc:mysql://localhost/"+dbName+"?";
            String userName="root";
            String password="";
            
            Class.forName(driver);
            Connection con=DriverManager.getConnection(url,userName,password);
            query="SELECT * FROM `aed` inner join `user` where aed.user=user.userid";
            Statement st=con.createStatement();
            ResultSet rs=st.executeQuery(query);
            Vector<user> userSessionList = (Vector<user>)session.getAttribute("userList");
            Vector<aed> aedSessionList = (Vector<aed>)session.getAttribute("list");*/
            
             
            
            if(list==null){
        %>
        <h5>There is no AED registered !</h5>
        <br>
        <a href="aed/addAED.jsp"><button type="button" class="create">Register new AED</button></a>
        <br>
        <%
            }else{
            %>
            <a href="aed/addAED.jsp"><button type="button" class="create">Register new AED</button></a>
            <br><br>
            <h3>Page No.: <%= spageid %></h3>
            <br>
        <table>
            <tr>
                <th>No.</th>
                <th>Latitude</th>
                <th>Longitude</th>
                <th>User</th>
                <th>Status</th>
                <th></th>
            </tr>
            
                
                <%
                    //while(rs.next()){
                    //for(int i=0;i<aedSessionList.size();i++){
                    int i=pageid;
                      for(aed e:list)  {
                         
                %>
                <tr>
                <td><%= i %></td>
                <!--td><%= e.getId() %></td-->
                <td><%= e.getLatitude() %></td>
                <td><%= e.getLongitude()  %></td>
                
                <td><%= userSessionList.get(i-1) %></td>
                 <td><%= e.getStatus()  %></td>
                <td><a href="/TotoroEmergencyMedical/aed/updateAED.jsp?id=<%= e.getId() %>"><button type="button" class="edit">Edit</button></a>
                    &nbsp;<a href="aedController?action=DELETE&id=<%= e.getId() %>"><button type="button" class="delete">Delete</button></a></td>
                </tr>
            
            <%
                i++;
                }
                int pageChg=1;
                if(spageid.equals("1")){
                    pageChg = 1;
                }else if(spageid.equals("2")){
                    pageChg = 2;
                }else if(spageid.equals("3")){
                    pageChg = 3;
                }else if(spageid.equals("4")){
                    pageChg = 4;
                }else if(spageid.equals("5")){
                    pageChg = 5;
                }
                %>
        </table>
        <br>
        <div class="pagination">
  <a href="/TotoroEmergencyMedical/aedController?action=VIEW&page=<%= pageChg-1 %>">&laquo;</a>
 <a href="/TotoroEmergencyMedical/aedController?action=VIEW&page=1" class="" id="one">1</a>  
 <a href="/TotoroEmergencyMedical/aedController?action=VIEW&page=2" class="" id="two">2</a>  
<a href="/TotoroEmergencyMedical/aedController?action=VIEW&page=3" class="" id="three">3</a>  
<a href="/TotoroEmergencyMedical/aedController?action=VIEW&page=4" class="" id="four">4</a>  
<a href="/TotoroEmergencyMedical/aedController?action=VIEW&page=5" class="" id="five">5</a>  
  <a href="/TotoroEmergencyMedical/aedController?action=VIEW&page=<%= pageChg+1 %>" >&raquo;</a>
</div>
        
        
        <%
                }
                %>
                
                <script>
                    if(<%= spageid %>===1){
                        $("#one").addClass("active");
                        $("#two").removeClass("active");
                        $("#three").removeClass("active");
                        $("#four").removeClass("active");
                        $("#five").removeClass("active");
                    }else if(<%= spageid %>===2){
                        $("#two").addClass("active");
                        $("#one").removeClass("active");
                        $("#three").removeClass("active");
                        $("#four").removeClass("active");
                        $("#five").removeClass("active");
                    }
                    else if(<%= spageid %>===3){
                        $("#three").addClass("active");
                        $("#two").removeClass("active");
                        $("#one").removeClass("active");
                        $("#four").removeClass("active");
                        $("#five").removeClass("active");
                    }
                    else if(<%= spageid %>===4){
                        $("#four").addClass("active");
                        $("#two").removeClass("active");
                        $("#three").removeClass("active");
                        $("#one").removeClass("active");
                        $("#five").removeClass("active");
                    }
                    else if(<%= spageid %>===5){
                        $("#five").addClass("active");
                        $("#two").removeClass("active");
                        $("#three").removeClass("active");
                        $("#four").removeClass("active");
                        $("#one").removeClass("active");
                    }
                </script>
                
         <jsp:include page="../footer.jsp" />  
    </body>
</html>
