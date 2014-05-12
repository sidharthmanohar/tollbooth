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
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Login Page</title>       
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

            <div id="wrapper">
                <div id="page" class="pagebody-centre">
                    <h3 style="color:#E60000">An internal error occured </h3>
                    <h3 style="color:#E60000">Please try again later
                    </h3>
                    <br><br>
                </div>
            </div>

        </div>
    </body>
</html>

<%
    } else {
        response.sendRedirect("RedirectUser");
    }%>
