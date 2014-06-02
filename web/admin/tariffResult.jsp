<%-- 
    Document   : chargeEntry
    Created on : 5 May, 2014, 4:06:20 PM
    Author     : priya p
--%>
<%
    HttpSession currentSession = request.getSession(false);
    String user = (String) currentSession.getAttribute("userType");
    if (user != null && user.equals("admin")) {
%>

<%@page import="java.util.List"%>
<%@page import="java.util.Iterator"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <link rel="shortcut icon" href="../images/Madurai_Corporation_logo.jpg">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Tariff</title>
        <link href="../css/default.css" rel="stylesheet" type="text/css" media="all" />
        <link href="../css/fonts.css" rel="stylesheet" type="text/css" media="all" />      
        <jsp:include page="adminHeader.jsp"></jsp:include>
        <jsp:include page="adminMenu.jsp?menu=Tariff"></jsp:include>           

        </head>

        <body>
            <div id="wrapper">
                <div id="page" class="pagebody-centre">

                <% if (request.getParameter("status") != null) {%>
                <h3>Tariff updated successfully</h3>
                <%} else {%>

                <h3 style="color:#E60000">Tariff NOT updated. Please try again.</h3>         
                <% }%>
            </div>
        </div>
    </body>

</html>

<%
    } else {
        response.sendRedirect("../RedirectUser");
    }
%>