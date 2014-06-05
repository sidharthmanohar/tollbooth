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
                    <center>
                        <h3>Verification Details</h3>
                        <br><br>
                        <table>
                            <tr>
                                <td>
                                    Ticket Number
                                </td>
                                <td>
                                    :<%= session.getAttribute("vTicketNo")%>
                            </td>                   
                        </tr>
                        <tr>
                            <td>
                                &nbsp;
                            </td>
                        </tr>
                        <tr>
                            <td>
                                Vehicle Number
                            </td>
                            <td>
                                :<%= session.getAttribute("vVehicleNo")%>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                &nbsp;
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <p>Status</p>

                            </td>
                            <td>
                                <% if (request.getParameter("valid") != null) {
                                        if (request.getParameter("valid").equals("true")) {
                                %>
                                <p style="color:#01A9DB">:VALID</p>
                                <% } else { %>
                                <p style="color:#E60000">:NOT VALID</p>
                                <%
                                    }
                                } else {
                                %>
                                <p style="color:#E60000">:Please try again</p>
                                <% }%>
                            </td>
                        </tr>
                    </table>
                </center>
                <a href="verifyBarcode.jsp"><button>Back</button></a>

            </div>
        </div>
</html>

<%
    } else {
        response.sendRedirect("../RedirectUser");
    }
%>