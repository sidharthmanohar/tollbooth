<%-- 
    Document   : reportMain
    Created on : 20 May, 2014, 7:45:53 PM
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
        <title>Report</title>
        <link href="../css/default.css" rel="stylesheet" type="text/css" media="all" />
        <link href="../css/fonts.css" rel="stylesheet" type="text/css" media="all" />    
        <link href="../css/jquery.datetimepicker.css" rel="stylesheet" type="text/css" />
        <jsp:include page="adminHeader.jsp"></jsp:include>
        <jsp:include page="adminMenu.jsp?menu=report"></jsp:include> 
        </head>

        <body>
            <div id="wrapper">
                <div id="page" class="pagebody-centre">
                    <h3>Select the type of report</h3>
                    <br><br>
                    
                    <h3><a href="AdminHome" style="color:#0040FF">&nbsp;Daily Report</a> </h3>
                    <br>
                   <h3><a href="ReportForm" style="color:#0040FF">&nbsp;Specific Report</a> </h3>
                   <br>
                   <h3><a href="BankReport" style="color:#0040FF">&nbsp;Bank Report</a> </h3>
                    <div class="page-form">

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