<%-- 
    Document   : index
    Created on : Dec 21, 2021, 6:23:49 PM
    Author     : User
--%>

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
        <link type="stylesheet" href="css/style.css">
        <link type="stylesheet" href="css/page.css">
        <script src="http://code.jquery.com/jquery-latest.js"></script>
        <link href="https://fonts.googleapis.com/css2?family=Pushster&display=swap" rel="stylesheet">
        <link href="https://fonts.googleapis.com/css2?family=Noto+Serif:ital@1&display=swap" rel="stylesheet">
        <script> 
            $(document).ready(function(){
                $("#refresh").load("header.jsp");
            setInterval(function(){
                  $("#refresh").load("header.jsp");
            }, 3000);
            });
            
           </script>
           <style>
               #content{
                   margin-left:100px;
                   margin-right:100px;
               }
               body{
                   background-color: lightcyan;
               }
               .article{
                    display:flex;
                    flex-wrap: wrap;
                }
                .article-item{
                    margin:10px;
                }
                h1{
                    font-size:60px;
                    font-family: 'Pushster', cursive;
                }
                .username{
                    
                    color:#cff800;
                }
                .username::before {
                    
                    
                    color:#fda50f;
                    content:"Welcome, ";
                }
                h2{
                    font-family: 'Noto Serif', serif;
                    color:#00b2ff;
                    font-size:40px;
                }
                h3{
                    font-size:24px;
                    color:#48aaad;
                }
                /*.readarticle{
                    padding:10px;
                    border-radius:20%;
                    background-color: #59788e;
                    color:white;
                    float:right;
                }*/
                .news{
                    display:flex;
                    flex-wrap: wrap;
                }
                .news-item{
                    margin:10px;
                }
                .location{
                    height:30px;
                    display:flex;
                    justify-content:center;
                    space-between:10px;
                }
                .locationText{
                    background-color: white;
                    width:400px;
                    border:1px solid black;
                    display:flex;
                    padding-left: 5px;
                    color:grey;
                }
                .shareBtn{
                    text-align: center;
                    display:flex;
                    background-color: red;
                    color:white;
                    border:1px solid black;
                    border-radius: 20px;
                    padding-left:15px;
                    padding-right:15px;
                }
           </style>
        
    </head>
    <body >
        <%
            String username=(String)session.getAttribute("username");
            int id=(Integer)session.getAttribute("userID");
            String usertype=(String)session.getAttribute("usertype");
        %>
        <div id="refresh"></div>
        <div id="content">
            <br><br>
            <h1><span class="username"><%=username%></span></h1>
         <%
            if(session.getAttribute("shareState").equals("Not sharing location")){
            %>
        <div class="location">
            <p class="locationText">You are not sharing your location now.</p>
            
            <a href="findFriend.jsp" class="shareBtn"> Share your location now </a>
        </div>
        <% }else{ %>
        <div class="location">
            <p class="locationText">You are sharing your location with your friends now.</p>
            
            <a href="/TotoroEmergencyMedical/sharingController?action=stop" class="shareBtn"> Stop sharing now </a>
        </div>
        <% }%><br><br>
        <br><br>
        
        <p><h2>Article</h2></p><br><br>
    <%
                String driver="com.mysql.jdbc.Driver";           
                String dbName="totoro";
                String url="jdbc:mysql://localhost/"+dbName+"?";
                String userName="root";
                String password="";

                String query="SELECT*FROM `article` ORDER BY `date` DESC LIMIT 5"; 

                Class.forName(driver);
                Connection con=DriverManager.getConnection(url,userName,password);
                Statement st=con.createStatement();
                ResultSet rs=st.executeQuery(query);
                
            %>
        
    
    <div class="article">
        <%while(rs.next()){%>
        <a href="admin/article/articlePage.jsp?id=<%=String.valueOf(rs.getInt("id"))%>">
        <div class="article-item" height="260px">
            
            <img src="<%=rs.getString("photo")%>" width="300px" height="220px">
            <h3 align="center" style="width:300px;"><%=rs.getString("title")%></h3>
        </div>
         </a>

        <%}%>
           
    </div>
    <%
                
        query="SELECT*FROM `news` ORDER BY `date` DESC LIMIT 5"; 

        Class.forName(driver);
        con=DriverManager.getConnection(url,userName,password);
        st=con.createStatement();
        rs=st.executeQuery(query);
                
    %>    
    <br><br>
    <p><h2>News</h2></p><br><br>
        
    <div class="news">
        <%while(rs.next()){%>
        <a href="admin/news/newsPage.jsp?id=<%=String.valueOf(rs.getInt("id"))%>">
        <div class="news-item" height="260px">
            
            <img src="<%=rs.getString("photo")%>" width="300px" height="220px">
            <h3 align="center" style="width:300px;"><%=rs.getString("title")%></h3>
        </div>
         </a>

        <%}%>
           
    </div>
        <br><br>
        
        </div>
        
        
        <jsp:include page="footer.jsp" />  
        <%}%>
    </body>
</html>
