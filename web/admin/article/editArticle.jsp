<%-- 
    Document   : editArticle
    Created on : Dec 21, 2021, 4:24:32 PM
    Author     : User
--%>

<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%> 
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        
        <link rel="stylesheet" href="../../css/page.css">
        <link rel="stylesheet" href="../../css/style.css">
        <script src="http://code.jquery.com/jquery-latest.js"></script>
        <link href="https://fonts.googleapis.com/css2?family=Pushster&display=swap" rel="stylesheet">
        <script>
            $(document).ready(function(){
                
                $("#refresh").load("../../header.jsp");
            setInterval(function(){
                  $("#refresh").load("../../header.jsp");
            }, 3000);
            });
            function apos(txt){
                         
                         txt.value = txt.value.toString().replace('\'','&#39;');
                         txt.value = txt.value.toString().replace('\"','&#39;');
                         txt.value = txt.value.toString().replace('\“','&#39;');
                         txt.value = txt.value.toString().replace('\‘','&#39;');
                         txt.value = txt.value.toString().replace('\”','&#39;');
                         txt.value = txt.value.toString().replace('\’','&#39;');
                        
            }
            function li12(){
                
                document.getElementById("li1-2").style.display="block";
                document.getElementById("ul1-2").disabled=false;   
            }
            function li13(){
                document.getElementById("li1-3").style.display="block";
                document.getElementById("ul1-3").disabled=false;   
            }
            function li14(){
                document.getElementById("li1-4").style.display="block";
                document.getElementById("ul1-4").disabled=false;   
            }
            function li15(){
                document.getElementById("li1-5").style.display="block";
                document.getElementById("ul1-5").disabled=false;   
            }
            function li16(){
                document.getElementById("li1-6").style.display="block";
                document.getElementById("ul1-6").disabled=false;   
            }
            function li17(){
                document.getElementById("li1-7").style.display="block";
                document.getElementById("ul1-7").disabled=false;   
            }
            function li18(){
                document.getElementById("li1-8").style.display="block";
                document.getElementById("ul1-8").disabled=false;   
            }
            function para2(){
                document.getElementById("subdiv2").style.display="block";
                document.getElementById("paradiv2").style.display="block";
                document.getElementById("li2-1").style.display="block";
                document.getElementById("subtitle2").disabled=false;
                document.getElementById("body2").disabled=false;
                document.getElementById("ul2-1").disabled=false;
                document.getElementById("btndiv2").style.display="block";
            }
            
            function li22(){
                document.getElementById("li2-2").style.display="block";
                document.getElementById("ul2-2").disabled=false;   
            }
            function li23(){
                document.getElementById("li2-3").style.display="block";
                document.getElementById("ul2-3").disabled=false;   
            }
            function li24(){
                document.getElementById("li2-4").style.display="block";
                document.getElementById("ul2-4").disabled=false;   
            }
            function li25(){
                document.getElementById("li2-5").style.display="block";
                document.getElementById("ul2-5").disabled=false;   
            }
            function li26(){
                document.getElementById("li1-6").style.display="block";
                document.getElementById("ul1-6").disabled=false;   
            }
            function li27(){
                document.getElementById("li2-7").style.display="block";
                document.getElementById("ul2-7").disabled=false;   
            }
            function li28(){
                document.getElementById("li2-8").style.display="block";
                document.getElementById("ul2-8").disabled=false;   
            }
            function para3(){
                document.getElementById("subdiv3").style.display="block";
                document.getElementById("paradiv3").style.display="block";
                document.getElementById("li3-1").style.display="block";
                document.getElementById("subtitle3").disabled=false;
                document.getElementById("body3").disabled=false;
                document.getElementById("ul3-1").disabled=false;
                document.getElementById("btndiv3").style.display="block";
            }
            
            function li32(){
                document.getElementById("li3-2").style.display="block";
                document.getElementById("ul3-2").disabled=false;   
            }
            function li33(){
                document.getElementById("li3-3").style.display="block";
                document.getElementById("ul3-3").disabled=false;   
            }
            function li34(){
                document.getElementById("li3-4").style.display="block";
                document.getElementById("ul3-4").disabled=false;   
            }
            function li35(){
                document.getElementById("li3-5").style.display="block";
                document.getElementById("ul3-5").disabled=false;   
            }
            function li36(){
                document.getElementById("li3-6").style.display="block";
                document.getElementById("ul3-6").disabled=false;   
            }
            function li37(){
                document.getElementById("li3-7").style.display="block";
                document.getElementById("ul3-7").disabled=false;   
            }
            function li38(){
                document.getElementById("li3-8").style.display="block";
                document.getElementById("ul3-8").disabled=false;   
            }
            function para4(){
                document.getElementById("subdiv4").style.display="block";
                document.getElementById("paradiv4").style.display="block";
                document.getElementById("li4-1").style.display="block";
                document.getElementById("subtitle4").disabled=false;
                document.getElementById("body4").disabled=false;
                document.getElementById("ul4-1").disabled=false;
                document.getElementById("btndiv4").style.display="block";
            }
            
            function li42(){
                document.getElementById("li4-2").style.display="block";
                document.getElementById("ul4-2").disabled=false;   
            }
            function li43(){
                document.getElementById("li4-3").style.display="block";
                document.getElementById("ul4-3").disabled=false;   
            }
            function li44(){
                document.getElementById("li4-4").style.display="block";
                document.getElementById("ul4-4").disabled=false;   
            }
            function li45(){
                document.getElementById("li4-5").style.display="block";
                document.getElementById("ul4-5").disabled=false;   
            }
            function li46(){
                document.getElementById("li4-6").style.display="block";
                document.getElementById("ul4-6").disabled=false;   
            }
            function li47(){
                document.getElementById("li4-7").style.display="block";
                document.getElementById("ul4-7").disabled=false;   
            }
            function li48(){
                document.getElementById("li4-8").style.display="block";
                document.getElementById("ul4-8").disabled=false;   
            }
            function para5(){
                document.getElementById("subdiv5").style.display="block";
                document.getElementById("paradiv5").style.display="block";
                document.getElementById("li5-1").style.display="block";
                document.getElementById("subtitle5").disabled=false;
                document.getElementById("body5").disabled=false;
                document.getElementById("ul5-1").disabled=false;
                document.getElementById("btndiv5").style.display="block";
            }
            
            function li52(){
                document.getElementById("li5-2").style.display="block";
                document.getElementById("ul5-2").disabled=false;   
            }
            function li53(){
                document.getElementById("li5-3").style.display="block";
                document.getElementById("ul5-3").disabled=false;   
            }
            function li54(){
                document.getElementById("li5-4").style.display="block";
                document.getElementById("ul5-4").disabled=false;   
            }
            function li55(){
                document.getElementById("li5-5").style.display="block";
                document.getElementById("ul5-5").disabled=false;   
            }
            function li56(){
                document.getElementById("li5-6").style.display="block";
                document.getElementById("ul5-6").disabled=false;   
            }
            function li57(){
                document.getElementById("li5-7").style.display="block";
                document.getElementById("ul5-7").disabled=false;   
            }
            function li58(){
                document.getElementById("li5-8").style.display="block";
                document.getElementById("ul5-8").disabled=false;   
            }
        </script>
        <style>
            h1{
                font-size:30px;
                font-family: 'Pushster', cursive;
                color:#ff4500;
            }
            #content{
                margin-left:10%;
                margin-right:10%;
                font-size:20px;
                height:100%;
            }
            input { font-size: 20px; }
            textarea{
                font-sizee:30px;
                padding:10px;
            }
            input[type=submit]{
                padding:10px;
                background-color:#00b2ff;
                color:white;
                width:90px;
                border:1px solid white;
                font-size:20px;
            }
            button{
                padding:10px;
                background-color:#00b2ff;
                color:white;
                width:180px;
                border:1px solid white;
                font-size:20px;
            }
            table,th,tr,td{
                border:none;
            }
            th{
                text-align:left;
            }
            th,td{
                padding:5px;
            }
            #subtitle{
                color:green;
                font-weight: bold;
                font-size:24px;
                
            }
        </style>
    </head>
    <body>
        
            <%if(session.getAttribute("usertype")==null){%>
            <script>alert('Please Login First');location.href='/TotoroEmergencyMedical/login.jsp';</script>
                <%
            }else if(!session.getAttribute("usertype").equals("admin")){%>
            <script>alert('Only Admin can access');location.href='/TotoroEmergencyMedical/login.jsp'</script>
            <%}else if(request.getParameter("id")==null){
                response.sendRedirect("viewArticle.jsp");
            }else{
                
                String q=request.getParameter("name");
                String driver="com.mysql.jdbc.Driver";           
                String dbName="totoro";
                String url="jdbc:mysql://localhost/"+dbName+"?";
                String userName="root";
                String password="";
                String id=request.getParameter("id");
                String query="SELECT*FROM `article` where `id`="+id; 

                Class.forName(driver);
                Connection con=DriverManager.getConnection(url,userName,password);
                Statement st=con.createStatement();
                ResultSet rs=st.executeQuery(query);
                rs.next();
                
            %>
       <div id="refresh"></div>
       <div id="content">
        <h1>Edit Article</h1>&nbsp;&nbsp;&nbsp;&nbsp;
        <form action='/TotoroEmergencyMedical/articleController' method='post' >
            <input type='hidden' name='action' value='edit'>
            <input type="hidden" name="id" value="<%=String.valueOf(rs.getInt("id"))%>">
            <table>
                <tr>
                    <th>Title</th>
                    <td><input type="text" name="title" value="<%=rs.getString("title")%>"></td>
                </tr>
                <tr>
                    <th>Image Link</th>
                    <td><input type="text" name="photo" value="<%=rs.getString("photo")%>" id="img"> &nbsp;<button type="button" onclick="changeImage()">Change Image</button></td>
                </tr>
            </table>
        
        
        <p><img id="image" src="<%=rs.getString("photo")%>" width="200px"></p>
        
        <%
            String []subtitle={"","","","",""}; 
            String []body={"","","","",""};
            String li[][]=new String[5][8];
            String temp1="",temp2="",temp3="",temp4="",temp5="";
            for(int a=0;a<5;a++){
                for(int w=0;w<8;w++){
                    li[a][w]="";
                }
            }
            String []para={"","","","",""};
            int []licnt={0,0,0,0,0};
            boolean []pExist={false,false,false,false,false};
            
            for(int i=0; i<5; i++){
                para[i]=rs.getString("para"+(i+1));
                
                if(!para[i].isEmpty()){
                    pExist[i]=true;
                     if(para[i].indexOf("</b>")!=-1){
                         subtitle[i]=para[i].substring(para[i].indexOf("<b>")+3,para[i].indexOf("</b>"));
                         para[i]=para[i].substring(para[i].indexOf("</b>")+12);
                     }
                 } 
                if(!para[i].isEmpty()){
                    if(para[i].indexOf("</p>")!=-1){
                        body[i]=para[i].substring(para[i].indexOf("<p>")+3,para[i].indexOf("</p>"));
                        body[i]=body[i].replaceAll("&#39;", "apos");
                        para[i]=para[i].substring(para[i].indexOf("</p>")+12);
                    }
                }
                if(!para[i].isEmpty()){
                    if(para[i].indexOf("<ul>")!=-1){
                        for(int j=0; j<8; j++){
                            if(para[i].indexOf("<li>")!=-1){
                                li[i][j]=para[i].substring(para[i].indexOf("<li>")+4,para[i].indexOf("</li>"));
                                para[i]=para[i].substring(para[i].indexOf("</li>")+5);
                                licnt[i]+=1;
                            }
                        }
                       
                    }
                }
                
            }
  
        %>
        <%--for(int i=0; i<5;i++){
            out.println(subtitle[i]);
            out.println();
            out.println(body[i]);
            out.println();
            for(int j=0; j<8; j++){
                if(!li[i][j].isEmpty()){
                    out.println("ahhh");
                    out.println();
                }
            }
            out.println(String.valueOf(licnt[i]));
            out.println();
            out.println(pExist[i]);
        
        }--%>
        
        <br>
        <p id="subtitle">Body</p>
        <br>
        <div id="subdiv1">Paragraph 1<br><br>Subtitle: <input type="text" id="subtitle1" name="subtitle1" value="<%=subtitle[0]%>" style="color:grey; font-size:18px;padding:5px;" onkeyup="apos(this)"><br><br></div>
        <div id="paradiv1">Body of Paragraph 1: <textarea id="body1" name="body1" rows="5" cols="100" style="color:grey; font-size:18px;padding:5px;" onkeyup="apos(this)"><%=body[0]%></textarea></div>
        <div id="li1-1">List:<br>Item 1: <input type="text" id="ul1-1" name="ul1-1" value="<%=li[0][0]%>" style="color:grey; font-size:18px;padding:5px;" onclick="li12()" onkeyup="apos(this)"><br><br></div>
        <div id="li1-2" >Item 2: <input type="text" id="ul1-2"name="ul1-2" value="<%=li[0][1]%>" style="color:grey; font-size:18px;padding:5px;" onclick="li13()" onkeyup="apos(this)"><br><br></div>
        <div id="li1-3" >Item 3: <input type="text" id="ul1-3" name="ul1-3" value="<%=li[0][2]%>" style="color:grey; font-size:18px;padding:5px;" onclick="li14()" onkeyup="apos(this)"><br><br></div>
        <div id="li1-4" >Item 4: <input type="text" id="ul1-4" name="ul1-4" value="<%=li[0][3]%>" style="color:grey; font-size:18px;padding:5px;" onclick="li15()" onkeyup="apos(this)"><br><br></div>
        <div id="li1-5" >Item 5: <input type="text" id="ul1-5" name="ul1-5" value="<%=li[0][4]%>" style="color:grey; font-size:18px;padding:5px;" onclick="li16()" onkeyup="apos(this)"><br><br></div>
        <div id="li1-6" >Item 6: <input type="text" id="ul1-6" name="ul1-6" value="<%=li[0][5]%>" style="color:grey; font-size:18px;padding:5px;" onclick="li17()" onkeyup="apos(this)"><br><br></div>
        <div id="li1-7" >Item 7: <input type="text" id="ul1-7" name="ul1-7" value="<%=li[0][6]%>" style="color:grey; font-size:18px;padding:5px;" onclick="li18()" onkeyup="apos(this)"><br><br></div>
        <div id="li1-8" >Item 8: <input type="text" id="ul1-8" name="ul1-8" value="<%=li[0][7]%>" style="color:grey; font-size:18px;padding:5px;" onkeyup="apos(this)"></div>
        <div id="btndiv1" style="display:none;"><input id="btn-para1" type="button" name="btn-para1" value="Add Paragraph 2" onclick="para2()"><br><br></div>
        <%if(pExist[1]==false){%>
        <script>
            document.getElementById("btndiv1").style.display="block";
        </script>
            
        <%}%>
        <br>
      
        <div id="subdiv2" style="display:none;">Paragraph 2<br><br>Subtitle: <input type="text" id="subtitle2" name="subtitle2" disabled="true" value="<%=subtitle[1]%>"style="color:grey; font-size:18px;padding:5px;" onkeyup="apos(this)"><br><br></div>
        <div id="paradiv2" style="display:none;">Body of Paragraph 2: <textarea id="body2" name="body2" rows="5" cols="100" disabled="true" style="color:grey; font-size:18px;padding:5px;" onkeyup="apos(this)"><%=body[1]%></textarea></div>
        <div id="li2-1" style="display:none;">List:<br>Item 1: <input type="text" id="ul2-1" name="ul2-1" disabled="true" value="<%=li[1][0]%>"style="color:grey; font-size:18px;padding:5px;" onclick="li22()" onkeyup="apos(this)"><br><br></div>
        <div id="li2-2" style="display:none;">Item 2: <input type="text" id="ul2-2" name="ul2-2"  disabled="true" value="<%=li[1][1]%>" style="color:grey; font-size:18px;padding:5px;" onclick="li23()" onkeyup="apos(this)"><br><br></div>
        <div id="li2-3" style="display:none;">Item 3: <input type="text" id="ul2-3" name="ul2-3"  disabled="true" value="<%=li[1][2]%>" style="color:grey; font-size:18px;padding:5px;" onclick="li24()" onkeyup="apos(this)"><br><br></div>
        <div id="li2-4" style="display:none;">Item 4: <input type="text" id="ul2-4" name="ul2-4"  disabled="true" value="<%=li[1][3]%>" style="color:grey; font-size:18px;padding:5px;" onclick="li25()" onkeyup="apos(this)"><br><br></div>
        <div id="li2-5" style="display:none;">Item 5: <input type="text" id="ul2-5" name="ul2-5"  disabled="true" value="<%=li[1][4]%>" style="color:grey; font-size:18px;padding:5px;" onclick="li26()" onkeyup="apos(this)"><br><br></div>
        <div id="li2-6" style="display:none;">Item 6: <input type="text" id="ul2-6" name="ul2-6"  disabled="true" value="<%=li[1][5]%>" style="color:grey; font-size:18px;padding:5px;" onclick="li27()" onkeyup="apos(this)"><br><br></div>
        <div id="li2-7" style="display:none;">Item 7: <input type="text" id="ul2-7" name="ul2-7"  disabled="true" value="<%=li[1][6]%>" style="color:grey; font-size:18px;padding:5px;" onclick="li28()" onkeyup="apos(this)"><br><br></div>
        <div id="li2-8" style="display:none;">Item 8: <input type="text" id="ul2-8" name="ul2-8"  disabled="true" value="<%=li[1][7]%>" style="color:grey; font-size:18px;padding:5px;" onkeyup="apos(this)"></div>
        <div id="btndiv2" style="display:none;"><input type="button" id="btn-para2" name="btn-para2" value="Add Paragraph 3" onclick="para3()"><br><br></div>
        <%if(pExist[1]==true){%>
            <script>
                document.getElementById("subdiv2").style.display="block";
                document.getElementById("subtitle2").disabled=false;
                document.getElementById("paradiv2").style.display="block";
                document.getElementById("body2").disabled=false;
                document.getElementById("li2-1").style.display="block";
                document.getElementById("ul2-1").disabled=false;
                document.getElementById("li2-2").style.display="block";
                document.getElementById("ul2-2").disabled=false;
                document.getElementById("li2-3").style.display="block";
                document.getElementById("ul2-3").disabled=false;
                document.getElementById("li2-4").style.display="block";
                document.getElementById("ul2-4").disabled=false;
                document.getElementById("li2-5").style.display="block";
                document.getElementById("ul2-5").disabled=false;
                document.getElementById("li2-6").style.display="block";
                document.getElementById("ul2-6").disabled=false;
                document.getElementById("li2-7").style.display="block";
                document.getElementById("ul2-7").disabled=false;
                document.getElementById("li2-8").style.display="block";
                document.getElementById("ul2-8").disabled=false;
            </script>
        <%}%>
        <%if(pExist[2]==false){%>
        <script>
            document.getElementById("btndiv2").style.display="block";
        </script>  
        <%}%>
        <br>
        
        <div id="subdiv3" style="display:none;">Paragraph 3<br><br>Subtitle: <input type="text" id="subtitle3" name="subtitle3" disabled="true" value="<%=subtitle[2]%>" style="color:grey; font-size:18px;padding:5px;" onkeyup="apos(this)"><br><br></div>
        <div id="paradiv3" style="display:none;">Body of Paragraph 3: <textarea id="body3" name="body3" rows="5" cols="100" disabled="true" style="color:grey; font-size:18px;padding:5px;" onkeyup="apos(this)"><%=body[2]%></textarea></div>
        <div id="li3-1" style="display:none;">List:<br>Item 1: <input type="text" id="ul3-1" name="ul3-1" disabled="true" value="<%=li[2][0]%>" style="color:grey; font-size:18px;padding:5px;" onclick="li32()" onkeyup="apos(this)"><br><br></div>
        <div id="li3-2" style="display:none;">Item 2: <input type="text" id="ul3-2" name="ul3-2"  disabled="true" value="<%=li[2][1]%>" style="color:grey; font-size:18px;padding:5px;" onclick="li33()" onkeyup="apos(this)"><br><br></div>
        <div id="li3-3" style="display:none;">Item 3: <input type="text" id="ul3-3" name="ul3-3"  disabled="true" value="<%=li[2][2]%>" style="color:grey; font-size:18px;padding:5px;" onclick="li34()" onkeyup="apos(this)"><br><br></div>
        <div id="li3-4" style="display:none;">Item 4: <input type="text" id="ul3-4" name="ul3-4"  disabled="true"  value="<%=li[2][3]%>"style="color:grey; font-size:18px;padding:5px;" onclick="li35()" onkeyup="apos(this)"><br><br></div>
        <div id="li3-5" style="display:none;">Item 5: <input type="text" id="ul3-5" name="ul3-5"  disabled="true" value="<%=li[2][4]%>" style="color:grey; font-size:18px;padding:5px;" onclick="li36()" onkeyup="apos(this)"><br><br></div>
        <div id="li3-6" style="display:none;">Item 6: <input type="text" id="ul3-6" name="ul3-6"  disabled="true" value="<%=li[2][5]%>" style="color:grey; font-size:18px;padding:5px;" onclick="li37()" onkeyup="apos(this)"><br><br></div>
        <div id="li3-7" style="display:none;">Item 7: <input type="text" id="ul3-7" name="ul3-7"  disabled="true" value="<%=li[2][6]%>" style="color:grey; font-size:18px;padding:5px;" onclick="li38()" onkeyup="apos(this)"><br><br></div>
        <div id="li3-8" style="display:none;">Item 8: <input type="text" id="ul3-8" name="ul3-8"  disabled="true" value="<%=li[2][7]%>" style="color:grey; font-size:18px;padding:5px;" onkeyup="apos(this)"></div>
        <div id="btndiv3" style="display:none;"><input type="button" id="btn-para3" name="btn-para3" value="Add Paragraph 4" onclick="para4()"><br><br></div>
        <%if(pExist[2]==true){%>
            <script>
                document.getElementById("subdiv3").style.display="block";
                document.getElementById("subtitle3").disabled=false;
                document.getElementById("paradiv3").style.display="block";
                document.getElementById("body3").disabled=false;
                document.getElementById("li3-1").style.display="block";
                document.getElementById("ul3-1").disabled=false;
                document.getElementById("li3-2").style.display="block";
                document.getElementById("ul3-2").disabled=false;
                document.getElementById("li3-3").style.display="block";
                document.getElementById("ul3-3").disabled=false;
                document.getElementById("li3-4").style.display="block";
                document.getElementById("ul3-4").disabled=false;
                document.getElementById("li3-5").style.display="block";
                document.getElementById("ul3-5").disabled=false;
                document.getElementById("li3-6").style.display="block";
                document.getElementById("ul3-6").disabled=false;
                document.getElementById("li3-7").style.display="block";
                document.getElementById("ul3-7").disabled=false;
                document.getElementById("li3-8").style.display="block";
                document.getElementById("ul3-8").disabled=false;
            </script>
        <%}if(pExist[3]==false){%>
        <script>
            document.getElementById("btndiv3").style.display="block";
        </script>      
        <%}%>
        <br>
        
        <div id="subdiv4" style="display:none;">Paragraph 4<br><br>Subtitle: <input type="text" id="subtitle4" name="subtitle4" disabled="true" value="<%=subtitle[3]%>" style="color:grey; font-size:18px;padding:5px;" onkeyup="apos(this)"><br><br></div>
        <div id="paradiv4" style="display:none;">Body of Paragraph 4: <textarea id="body4" name="body4" rows="5" cols="100" disabled="true" style="color:grey; font-size:18px;padding:5px;" onkeyup="apos(this)"><%=body[3]%></textarea></div>
        <div id="li4-1" style="display:none;">List:<br>Item 1: <input type="text" id="ul4-1" name="ul4-1" disabled="true" value="<%=li[3][0]%>" style="color:grey; font-size:18px;padding:5px;" onclick="li42()" onkeyup="apos(this)"><br><br></div>
        <div id="li4-2" style="display:none;">Item 2: <input type="text" id="ul4-2" name="ul4-2"  disabled="true" value="<%=li[3][1]%>" style="color:grey; font-size:18px;padding:5px;" onclick="li43()" onkeyup="apos(this)"><br><br></div>
        <div id="li4-3" style="display:none;">Item 3: <input type="text" id="ul4-3" name="ul4-3"  disabled="true" value="<%=li[3][2]%>" style="color:grey; font-size:18px;padding:5px;" onclick="li44()" onkeyup="apos(this)"><br><br></div>
        <div id="li4-4" style="display:none;">Item 4: <input type="text" id="ul4-4" name="ul4-4"  disabled="true" value="<%=li[3][3]%>" style="color:grey; font-size:18px;padding:5px;" onclick="li45()" onkeyup="apos(this)"><br><br></div>
        <div id="li4-5" style="display:none;">Item 5: <input type="text" id="ul4-5" name="ul4-5"  disabled="true" value="<%=li[3][4]%>" style="color:grey; font-size:18px;padding:5px;" onclick="li46()" onkeyup="apos(this)"><br><br></div>
        <div id="li4-6" style="display:none;">Item 6: <input type="text" id="ul4-6" name="ul4-6"  disabled="true" value="<%=li[3][5]%>" style="color:grey; font-size:18px;padding:5px;" onclick="li47()" onkeyup="apos(this)"><br><br></div>
        <div id="li4-7" style="display:none;">Item 7: <input type="text" id="ul4-7" name="ul4-7"  disabled="true" value="<%=li[3][6]%>" style="color:grey; font-size:18px;padding:5px;" onclick="li48()" onkeyup="apos(this)"><br><br></div>
        <div id="li4-8" style="display:none;">Item 8: <input type="text" id="ul4-8" name="ul4-8"  disabled="true" value="<%=li[3][7]%>" style="color:grey; font-size:18px;padding:5px;" onkeyup="apos(this)"></div>
        <div id="btndiv4" style="display:none;"><input type="button" id="btn-para4" name="btn-para4" value="Add Paragraph 5" onclick="para5()"><br><br></div>
        <%if(pExist[3]==true){%>
            <script>
                document.getElementById("subdiv4").style.display="block";
                document.getElementById("subtitle4").disabled=false;
                document.getElementById("paradiv4").style.display="block";
                document.getElementById("body4").disabled=false;
                document.getElementById("li4-1").style.display="block";
                document.getElementById("ul4-1").disabled=false;
                document.getElementById("li4-2").style.display="block";
                document.getElementById("ul4-2").disabled=false;
                document.getElementById("li4-3").style.display="block";
                document.getElementById("ul4-3").disabled=false;
                document.getElementById("li4-4").style.display="block";
                document.getElementById("ul4-4").disabled=false;
                document.getElementById("li4-5").style.display="block";
                document.getElementById("ul4-5").disabled=false;
                document.getElementById("li4-6").style.display="block";
                document.getElementById("ul4-6").disabled=false;
                document.getElementById("li4-7").style.display="block";
                document.getElementById("ul4-7").disabled=false;
                document.getElementById("li4-8").style.display="block";
                document.getElementById("ul4-8").disabled=false;
            </script>
        <%}if(pExist[4]==false){%>
        <script>
            document.getElementById("btndiv4").style.display="block";
        </script>      
        <%}%>
        <br>
        
        <div id="subdiv5" style="display:none;">Paragraph 5<br><br>Subtitle: <input type="text" id="subtitle5" name="subtitle5" disabled="true" value="<%=subtitle[4]%>" style="color:grey; font-size:18px;padding:5px;" onkeyup="apos(this)"><br><br></div>
        <div id="paradiv5" style="display:none;">Body of Paragraph 5: <textarea id="body5" name="body5" rows="5" cols="100" disabled="true" style="color:grey; font-size:18px;padding:5px;" onkeyup="apos(this)"><%=body[4]%></textarea></div>
        <div id="li5-1" style="display:none;">List:<br>Item 1: <input type="text" id="ul5-1" name="ul5-1" disabled="true" value="<%=li[4][0]%>" style="color:grey; font-size:18px;padding:5px;" onclick="li52()" onkeyup="apos(this)"><br><br></div>
        <div id="li5-2" style="display:none;">Item 2: <input type="text" id="ul5-2" name="ul5-2"  disabled="true" value="<%=li[4][1]%>" style="color:grey; font-size:18px;padding:5px;" onclick="li53()" onkeyup="apos(this)"><br><br></div>
        <div id="li5-3" style="display:none;">Item 3: <input type="text" id="ul5-3" name="ul5-3"  disabled="true" value="<%=li[4][2]%>" style="color:grey; font-size:18px;padding:5px;" onclick="li54()" onkeyup="apos(this)"><br><br></div>
        <div id="li5-4" style="display:none;">Item 4: <input type="text" id="ul5-4" name="ul5-4"  disabled="true" value="<%=li[4][3]%>" style="color:grey; font-size:18px;padding:5px;" onclick="li55()" onkeyup="apos(this)"><br><br></div>
        <div id="li5-5" style="display:none;">Item 5: <input type="text" id="ul5-5" name="ul5-5"  disabled="true" value="<%=li[4][4]%>" style="color:grey; font-size:18px;padding:5px;" onclick="li56()" onkeyup="apos(this)"><br><br></div>
        <div id="li5-6" style="display:none;">Item 6: <input type="text" id="ul5-6" name="ul5-6"  disabled="true" value="<%=li[4][5]%>" style="color:grey; font-size:18px;padding:5px;" onclick="li57()" onkeyup="apos(this)"><br><br></div>
        <div id="li5-7" style="display:none;">Item 7: <input type="text" id="ul5-7" name="ul5-7"  disabled="true" value="<%=li[4][6]%>" style="color:grey; font-size:18px;padding:5px;" onclick="li58()" onkeyup="apos(this)"><br><br></div>
        <div id="li5-8" style="display:none;">Item 8: <input type="text" id="ul5-8" name="ul5-8"  disabled="true" value="<%=li[4][7]%>" style="color:grey; font-size:18px;padding:5px;" onkeyup="apos(this)"><br><br></div>
        <%if(pExist[4]==true){%>
            <script>
                document.getElementById("subdiv5").style.display="block";
                document.getElementById("subtitle5").disabled=false;
                document.getElementById("paradiv5").style.display="block";
                document.getElementById("body5").disabled=false;
                document.getElementById("li5-1").style.display="block";
                document.getElementById("ul5-1").disabled=false;
                document.getElementById("li5-2").style.display="block";
                document.getElementById("ul5-2").disabled=false;
                document.getElementById("li5-3").style.display="block";
                document.getElementById("ul5-3").disabled=false;
                document.getElementById("li5-4").style.display="block";
                document.getElementById("ul5-4").disabled=false;
                document.getElementById("li5-5").style.display="block";
                document.getElementById("ul5-5").disabled=false;
                document.getElementById("li5-6").style.display="block";
                document.getElementById("ul5-6").disabled=false;
                document.getElementById("li5-7").style.display="block";
                document.getElementById("ul5-7").disabled=false;
                document.getElementById("li5-8").style.display="block";
                document.getElementById("ul5-8").disabled=false;
            </script>
        <%}%>
     
        

        
        
        
        
        
        <input type="submit" value="submit">
        
        </form>
        </div>
        <jsp:include page="../../footer.jsp" /> 
    <script type="text/javascript">
        
        function changeImage(){
            var link=document.getElementById("img").value;
            
            document.getElementById("image").src = link;
        }
    </script>
    <%}%>
    </body>
</html>
