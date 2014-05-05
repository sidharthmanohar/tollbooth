<%-- 
    Document   : userHome
    Created on : Mar 12, 2014, 6:50:00 PM
    Author     : sidharth
--%>

<%
    HttpSession currentSession = request.getSession(false);
    String user = (String) currentSession.getAttribute("userType");
    if (user != null && user.equals("user")) {
%>
<%@page import="java.util.List"%>
<%@page import="java.util.Iterator"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link href="../css/default.css" rel="stylesheet" type="text/css" media="all" />
        <link href="../css/fonts.css" rel="stylesheet" type="text/css" media="all" />      
        <jsp:include page="userHeader.jsp"></jsp:include>
        <jsp:include page="menu.jsp"></jsp:include>           
        </head>
        <body>
            <div id="wrapper">
                <div id="page" class="pagebody-centre">
                    <h3>Select TollPlaza</h3>
                    <br><br>

                    <form action="ProcessTollPlaza" method="post">
                        <select name="tollPlazaId">            
                        <%
                            Iterator<String> tollPlazaId = ((List<String>) request.getAttribute("tollPlazaId")).iterator();
                            Iterator<String> tollPlazaName = ((List<String>) request.getAttribute("tollPlazaName")).iterator();
                            while (tollPlazaId.hasNext() && tollPlazaName.hasNext()) {
                        %>
                        <option value="<%=tollPlazaId.next()%>"><%= tollPlazaName.next()%></option>
                        <%}%> 
                    </select>
                    <br><br>
                    <input type="submit" value="submit" onclick="return validator()"/>
            </div>
        </div>
    </body>
</html>

<%
    } else {
        response.sendRedirect("../RedirectUser");
    }%>
