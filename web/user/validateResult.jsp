<%-- 
    Document   : validateResult
    Created on : 5 May, 2014, 7:33:58 PM
--%>
<%
    HttpSession currentSession = request.getSession(false);
    String user = (String) currentSession.getAttribute("userType");
    if (user != null && user.equals("user")) {
%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link href="../css/default.css" rel="stylesheet" type="text/css" media="all" />
        <link href="../css/fonts.css" rel="stylesheet" type="text/css" media="all" />      
        <jsp:include page="userHeader.jsp"></jsp:include>
        <jsp:include page="menu.jsp?menu=validate"></jsp:include>
        </head>
        <body>
            <div id="wrapper">
                <div id="page" class="pagebody-centre">
                <% if (request.getParameter("valid") != null) {
                        if (request.getParameter("valid").equals("true")) {
                %>
                <h3>The ticket is valid</h3>
                <% } else { %>
                <h3 style="color:#E60000"> The ticket is NOT valid</h3>
                <%
                    }
                } else {
                %>
                <h3 style="color:#E60000"> Please Retry</h3>
                    <% }%>
                    <br>
                    <br>
                    <a href="verifyBarcode.jsp"><button>Back</button></a>
                    
            </div>
        </div>
</html>

<%
    } else {
        response.sendRedirect("../RedirectUser");
    }
%>