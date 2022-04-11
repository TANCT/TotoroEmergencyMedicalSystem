<%-- 
    Document   : login
    Created on : Dec 21, 2021, 10:38:25 PM
    Author     : USER
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <script src="http://code.jquery.com/jquery-latest.js"></script>
        <title>Login</title>
        <link href="https://fonts.googleapis.com/css?family=Lato:300,400,700&display=swap" rel="stylesheet">

	<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
	
	
        <style>
            .content{
                margin: 0 auto 0 auto;
                display:flex;
                justify-content: center;
            } 
           .form{
                text-align: center;
                margin:auto auto;
                width: 50%;
                height:300px;
                border: 3px solid lightblue;
            }
            

.heading{
    padding:30px;
}

input{
    padding:10px;
    border-radius: 10px;
}
input:hover{
    background-color:lightcyan;
}
.inputBox{
    border:2px solid darkblue;
    padding:20px;
    border-radius: 20px;
    width:50%;
    margin:0 auto 0 auto;
}

.logo{
    height:90px;
}
        </style>
        
    </head>
    <body style="background: linear-gradient(90deg, #e3ffe7 0%, #d9e7ff 100%); text-align: center; padding:10px;">
        <%if(session.getAttribute("username")!=null){
            response.sendRedirect("index.jsp");
        }else{%>
        <div style="padding:20px;"><img src="images/totoro_logo.jpeg" class="logo"></div>
			<div class="row justify-content-center">
				<div class="col-md-6 text-center mb-2">
				
					<h1 class="heading-section"><b>Login</b></h1>
                                        
				</div>
			</div>
			
		      	<div class="icon d-flex align-items-center justify-content-center">
                            <br>
                                <i class="fa fa-user-circle fa-5x"></i>
		      	</div>
		      	<h3 class="text-center mb-4">Have an account?</h3>
                        <br>
            <form method= "post" action="loginServlet"><div class="col-lg-4">
        
        <div class="inputBox">
        <div class="form-group>">
                <label for="username">Username : </label><input class="form-control" type="text" name="username" placeholder="ABC123"><br>
        </div>
                    <br>
                    <br>
        <div class="form-group>">
                <label for="password">Password : </label><input class="form-control" type="password" name="password"><br>
        </div>
                    <br>
                    <i>Don't have an account? <a href="register.jsp">Click to Register!</a></i>
                    <br><br>
                    <div class="create"><input  type="submit" value="Login"></div>
                
        </div>
        </div>
        </form>
        </div>
        <jsp:include page="footer.jsp" />  
        <%}%>
    </body>
</html>
