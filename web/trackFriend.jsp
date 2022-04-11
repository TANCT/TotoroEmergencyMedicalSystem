<%@page import="java.sql.*"%>
<!DOCTYPE html>
<html>
 <head>
      <title>Track Friend</title>
      <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
       <style><%@include file="css/friendMap.css" %></style>
       <script src="http://code.jquery.com/jquery-latest.js"></script>
        <script>
          getLocation();
            function getLocation() {
              if (navigator.geolocation) {
                navigator.geolocation.getCurrentPosition(showPosition);
              } 
            }

            function showPosition(position) {
              document.calculate.origin.value = position.coords.latitude + "," + position.coords.longitude;
              document.going.sendlocation.value=position.coords.latitude + "," + position.coords.longitude;
              
            }
           
            $(document).ready(function(){
                $("#refresh").load("header.jsp");
            setInterval(function(){
                  $("#refresh").load("header.jsp");
            }, 3000);
            });
           

        </script>
       
   </head>
    <%
        if(session.getAttribute("username")==null){
            response.sendRedirect("login.jsp");
        }else{
          String userID=String.valueOf(session.getAttribute("userID"));
        }
        String id=request.getParameter("id");
        String friend;
        int notiID = Integer.parseInt(id);
        String driver="com.mysql.jdbc.Driver";
            String dbName="totoro";
            String url="jdbc:mysql://localhost/"+dbName+"?";
            String userName="root";
            String password="";
            String query="";
            String query2,query3="";
            Class.forName(driver);//load and register driver
            Connection con=DriverManager.getConnection(url,userName,password);
            query="SELECT * FROM `notification` WHERE `id`="+notiID;
            Statement st=con.createStatement();
            ResultSet rs=st.executeQuery(query);
            while(rs.next()){
                friend = rs.getString("from");
                query2 = "SELECT * FROM `user` where `userid`="+friend;
                Statement st2=con.createStatement();
                ResultSet rs2=st2.executeQuery(query2);
                while(rs2.next()){
    %>
   
   <body style='margin: auto auto;'>
        <jsp:include page="header.jsp" />  
    <div class="header">
            <div class="row">
                <h1>Check out <%= rs2.getString("name") %> location !</h1>
            </div>
    </div>

    <div class="container" >
        <form name="calculate">
            <!-- Location 1 -->
            <div class="row">
                <div class="location-label">
                    <label>Your location: </label>                                    
                </div>
                <div class="location-input">
                    <input id="location-1" name="origin" placeholder="Enter a start location..."> 
                </div>
            </div>
            <!-- Location 2 -->
            <div class="row">
                <div class="location-label">
                    <label>Friend's location: </label>
                </div>
                <div class="location-input">
                    <input type="text" id="location-2" name="destination" placeholder="Enter a last location..."  value=<%= rs.getString("location") %>>
                </div>
            </div>
                <br>
                
            <!-- Submit button -->
            <div class="row">
                <button class="button" type="button" onclick="calcRoute();">Submit</button>
            </div>      
            
            <!-- Stats table -->                
            <div id="output" class="result-table"></div>
       </form>
                    
            <div class="container-map" id="google-map"></div>   
    </div>
                <div style="margin:0 auto 0 auto; text-align: center;">
            <form name='going' action="goToFriend" method="post" >
                <input hidden name="sendlocation">
                <input hidden name="friendID" value=<%= rs.getString("from") %>>
                <input class="button" type="submit" name="action" value="I'm Going" />
                <input class="button" type="submit" name="action" value="I Can't Go" />
            </form>
                </div>
                <% 
                    }
                }
query3 = "UPDATE `notification` SET `status`=? where `id`="+notiID;
PreparedStatement ps = con.prepareStatement(query3);
ps.setString(1,"read");
            ps.executeUpdate();
                %>
 <jsp:include page="footer.jsp" />  
  </body>
  <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyCF299Nac24chSlt35w2AVH1avYXu5fS-E&libraries=places"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
    <script src="js/trackFriend.js"></script>
</html>