<%-- 
    Document   : footer
    Created on : Dec 19, 2021, 5:40:06 PM
    Author     : User
--%>

<%@page import="java.io.File"%>
<%@page import="java.util.Date"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Footer</title>
        <%String relativeWebPath = "/css/style.css";
        String absoluteDiskPath = getServletContext().getRealPath(relativeWebPath);
        File tempFile = new File(absoluteDiskPath);
        if(tempFile.exists()){%>
        <link rel="stylesheet" href="css/style.css" />   
        <%}else{%>
        <link rel="stylesheet" href="../../css/style.css" />  
        <%}%>
    </head>
    <body>
        <br><br><br>
        <footer>
            Copyright © 2021 www.totoro_emergency_medical.com.my. It was last accessed at <%=new Date()%>
        </footer>
    </body>
</html>
