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

        <script>
            function goBack()
            {
                window.history.back()
            }
        </script>
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
                    <h3 style="color:#E60000">The server encountered an error processing the request.
                        <br><br>
                        Please try again, Sorry for the trouble.</h3>                
                    <br><br>
                    <input type="button" value="Back" onclick="goBack()">
                </div>
            </div>

        </div>
    </body>
</html>

<%
    } else {
        response.sendRedirect("RedirectUser");
    }%>
