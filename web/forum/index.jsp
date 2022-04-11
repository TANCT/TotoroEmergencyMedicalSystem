<%-- 
    Document   : index
    Created on : Dec 21, 2021, 5:23:24 PM
    Author     : Asus
--%>

<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="com.model.post"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Totoro Forum</title>
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
            String name=null;
            int id=-1;
            if(session.getAttribute("username")!=null)
            {
                 name=(String) session.getAttribute("username");
                 id=(Integer) session.getAttribute("userID");
            }
            String searchid=request.getParameter("id");
            List<post> posts=(ArrayList<post>) session.getAttribute("posts");
            
        %>
        <div id="refresh"></div>
        <div class="container">
            <div class="left">
                <div class="header">
                    <a href="Forum"><h1>Forum</h1></a>
                </div>
                <div class="search">
                    <form action="Forum" method="POST">
                        <input type="image" src="images/search.png" alt="Submit" width="20" height="20">
                        <input type="text" name="searchKey" placeholder="Search something..." style="height: 25px;font-size: large;">
                    </form>
                </div>
                <div class="category">
                    <a href="Forum">#All</a><br>
                    <a href="Forum?category=Daily">#Daily</a><br>
                    <a href="Forum?category=FirstAid">#FirstAid</a><br>
                    <a href="Forum?category=HealthAndSafety">#HealthAndSafety</a><br>
                    <a href="Forum?category=Medication">#Medication</a><br>
                    <a href="Forum?category=Hospital">#Hospital</a><br>
                </div>
            </div>
            
            <div class="body">
                <%
                    if(id!=-1&&searchid!=null&&(Integer.parseInt(searchid)==id))
                    { %>
                <h1 style="border-bottom: solid black 1px;"><%=(String) session.getAttribute("username") %>'s Posts</h1>

                <%    }
                %>
                <% 
                    for(post p:posts)
                    { %>
                        <div class="post">
                            <div class="post-info">
                                <p><a href="Forum?id=<%=p.getUserid() %>"><%=p.getUsername()%></a> | <%=p.getCategory()%> | last update on <%=p.getDate()%></p>
                            </div>
                            <div class="title">
                                <a href="Forum?action=VIEW&postId=<%=p.getPostId()%>"><p><u><%=p.getSubject()%></u></p></a>
                            </div>
                            <div class="description">
                                <p><%=p.getDescription()%></p>
                            </div>

                            <% if(p.getPhoto()!=null){ %>
                                <div class="photo">
                                    <img src="<%=p.getPhoto()%>" alt="photo" height=200px>
                                </div>
                            <% } %>

                            <% if(p.getUrl()!=null){ %>
                                <div class="url">
                                    <b>Attach:</b> <a href="<%=p.getUrl()%>"><%=p.getUrl()%></a>
                                </div>
                            <% } %>

                            <div class="replies">
                                <img src="images/comment.png" alt="comment" width="20" height="20">&nbsp;&nbsp;
                                    <%=p.getCommentNo()%>
                            <%
                                if(p.getUserid()==id)
                                { %>
                                <a href="Forum?action=EDIT&postId=<%=p.getPostId() %>">Edit</a> | 
                                <a href="Forum?action=DELETE&postId=<%=p.getPostId()%>">Delete</a>
                                <% } %>
                            </div>
                        </div>
                <%    }
                %>
                <p style="text-align: center;">- reach end -</p>
            </div>
            
            <div class="right">
                <%
                    if(name==null)
                    {
                %>
                    
                        <div class="create">

                            <button onclick="document.location='../login.jsp'">Login</button>
                        </div>
                        <div class="user">
                            <br><br>
                            <p style="font-size: medium;">Login to share your thoughts!</p>
                        </div>
                            <%
                        }else{
                    %>
                        <div class="user">        
                            <a href="Forum?id=<%=id%>"><h1><%=name%></h1></a>
                        </div>
                        <div class="create">

                            <button onclick="document.location='forum/createPost.jsp'">Post something...</button>
                        </div>
                            <% 
                        }
                    %>
                    

                
            </div>
        </div>
                    <jsp:include page="../footer.jsp" />  
    </body>
</html>
