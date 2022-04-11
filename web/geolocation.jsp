<%-- 
    Document   : geolocation
    Created on : Jan 19, 2022, 2:37:26 PM
    Author     : User
--%>

<%@page import="com.model.Hospital"%>
<%@page import="java.util.List"%>
<%@page import="com.model.HospitalData"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.Set"%>
<%@page import="java.util.TreeMap"%>
<%@page import="java.util.SortedMap"%>
<%@page import="java.util.SortedMap"%>
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
        <script src="http://code.jquery.com/jquery-latest.js"></script>
        <script> 
            $(document).ready(function(){
                $("#refresh").load("header.jsp");
            setInterval(function(){
                  $("#refresh").load("header.jsp");
            }, 3000);
            });
            
           </script>
    </head>
    <body>
        <%
            if(session.getAttribute("username")==null){
                response.sendRedirect("/TotoroEmergencyMedical/login.jsp");
            }else if(request.getParameter("lat")==null||request.getParameter("lon")==null){
                response.sendRedirect("/TotoroEmergencyMedical/index.jsp");
            }else{
                int count=0;
                
                List<Hospital> hospitalList=HospitalData.getHospitalList();
                Float currentLat=Float.parseFloat(request.getParameter("lat"));
                Float currentLon=Float.parseFloat(request.getParameter("lon"));
                SortedMap<Double, String> hospitals=new TreeMap<Double, String>();
               for(Hospital h:hospitalList){
                    Float lat=h.getLat();
                    Float lon=h.getLon();
                    double radlat1=0,radlat2=0,theta=0, radtheta=0,dist=0;
                    
                    if ((currentLat == lat) && (currentLon == lon)) {
                        dist=0;
                    }else {
                        radlat1 = Math.PI * currentLat / 180;
                        radlat2 = Math.PI * lat/ 180;
                        theta = currentLon - lon;
                        radtheta = Math.PI * theta / 180;

                        dist = Math.sin(radlat1) * Math.sin(radlat2) + Math.cos(radlat1) * Math.cos(radlat2) * Math.cos(radtheta);
                        if (dist > 1) {
                            dist = 1;
                        }
                        dist = Math.acos(dist);
                        dist = dist * 180 / Math.PI;
                        dist = dist * 60 * 1.1515;
                        dist = dist * 1.609344;
                        
                    }
                    hospitals.put(new Double(dist),h.getName()+"#"+h.getPhone());   
                    
                }
                Set result=hospitals.entrySet();
                Iterator i=result.iterator();

                
                
                
    %>
            <div id="refresh"></div>
            <div class="content" style="margin-left: 10%;margin-right:10%;background-color:#ace5ee;padding:5%;border-radius:8px;min-height:600px; height:auto; display:flex;flex-direction:column;align-content:center;">
                <h1 align="center" style="color:white;">Nearest Hospital</h1><br>
                <div style="border:1px solid white; border-radius:8px; padding:10px;display:flex;justify-content: center;align-content: center;background-color:white;min-height:400px;">
                <table style="border:1px solid white; border-radius:8px; border-collapse:collapse; width:90%;height:90%;">
                 <%while(i.hasNext()){
                    Map.Entry m=(Map.Entry)i.next();
                    Double dist=(Double)m.getKey();
                    String distance=String.format("%.2f",dist);
                    String namephone=(String)m.getValue();
                    String name=namephone.substring(0,namephone.indexOf("#"));
                    String phone=namephone.substring(namephone.indexOf("#")+1);
                    if(dist<=30||count<=10){
                 %>
                 
                 <tr style="width:100%;background-color:white; height:20px;" >
                     <td style="padding:10px;color:#0093af;"><%=name%> </td>
                     <td style="padding:10px;color:#0093af;"><%=distance%> km</td>
                     <td style="padding:10px;color:#0093af;"><a href="tel:<%=phone%>"><button style="background-color:yellow;padding:10px; border:yellow; border-radius:50%;min-width:40px;"><i class="fa fa-phone" style="font-size:20px;color:red;"></i></button></a></td>
                 </tr>
                 
                 <br>
                    
                 <%count++;}}%>
                 </table>
                </div>
            </div>
            
            
            <br>
            <ul></ul>
        <%}%>
    </body>
</html>
