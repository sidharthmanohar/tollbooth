<%-- 
    Document   : login
    Created on : Mar 12, 2014, 4:48:46 PM
    Author     : sidharth
--%>
<%
    HttpSession currentSession = request.getSession(false);
    if (currentSession.getAttribute("userType") == null) {   
%>
     
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <link rel="shortcut icon" href="images/Madurai_Corporation_logo.jpg">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Tollbooth</title>       
        <link href="css/login.css" rel="stylesheet" >        
        <link href="css/default.css" rel="stylesheet" type="text/css" media="all" />
        <link href="css/fonts.css" rel="stylesheet" type="text/css" media="all" />
    </head>

    <body>
        <div id="wrapper">
            <div id="header-wrapper">
                <div id="header" class="container">
                    <div id="logo">
                        <h1><a href="#">Tollbooth</a></h1>
                        <br><br>
                        <p>Madurai Corporation</p>
                    </div>                    
                </div>                
            </div>
            <div id="page" class="container">
                <section class="container">
                    <div class="login">
                        <h1>Login</h1>
                        <form method="post" action="CheckLoginServlet">
                            <p><input type="text" name="userID"  placeholder="Username"></p>
                            <p><input type="password" name="password"  placeholder="Password"></p>
                                <% if (request.getParameter("error") != null) {%>
                            <p style="color:#E60000"> Invalid username or password</p>
                            <%}%>
                            <p class="submit"><input type="submit" name="commit" value="Login"></p>
                        </form>
                    </div>    
                </section>
            </div>
        </div>
    </body>
</html>

<%
}else{
   response.sendRedirect("RedirectUser");
}%>
