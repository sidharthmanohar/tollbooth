<%-- 
    Document   : adminHome
    Created on : Mar 12, 2014, 6:50:21 PM
    Author     : sidharth
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
      
        <p>Session variable User Type is</p>
       <%= session.getAttribute("userType") %>
       <br>
       <p>Session variable userID is</p>
        <%= session.getAttribute("userID") %>                   
    </body>
</html>
