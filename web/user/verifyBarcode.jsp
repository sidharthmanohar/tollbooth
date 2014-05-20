<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Iterator"%>

<%
    HttpSession currentSession = request.getSession(false);
    String user = (String) currentSession.getAttribute("userType");
    if (user != null && user.equals("user")) {
%>

<!DOCTYPE html>
<html>
    <head>
        <link rel="shortcut icon" href="../images/Madurai_Corporation_logo.jpg">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Verify Ticket</title>
        <link href="../css/default.css" rel="stylesheet" type="text/css" media="all" />
        <link href="../css/fonts.css" rel="stylesheet" type="text/css" media="all" />      
        <jsp:include page="userHeader.jsp"></jsp:include>
        <jsp:include page="menu.jsp?menu=validate"></jsp:include>
        </head>
        <body>
            <div id="wrapper">
                <div id="page" class="pagebody-centre">
                    <h3>Scan the barcode to verify</h3>
                    <br>
                    <br>
                    <form  method="post" action="VerifyTicket"> 
                        Barcode : <input type="password" name="barcode"/>      

                        <br><br>
                        <input type="submit" value="verify"> 

                    </form>

                    <br><br>
                    <h4>USER GUIDE:<br>Click on the textbox. Scan the barcode using barcode reader and click verify</h4>
                </div>
            </div>
    </html>

<%
    } else {
        response.sendRedirect("../RedirectUser");
    }
%>
