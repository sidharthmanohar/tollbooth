<%-- 
    Document   : Error
    Created on : 5 May, 2014, 10:54:20 AM
    Author     : Sidharth
--%>
<%
    HttpSession currentSession = request.getSession(false);
    String user = (String)currentSession.getAttribute("userType");
    if (user != null && user.equals("user")  ) {   
%>
<html>
    <head>
        
        <link rel="shortcut icon" href="../images/Madurai_Corporation_logo.jpg">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Tollbooth</title>
        <link href="../css/default.css" rel="stylesheet" type="text/css" media="all" />
        <link href="../css/fonts.css" rel="stylesheet" type="text/css" media="all" />      
        <jsp:include page="userHeader.jsp"></jsp:include>
        <jsp:include page="menu.jsp?menu=issueticket"></jsp:include>
    </head>
    <body>
        <div id="wrapper">
            <div id="page" class="pagebody-centre">
                <h3 style="color:#E60000">An internal error has occured</h3>
                <br><br>
            </div>
        </div>
    </body>
</html>
<%
}else{
   response.sendRedirect("../RedirectUser");
}%>