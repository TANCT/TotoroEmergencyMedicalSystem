<%-- 
    Document   : addRating
    Created on : Dec 25, 2021, 10:08:32 PM
    Author     : Asus
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Totoro Rating</title>
        <style><%@include file="../css/style.css"%></style>
        <style><%@include file="../css/page.css"%></style>
        <style><%@include file="../css/rating.css"%></style>
        <style><%@include file="../css/forum.css"%></style>
        <script src="http://code.jquery.com/jquery-latest.js"></script>
        <script> $(document).ready(function(){
                
                $("#refresh").load("/TotoroEmergencyMedical/header.jsp");
            setInterval(function(){
                  $("#refresh").load("/TotoroEmergencyMedical/header.jsp");
            }, 3000);
            });</script>
        
    </head>
    <body>
        <% if(session.getAttribute("username")==null){ 
        
            response.sendRedirect("../login.jsp");
        
        }else{%>
         
            <div id="refresh"></div>
        <jsp:include page="../header.jsp" />
        
        <div class="container">
            
            <div class="rating-main">
                <% 
                    String hospitalName=request.getParameter("name");
                    int hospitalId=Integer.parseInt(request.getParameter("id"));
                %>
                <div class="rating-hospital">
                    <h1>Add Rating</h1>
                    <h1><%=hospitalName%></h1>
                </div>
                <div class="rating-create">
                    <h1 class='username'><%=session.getAttribute("username") %></h1>
                    <form method="POST" action="../Rating">
                        <input type="text" name="action" value="RATE" hidden>
                        <input type="text" name="hospitalId" value="<%=hospitalId %>" hidden>
                        <table>
                            <tr>
                                <th>
                                    Comfort:
                                </th>
                                <td>
                                    <select name="comfort" required>
                                        <option selected value="5">5</option>
                                        <option value="4">4</option>
                                        <option value="3">3</option>
                                        <option value="2">2</option>
                                        <option value="1">1</option>
                                    </select>
                                </td>
                            </tr>
                            <tr>
                                <th>
                                    Cleaniness:
                                </th>
                                <td>
                                    <select name="cleaniness" required>
                                        <option selected value="5">5</option>
                                        <option value="4">4</option>
                                        <option value="3">3</option>
                                        <option value="2">2</option>
                                        <option value="1">1</option>
                                    </select>
                                </td>
                            </tr>
                            <tr>
                                <th>
                                    Service:
                                </th>
                                <td>
                                    <select name="service" required>
                                        <option selected value="5">5</option>
                                        <option value="4">4</option>
                                        <option value="3">3</option>
                                        <option value="2">2</option>
                                        <option value="1">1</option>
                                    </select>
                                </td>
                            </tr>
                            <tr>
                                <th>
                                    Safety:
                                </th>
                                <td>
                                    <select name="safety" required>
                                        <option selected value="5">5</option>
                                        <option value="4">4</option>
                                        <option value="3">3</option>
                                        <option value="2">2</option>
                                        <option value="1">1</option>
                                    </select>
                                </td>
                            </tr>
                            <tr>
                                <th>
                                    Comment:
                                </th>
                                <td>
                                    <textarea name="comment" class="comment" maxlength="8000" rows="4" cols="75" placeholder="Write Something..." required></textarea>
                                </td>
                            </tr>
                            
                        </table>
                        <div style="text-align: center">
                            <input class="rating-button" type="submit" value="Add">
                            <button class="rating-button" ><a style="color: white;" href="../Rating">Cancel</a></button>
                        </div>
                    </form>
                </div>
            
        <%}%>
    </body>
</html>
