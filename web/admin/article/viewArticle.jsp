 <%@page import="com.model.ArticleData"%>
<%@page import="java.util.List"%>
<%-- 
    Document   : viewArticle
    Created on : Dec 21, 2021, 3:22:54 PM
    Author     : User
--%>

<%@page import="com.model.Article"%>
<%@page import="java.util.ArrayList"%>
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
        <h1 align="center">Article</h1>
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
                List<Article>articleList=ArticleData.getArticleList();
                
                
            %>
            <tbody>
                <%for(Article a:articleList){%>
                <tr>
                <td><%=String.valueOf(a.getId())%></td>
                <td><%=a.getTitle()%></td>
                <td><%=a.getDate()%></td>
                <td class="btn"><a href="articlePage.jsp?id=<%=String.valueOf(a.getId())%>"><button type="button">Details</button></a> 
                <a href="editArticle.jsp?id=<%=String.valueOf(a.getId())%>"><button type="button">Edit</button></a>
                <a href="/TotoroEmergencyMedical/articleController?id=<%=String.valueOf(a.getId())%>&&action=delete"><button type="button">Delete</button></a></td>
                </tr>
                <%}%>
            
            </tbody>
            
        </table>
            
            
            </div>
            <br>
            <a class="center" href="createArticle.jsp"><button>Create</button></a>
            </div>
            <jsp:include page="../../footer.jsp" /> 
            <%}%>
    </body>
</html>
