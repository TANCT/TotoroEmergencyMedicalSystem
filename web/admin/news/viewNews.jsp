<%-- 
    Document   : viewNews
    Created on : Jan 2, 2022, 10:05:19 PM
    Author     : User
--%>

<%@page import="com.model.News"%>
<%@page import="java.util.List"%>
<%@page import="com.model.NewsData"%>
<%@page import="com.model.News"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
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
        <script>
             $(document).ready(function(){
                
                $("#refresh").load("../../header.jsp");
            setInterval(function(){
                  $("#refresh").load("../../header.jsp");
            }, 3000);
            });
        </script>
    </head>
    <body>
        <%if(session.getAttribute("username")==null){
            response.sendRedirect("../../login.jsp");
        }else{%>
        <div id="refresh"></div>
        <div class="con">
            <br><br>
        <h1 align="center">News</h1>
        <br>
        <div class='center'>
            
        <table>
            <thead>
                <tr style="overflow-y: scroll">
                    <th width="5%" height="20px">Id</th>
                    <th width="40%" height="20px">Title</th>
                    <th width="20%" height="20px">Date</th>
                    <th width="60%"></th>
                    
                </tr>
            </thead>
            <%
                List<News> newsList=NewsData.getNewsList();
                
                
            %>
            <tbody>
                <%for(News news:newsList){%>
                <tr>
                <td><%=String.valueOf(news.getId())%></td>
                <td><%=news.getTitle()%></td>
                <td><%=news.getDate()%></td>
                <td class="btn"><a href="newsPage.jsp?id=<%=String.valueOf(news.getId())%>"><button type="button">Details</button></a> 
                <a href="editNews.jsp?id=<%=String.valueOf(news.getId())%>"><button type="button">Edit</button></a>
                <a href="/TotoroEmergencyMedical/newsController?id=<%=String.valueOf(news.getId())%>&&action=delete"><button type="button">Delete</button></a></td>
                </tr>
                <%}%>
            
            </tbody>
            
        </table>
            
            
            </div>
            <br>
            <a class="center" href="createNews.jsp"><button>Create</button></a>
            </div>
            <jsp:include page="../../footer.jsp" /> 
            <%}%>
    </body>
</html>