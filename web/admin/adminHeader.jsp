<%-- 
    Document   : adminHeader
    Created on : 6 Apr, 2014, 8:00:50 PM
    Author     : mari
--%>


<%@page import="java.util.Enumeration"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<html>
    <head>
        <%
            try {
                if (request.getSession(false) == null) {
                    response.sendRedirect("../login.jsp");
                }

                String temp = (String) session.getAttribute("userType");
                if (!temp.trim().equals("admin")) {
        %>
        <meta http-equiv="refresh" content="0; url=../login.jsp" />
        <%
            }
        } catch (Exception e) {

        %>
        <meta http-equiv="refresh" content="0; url=login.jsp" />
        <%    }
        %>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Admin Header</title>       

        <link href="css/default.css" rel="stylesheet" type="text/css" media="all" />
        <link href="css/fonts.css" rel="stylesheet" type="text/css" media="all" />         
    </head>

    <body>
        <div id="header-wrapper">
            <div id="header" class="container">
                <div id="logo">
                    <h1><a href="#">Tollbooth</a></h1>
                    <br><br>
                    <p>Madurai Corporation</p>
                </div>

            </div>
        </div>
    </body>
</html>

