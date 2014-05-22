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
        <link rel="shortcut icon" href="../images/Madurai_Corporation_logo.jpg">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Tollbooth</title>
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
                        <table>
                            <tr>
                                <td>
                                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                </td>
                                <td>
                                    UserID
                                </td>
                                <td>
                                    :&nbsp;<%=session.getAttribute("userID")%>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                &nbsp;
                            </td>
                        </tr>
                        <tr>
                            <td>
                                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                            </td>
                            <td>
                                Toll Gate
                            </td>
                            <td>
                                :&nbsp;<%=session.getAttribute("tollPlazaName")%>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                &nbsp;
                            </td>
                        </tr>
                        <tr>
                            <td>
                                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                            </td>
                            <td>
                                Booth No
                            </td>
                            <td>
                                :&nbsp;<%=session.getAttribute("tollBoothNo")%>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                &nbsp;
                            </td>
                        </tr>
                        <tr>
                            <td>
                                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                            </td>
                            <td>
                                Direction of traffic
                            </td>
                            <td>
                                :&nbsp;<%=session.getAttribute("direction")%>
                            </td>
                        </tr>
                    </table>

                </div>
                <br><br>
                <p style="color:#E60000">Note:<br>
                    If any of the detail is INCORRECT notify the administrator immediately <br>
                    and DO NOT ISSUE TICKET until corrections are made.
                </p>
            </div>
        </div>
    </body>
</html>
<%
    } else {
        response.sendRedirect("../RedirectUser");
    }
%>
