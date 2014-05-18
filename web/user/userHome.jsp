<%-- 
    Document   : userHome
    Created on : Mar 12, 2014, 6:50:00 PM
    Author     : sidharth
--%>
<%-- 
    Document   : printTicket
    Created on : Mar 14, 2014, 5:06:20 PM
    Author     : sidharth
--%>
<%
    HttpSession currentSession = request.getSession(false);
    String user = (String) currentSession.getAttribute("userType");
    if (user != null && user.equals("user")) {
%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link href="../css/default.css" rel="stylesheet" type="text/css" media="all" />
        <link href="../css/fonts.css" rel="stylesheet" type="text/css" media="all" />      
    </head>
    <body>
        <div id="wrapper">
            <jsp:include page="userHeader.jsp"></jsp:include>
            <jsp:include page="menu.jsp?menu=home"></jsp:include>

                <div id="page" class="pagebody-centre">

                    <h3>Welcome</h3>
                    <div class="page-form">
                        <br><br>
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                        UserID&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;:<%=session.getAttribute("userID")%>
                    <br> <br>
                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    Toll Plaza&nbsp;&nbsp;&nbsp;:<%=session.getAttribute("tollPlazaName")%>
                    <br> <br>
                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    Booth No&nbsp;&nbsp;&nbsp;&nbsp;:<%=session.getAttribute("tollBoothNo")%>
                </div>
            </div>
        </div>
    </body>
</html>
<%
    } else {
        response.sendRedirect("../RedirectUser");
    }
%>
