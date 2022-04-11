<%-- 
    Document   : profile
    Created on : Dec 22, 2021, 10:04:55 PM
    Author     : Lim Sin Jie
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page import="com.model.user" %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Profile</title>
        <link type="stylesheet" href="css/style.css">
        <script src="http://code.jquery.com/jquery-latest.js"></script>
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
        <script>
            $(document).ready(function(){
                $("#refresh").load("header.jsp");
            setInterval(function(){
                  $("#refresh").load("header.jsp");
            }, 3000);
            });
        </script>
        <style>
            .top-buffer { 
                padding-top: 50px; 
            }
            .top{
                margin-top: 10px;
            }
            body{
                background-color: lightcyan;
            }
            h2{
                font-family: 'Noto Serif', serif;
                color:#00b2ff;
                font-size:60px;
                font-weight: bold;
            }
            #username{
                padding-left: 30px;
            }
        </style>
    </head>
    <body>
    <div id="refresh"></div>
    <div class="container bootstrap snippet">
        <div class="row top-buffer text-center" >
            <h2>Profile</h2>
        </div>
        <jsp:useBean id="user" class="com.model.user" scope="session" />
        <div class="row" >
            <div class="col-sm-4 text-center"><h1><jsp:getProperty name="user" property="name"/></h1></div>
        </div>
        <div class="row">
            <div class="col-sm-4">
            <div class="text-center"> 
              <c:choose>
                <c:when test="${user.profilepic ==null}">
                <img src="http://ssl.gstatic.com/accounts/ui/avatar_2x.png" class="avatar img-circle img-thumbnail" width="200" height="200">
                </c:when>
                <c:otherwise>
                <img src="img/${user.profilepic}" class="avatar img-circle img-thumbnail" width="200" height="200" alt="profile picture">
                </c:otherwise>
              </c:choose>
            </div></hr><br>
            <div class="panel panel-default top">
              <div class="panel-heading">Bio</div>
              <c:choose>
                <c:when test="${user.bio == null}">
                <div class="panel-body"></div>
                </c:when>
                <c:otherwise>
                <div class="panel-body"><jsp:getProperty name="user" property="bio"/></div>
                </c:otherwise>
              </c:choose>
            </div>        
            </div>
            
            <div class="col-sm-8">              
                <div class="form-group">  
                    <div class="col-xs-10">
                        <label for="name"><h4>Name</h4></label>
                        <jsp:getProperty name="user" property="name" />
                    </div>
                </div>
                <div class="form-group">
                    <div class="col-xs-10">
                        <label for="phone"><h4>Phone</h4></label>
                        <jsp:getProperty name="user" property="phone" />
                    </div>
                </div>
                <div class="form-group">
                    <div class="col-xs-10">
                        <label for="email"><h4>Email</h4></label>
                        <jsp:getProperty name="user" property="email" />
                    </div>
                </div>
                <div class="form-group">
                    <div class="col-xs-10">
                        <label for="password"><h4>Password</h4></label>
                        <jsp:getProperty name="user" property="password" />
                    </div>
                </div>
            <div class="form-group">
                <div class="col-xs-12">
                      <br>
                      <a class="btn btn-lg btn-success" href="editProfile.jsp"><i class="glyphicon glyphicon-edit"></i>  Edit</a>
                </div>
            </div>
        </div>
    </div>
            <% }
               st.close();
               con.close();
            }%> 
    <jsp:include page="footer.jsp" />
    </body>
</html>
