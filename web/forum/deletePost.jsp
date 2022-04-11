<%-- 
    Document   : deletePost
    Created on : Dec 25, 2021, 12:09:27 AM
    Author     : Asus
--%>

<%@page import="com.model.post"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Edit Post</title>
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
        <div id="refresh"></div>
        <div class="container">
            
            <div class="left">
                <div class="header">
                    <a href="index.jsp"><h1>Forum</h1></a>
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
            
            <%
            String name=null;
            int id=-1;
            if(session.getAttribute("username")!=null)
            {
                 name=(String) session.getAttribute("username");
                 id=(Integer) session.getAttribute("userID");
            }
            post p=(post) session.getAttribute("post");
        %>
            <div class="createPost">
                <div class="header">
                    <h1>Delete Post</h1>
                </div>
                <% 
                    int userid=(Integer)session.getAttribute("userID");
                    if(userid==p.getUserid() )
                { %>
                        <h1 class='username'><%=session.getAttribute("username") %></h1>
                    <form method="POST" action="Forum">
                        <input type="text" name="postId" value="<%=p.getPostId()%>" hidden>
                        <input type="text" name="action" value="DELETE" hidden>
                        <input type="text" name="deleted" value="confirm" hidden>
                        <h2>Are you sure you want to delete this post?</h2>
                        
                        <p>#<%=p.getCategory()%></p>
                        <h3><%=p.getSubject() %></h3>
                        <p><%=p.getDescription()%></p>
                        <% if(p.getPhoto()!=null){ %>
                        <div class="photo">
                            <img src="<%=p.getPhoto()%>" alt="photo" height=200px>
                        </div>
                        <% } %>

                        <% if(p.getUrl()!=null){ %>
                            <div class="url">
                                <b>Attach:</b> <a href="<%=p.getUrl()%>" ><%=p.getUrl()%></a>
                            </div>
                        <% } %>
                        <br>
                        <div class="create">
                            <input type="submit" value="Delete">
                            <button><a href="Forum">Cancel</a></button>
                        </div>

                    </form>
            <%    }else{
                %>
                <p style="text-align: center">This is not your post</p>
                <% } %>
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
                    <jsp:include page="../footer.jsp" />  
    </body>

</html>