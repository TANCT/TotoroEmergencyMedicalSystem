<%-- 
    Document   : report
    Created on : Jan 28, 2022, 1:22:30 AM
    Author     : Asus
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Totoro Report</title>
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
                    String type=request.getParameter("type");
                    int id=Integer.parseInt(request.getParameter("id"));
                %>
                <div class="rating-hospital">
                    <h1>Report</h1>
                </div>
                <div class="rating-create" style="text-align: center">
                    <p>Please tell us more about the reason</p>
                    <br>
                    <form method="POST" action="../Report">
                        <input type="text" name="action" value="CREATE" hidden>
                        <input type="text" name="id" value="<%=id %>" hidden>
                        <input type="text" name="type" value="<%=type%>" hidden>
                        Please select a problem: 
                        <select name="problem" required>
                            <option selected disabled>Problem...</option>
                            <option value="Nudity">Nudity</option>
                            <option value="Violence">Violence</option>
                            <option value="Harassment">Harassment</option>
                            <option value="Suicide or Self-Injury">Suicide or Self Injury</option>
                            <option value="False Information">False Information</option>
                            <option value="Spam">Spam</option>
                            <option value="Unauthorized Sales">Unauthorized Sales</option>
                            <option value="Hate Speech">Hate Speech</option>
                            <option value="Terrorism">Terrorism</option>
                            <option value="Something Else">Something Else</option>
                        </select>
                        <br><br>
                        <textarea style="display: block;margin: auto;" name="description" class="comment" maxlength="8000" rows="4" cols="75" placeholder="Tell us more..." required></textarea>
                        <br>
                        
                        <div style="text-align: center">
                            <input class="rating-button" type="submit" value="Submit">
                            <button class="rating-button" ><a style="color: white;" href="javascript:history.back()">Cancel</a></button>
                        </div>
                    </form>
                </div>
            
        <%}%>
    </body>
</html>
