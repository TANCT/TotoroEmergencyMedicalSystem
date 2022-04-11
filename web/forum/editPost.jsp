<%-- 
    Document   : editPost
    Created on : Dec 25, 2021, 12:09:05 AM
    Author     : Asus
--%>

<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
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
                    <h1>Edit Post</h1>
                </div>
                <% 
                    int userid=(Integer)session.getAttribute("userID");
                    if(userid==p.getUserid() )
                { %>
                        <h1 class='username'><%=session.getAttribute("username") %></h1>
                    <!--form method="POST" action="../editPost" enctype="multipart/form-data"-->
                    <form method="POST" action="Forum">
                        <input type="text" name="postId" value="<%=p.getPostId() %>" hidden>
                        <input type="text" name="action" value="EDIT" hidden>
                        <input type="text" name="edited" value="done" hidden>
                        <select name="category" class="category" required="">
                            <option selected disabled>#Choose Topic</option>
                            <option value="Daily" <% if(p.getCategory().equals("Daily")){%>selected<% } %> >#Daily</option>
                            <option value="FirstAid" <% if(p.getCategory().equals("FirstAid")){%>selected<% } %>>#FirstAid</option>
                            <option value="HealthAndSafety" <% if(p.getCategory().equals("HealthAndSafety")){%>selected<% } %>>#HealthAndSafety</option>
                            <option value="Medication" <% if(p.getCategory().equals("Medication")){%>selected<% } %>>#Medication</option>
                            <option value="Hospital" <% if(p.getCategory().equals("Hospital")){%>selected<% } %>>#Hospital</option>
                        </select>
                        <br>
                        <br>
                        <input type="text" name="subject" class="subject" maxlength="100" placeholder="What's the title of your sharing" required value="<%=p.getSubject() %>">
                        <br>
                        <br>
                        <textarea name="description" class="description" maxlength="8000" rows="4" placeholder="Description" required><%=p.getDescription() %></textarea>
                        <br>
                        <div class="attachment">
                            <b>Attach: </b>&nbsp;
                            <img src="images/imageicon.png" alt="" width="20" height="20" onclick="insertImage()">&nbsp;&nbsp;
                            <img src="images/urlicon.png" alt="" width="20" height="20" onclick="insertUrl()">&nbsp;&nbsp;
                            <input type = "hidden" id="photoFile" name ="image" size = "50" onclick="onchangePFile()" accept="image" hidden/>
                            <input <%if(p.getPhoto()!=null){ %>value="<%=p.getPhoto() %>" type="url"<%}else{%>type="hidden"<%}%> id="photourl" name="photo" placeholder="insert the url of the photo here..." onclick="onchangePUrl()" >
                            <input <%if(p.getUrl()!=null){ %>value="<%=p.getUrl() %>" type="url"<%}else{%>type="hidden"<%}%> type="hidden" id="url" name="url" placeholder="Insert the url here..." onclick="onchangeUrl()" >
                        </div>
                        <br>
                        <div class="create">
                            <input type="submit" value="Edit">
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

                            <button onclick="document.location='login.jsp'">Login</button>
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
<script>
    function insertImage()
    {
        var photoFile = document.getElementById("photoFile");
        var photoUrl = document.getElementById("photourl");
        var url = document.getElementById("url");
        photoFile.setAttribute('type','file');
        photoUrl.setAttribute('type','ur');
        url.setAttribute('type','hidden');
    }
    function insertUrl()
    {
        var photoFile = document.getElementById("photoFile");
        var photoUrl = document.getElementById("photourl");
        var url = document.getElementById("url");
        photoFile.setAttribute('type','hidden');
        photoUrl.setAttribute('type','hidden');
        url.setAttribute('type','url');
    }
    function onchangePFile()
    {
        var photoUrl = document.getElementById("photourl");
        var url = document.getElementById("url");
        photoUrl.setAttribute('value','');
        url.setAttribute('value','');
    }
    function onchangePUrl()
    {
        var photoFile = document.getElementById("photoFile");
        var url = document.getElementById("url");
        photoFile.reset();
        url.setAttribute('value','');
    }
    function onchangeUrl()
    {
        var photoFile = document.getElementById("photoFile");
        var photoUrl = document.getElementById("photourl");
        photoFile.reset();
        photoUrl.setAttribute('value','');
    }


</script>