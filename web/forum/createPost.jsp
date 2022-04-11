<%-- 
    Document   : createPost
    Created on : Dec 23, 2021, 9:42:37 PM
    Author     : Asus
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Create Post</title>
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
                    <a href=""><h1>Forum</h1></a>
                </div>
                <div class="search">
                    <form action="../Forum" method="POST">
                        <input type="image" src="../images/search.png" alt="Submit" width="20" height="20">
                        <input type="text" name="searchKey" placeholder="Search something..." style="height: 25px;font-size: large;">
                    </form>
                </div>
                <div class="category">
                    <a href="../Forum">#All</a><br>
                    <a href="../Forum?category=Daily">#Daily</a><br>
                    <a href="../Forum?category=FirstAid">#FirstAid</a><br>
                    <a href="../Forum?category=HealthAndSafety">#HealthAndSafety</a><br>
                    <a href="../Forum?category=Medication">#Medication</a><br>
                    <a href="../Forum?category=Hospital">#Hospital</a><br>
                </div>
            </div>
            
            <div class="createPost">
                <div class="header">
                    <h1>Create Post</h1>
                </div>
                <h1 class='username'><%=session.getAttribute("username") %></h1>
                <!--form method="POST" action="../createPost" enctype="multipart/form-data"-->
                <form method="POST" action="../Forum">
                    <input type="text" name="action" value="CREATE" hidden>
                    <select name="category" class="category" required>
                        <option selected disabled>#Choose Topic</option>
                        <option value="Daily">#Daily</option>
                        <option value="FirstAid">#FirstAid</option>
                        <option value="HealthAndSafety">#HealthAndSafety</option>
                        <option value="Medication">#Medication</option>
                        <option value="Hospital">#Hospital</option>
                    </select>
                    <br>
                    <br>
                    <input type="text" name="subject" class="subject" maxlength="100" placeholder="What's the title of your sharing" required="">
                    <br>
                    <br>
                    <textarea name="description" class="description" maxlength="8000" rows="4" placeholder="Description" required></textarea>
                    <br>
                    <div class="attachment">
                        <b>Attach: </b>&nbsp;
                        <img src="../images/imageicon.png" alt="" width="20" height="20" onclick="insertImage()">&nbsp;&nbsp;
                        <img src="../images/urlicon.png" alt="" width="20" height="20" onclick="insertUrl()">&nbsp;&nbsp;
                        <input type = "hidden" id="photoFile" name ="image" size = "50" onclick="onchangePFile()" accept="image" hidden/>
                        <input type="hidden" id="photourl" name="photo" placeholder="insert the url of the photo here..." onclick="onchangePUrl()">
                        <input type="hidden" id="url" name="url" placeholder="Insert the url here..." onclick="onchangeUrl()">
                    </div>
                    <br>
                    <div class="create">
                        <input type="submit" value="Post">
                        <button><a href="Forum">Cancel</a></button>
                    </div>
                    
                </form>

            </div>
                <div class="right">
                
                    <%
                        String name=(String) session.getAttribute("username");
                        int id=(Integer) session.getAttribute("userID");
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

                            <button onclick="document.location='createPost.jsp'">Post something...</button>
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
