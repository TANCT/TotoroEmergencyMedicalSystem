<%-- 
    Document   : trackAED
    Created on : Dec 22, 2021, 11:06:50 PM
    Author     : USER
--%>

<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Arrays"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<!DOCTYPE html>
<html>
  <head>
    <title>AED Locator</title>
    <script src='js/mapFunction.js'></script>
  </head>
  <body style="margin:auto auto; text-align: center;width:100%;">
    <jsp:include page="header.jsp" />  
    <h1>Welcome to tracking map!</h1>
    <h2>Let's find out where the nearest AED are!</h2>
    <br>
    
    <%
        
        
        String query="";
        String driver="com.mysql.jdbc.Driver";           
        String dbName="totoro";
        String url="jdbc:mysql://localhost/"+dbName+"?";
        String userName="root";
        String password="";
        Class.forName(driver);
        Connection con=DriverManager.getConnection(url,userName,password);
        query="SELECT `latitude` from `aed` WHERE `status`='Active'";
        Statement st=con.createStatement();
        ResultSet rs=st.executeQuery(query);
        ArrayList<String> latitudeList = new ArrayList<String>();
        int size=0;
        while(rs.next()){
            latitudeList.add(rs.getString(1));
        }
        
        ArrayList<String> longitudeList = new ArrayList<String>();
        String query1="";
        query1="SELECT `longitude` from `aed` WHERE `status`='Active'";
        Statement st1=con.createStatement();
        ResultSet rs1=st1.executeQuery(query1);
       while(rs1.next()){
            longitudeList.add(rs1.getString(1));
        }
        String query2="";
        query2="SELECT `id` from `aed` WHERE `status`='Active'";
        Statement st2=con.createStatement();
        ResultSet rs2=st2.executeQuery(query2);
        ArrayList<String> IDList = new ArrayList<String>();
        while(rs2.next()){
            IDList.add(rs2.getString(1));
        }
        st.close();
        st1.close();
        st2.close();
    %>
    
    <% 
        for(int k=0;k<IDList.size();k++){
    %>
        <div hidden id="itemName" name="itemName">
            <%= IDList.get(k) %>
        </div>
    <%
        }
        for(int i=0;i<latitudeList.size();i++){
    %>
        <p hidden name="itemLat"><%= latitudeList.get(i)%></p>   
    <%
        }
        for(int j=0;j<longitudeList.size();j++){
    %>
    
    <p hidden name="itemLon"><%= longitudeList.get(j)%></p>
    <%
        }
    %>
        <div id="map" style="width:800px;height:500px; margin:0 auto 0 auto;">
        <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyCF299Nac24chSlt35w2AVH1avYXu5fS-E&maps_ids=b7950cd711ebba94&callback=initMaps"></script>
    </div>
     <jsp:include page="footer.jsp" />  
  </body>
</html>
