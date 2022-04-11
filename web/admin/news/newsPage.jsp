<%-- 
    Document   : articlePage
    Created on : Dec 21, 2021, 6:22:44 PM
    Author     : User
--%>

<%@page import="com.model.News"%>
<%@page import="com.model.NewsData"%>
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
        <link href="https://fonts.googleapis.com/css2?family=Pushster&display=swap" rel="stylesheet">
        <script src="http://code.jquery.com/jquery-latest.js"></script>
        <style>
           
            .background{
                display:flex;
                flex-direction: column;
            }
            .para{
                padding-left:10px;
                padding-right:10px;
                text-align: justify
                
            }
            .para p{
                font-size:larger;
                line-height: 1.2;
                font-family: Times,serif;
                
            }
            .art-img{
                display: flex;
                justify-content: center;
            }
            h1{
                font-size:30px;
                font-family: 'Pushster', cursive;
                color:#ff4500;
            }
            #content{
                margin-left:10%;
                margin-right:10%;
                font-size:20px;
                height:100%;
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
         <div id="refresh"></div> 
        <%
                
                String id=request.getParameter("id");
                News news = NewsData.getNews(id);
               
            %>
            <div class="background">
                <div id="content">
                    
                    <h1 align="center"><%=news.getTitle()%></h1>
                    <br><br>
                    <div class="art-img"><img src="<%=news.getPhoto()%>" height="400px" width="auto" ></div>
                    <div class="para" id="para">
                        <br>
                        <%if(!news.getPara1().isEmpty()){%>
                            <%=news.getPara1()%>
                        <%}%>
                        <%if(!news.getPara2().isEmpty()){%>
                           <%=news.getPara2()%>
                        <%}%>
                        <%if(!news.getPara3().isEmpty()){%>
                            <%=news.getPara3()%>
                        <%}%>
                        <%if(!news.getPara4().isEmpty()){%>
                            <%=news.getPara4()%>
                        <%}%>
                        <%if(!news.getPara5().isEmpty()){%>
                            <%=news.getPara5()%>
                        <%}%>
                       
                    
                    </div>
                    
                    
                    
                    
                    
                    
                    
                 
                </div>
            </div>
        <jsp:include page="../../footer.jsp" />  
    </body>
</html>

