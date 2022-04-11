<%-- 
    Document   : viewPost
    Created on : Dec 25, 2021, 2:05:49 AM
    Author     : Asus
--%>

<%@page import="com.model.post_comment"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="com.model.post"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>View Post</title>
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
            
            <%
            String name=null;
            int id=-1;
            if(session.getAttribute("username")!=null)
            {
                 name=(String) session.getAttribute("username");
                 id=(Integer) session.getAttribute("userID");
            }
            post p=(post) session.getAttribute("post");
            List<post_comment> comments=(ArrayList<post_comment>) session.getAttribute("comments");
        %>
        <div class="body">
        <div class="post">
                <div class="post-info">
                    <p><a href="Forum?id=<%=p.getUserid()%>"><%=p.getUsername()%></a> | <%=p.getCategory()%> | <%=p.getInitialdate() %></p>
                </div>
                <div style="font-weight: bolder;font-size:x-large;">
                    <p><u><%=p.getSubject()%></u></p>
                </div>
                <div>
                    <p><%=p.getDescription()%></p>
                </div>

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
                <div class="replies">
                    <img src="images/comment.png" alt="comment" width="20" height="20">&nbsp;&nbsp;
                    <%=p.getCommentNo()%> | <a href="report/report.jsp?type=POST&id=<%=p.getPostId()%>">Report</a>
                    
                </div>

        </div>
                <div class="commentlist">
                    <% if (session.getAttribute("username")!=null){ %>
                    <div class="comment">
                        <h4 class='username'><%=session.getAttribute("username") %></h4>
                        <form action="Forum" method="post">
                            <input type="text" name="action" value="COMMENT" hidden>
                            <input type="text" name="postId" value="<%=p.getPostId()%>" hidden>
                            <textarea name="comment" maxlength="1000" rows="4" placeholder="Comment something..." required></textarea>
                            <input type="submit" value="Submit"><br>
                        </form>
                    </div>
                        <% } %>
                   <%
                       for(post_comment c:comments)
                       {
                   %>
                    <div class="comment">
                        <div class="post-info">
                       <p><a href="Forum?id=<%=c.getUserid() %>"><%=c.getUsername() %></a> | <%=c.getDate() %> | <a href="report/report.jsp?type=COMMENT&id=<%=c.getCommentId()%>">Report</a></p>
                        </div>
                       <p><%=c.getComment() %></p><br>
                   </div>
                   <% } %>
                </div>
             

        </div>
                <div class="right">
                
                    <%
                        
                        if (session.getAttribute("username")==null)
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