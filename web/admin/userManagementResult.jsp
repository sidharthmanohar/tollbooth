<%-- 
    Document   : userManagementResult
    Created on : 21 May, 2014, 8:50:39 AM
    Author     : Sidharth
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
        <title>User Management</title>
        <link href="../css/default.css" rel="stylesheet" type="text/css" media="all" />
        <link href="../css/fonts.css" rel="stylesheet" type="text/css" media="all" />    
        <link href="../css/jquery.datetimepicker.css" rel="stylesheet" type="text/css" />
        <jsp:include page="adminHeader.jsp"></jsp:include>
        <jsp:include page="adminMenu.jsp?menu=UserManagement"></jsp:include>           
        </head>

        <body>
            <div id="wrapper">
                <div id="page" class="pagebody-centre">
                    <h4><%=session.getAttribute("msg")%></h4>                                       
                </div>
            </div>

        </body>
    </html>

<%
    } else {
        response.sendRedirect("../RedirectUser");
    }
%>