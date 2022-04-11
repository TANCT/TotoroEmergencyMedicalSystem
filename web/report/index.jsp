<%-- 
    Document   : index
    Created on : Jan 28, 2022, 1:22:05 AM
    Author     : Asus
--%>

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
        <style><%@include file="../css/forum.css"%></style>
        
        <script src="http://code.jquery.com/jquery-latest.js"></script>
        <link href="https://fonts.googleapis.com/css2?family=Pushster&display=swap" rel="stylesheet">
        <link href="https://fonts.googleapis.com/css2?family=Noto+Serif:ital@1&display=swap" rel="stylesheet">
        <script> 
            $(document).ready(function(){
                $("#refresh").load("/TotoroEmergencyMedical/header.jsp");
            setInterval(function(){
                  $("#refresh").load("/TotoroEmergencyMedical/header.jsp");
            }, 3000);
            });
            
           </script>
    </head>
    <body>
        <%
            List<report> reports=(ArrayList<report>) session.getAttribute("reports");
            
        %>
        <% if(session.getAttribute("username")==null){ 
        
            response.sendRedirect("../login.jsp");
        
        }else{%>
        <div id="refresh"></div>
        <div class="container">
            <div class="left">
                <div class="header">
                    <a href="Report"><h1>Report</h1></a>
                </div>
                <div class="search">
                    <form action="Forum" method="POST">
                        <input type="image" src="images/search.png" alt="Submit" width="20" height="20">
                        <input type="text" name="searchKey" placeholder="Search something..." style="height: 25px;font-size: large;">
                    </form>
                </div>
                <div class="category">
                    <form action="Report" method="post">
                        <p>Filter</p>
                        <a href="Report">#All</a><br>
                        <p>Type: </p>
                        <input type="checkbox" name="type" value="POST">POST <br>
                        <input type="checkbox" name="type" value="COMMENT">COMMENT<br>
                        <input type="checkbox" name="type" value="RATING">RATING<br>
                        <p>Status:</p>
                        <input type="checkbox" name="status" value="Pending">Pending<br>
                        <input type="checkbox" name="status" value="APPROVED">APPROVED<br>
                        <input type="checkbox" name="status" value="REJECTED">REJECTEED<br>
                        
                        <input type="submit" value="Apply Filter">
                    </form>
                </div>
            </div>
            
            
            <div class="table-wrapper" style="width:75%">
                    <table class="fl-table">
                    <thead>
                    <tr>
                        <th>Report ID</th>
                        <th>Type</th>
                        <th>Problem</th>
                        <th>Description</th>
                        <th>Status</th>
                        <th>Date</th>
                        <th>Click for details</th>
                    </tr>
                    </thead>
                    
                    <%
                        for(report r:reports)
                        {%>
                        <tr>
                            <td><%=r.getReportId()%></td>
                            <td><%=r.getType() %></td>
                            <td><%=r.getProblem() %></td>
                            <td><%=r.getDescription() %></td>
                            <td><%=r.getStatus() %></td>
                            <td><%=r.getDate() %></td>
                            <td><a href="Report?action=VIEW&reportId=<%=r.getReportId() %>">Details</a></td>
                        </tr>
                    <%    }
                    %>
                </table>
                <p style="text-align: center;">- reach end -</p>
            </div>
            
            
            
        </div>
                    <jsp:include page="../footer.jsp" />  
                    <%}%>
    </body>
</html>
