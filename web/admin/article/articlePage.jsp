<%-- 
    Document   : articlePage
    Created on : Dec 21, 2021, 6:22:44 PM
    Author     : User
--%>

<%@page import="com.model.Article"%>
<%@page import="com.model.ArticleData"%>
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
                Article article=ArticleData.getArticle(id);

                
               
            %>
            <div class="background">
                <div id="content">
                    
                    <h1 align="center"><%=article.getTitle()%></h1>
                    <br><br>
                    <div class="art-img"><img src="<%=article.getPhoto()%>" height="400px" width="auto" ></div>
                    <div class="para" id="para">
                        <br>
                        <%if(!article.getPara1().isEmpty()){%>
                            <%=article.getPara1()%>
                        <%}%>
                        <%if(!article.getPara2().isEmpty()){%>
                           <%=article.getPara2()%>
                        <%}%>
                        <%if(!article.getPara3().isEmpty()){%>
                            <%=article.getPara3()%>
                        <%}%>
                        <%if(!article.getPara4().isEmpty()){%>
                            <%=article.getPara4()%>
                        <%}%>
                        <%if(!article.getPara5().isEmpty()){%>
                            <%=article.getPara5()%>
                        <%}%>
                       
                    
                    </div>
                    
                    
                    
                    
                    
                    
                    
                   
                </div>
            </div>
        <jsp:include page="../../footer.jsp" />  
    </body>
</html>
