<%-- 
    Document   : viewTariff
    Created on : 2 Jun, 2014, 1:22:32 PM
    Author     : Sidharth
--%>
<%
    HttpSession currentSession = request.getSession(false);
    String user = (String) currentSession.getAttribute("userType");
    if (user != null && user.equals("admin")) {
%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>       
        <link rel="shortcut icon" href="../images/Madurai_Corporation_logo.jpg">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Tariff Details</title>
        <link href="../css/default.css" rel="stylesheet" type="text/css" media="all" />
        <link href="../css/fonts.css" rel="stylesheet" type="text/css" media="all" />   
        <link href="../css/table.css" rel="stylesheet" type="text/css" media="all" />   
        <jsp:include page="adminHeader.jsp"></jsp:include>
        <jsp:include page="adminMenu.jsp?menu=Tariff"></jsp:include>

        </head>

        <body>
            <div id="wrapper">
                <div id="page" class="pagebody-centre"> 
                    <center>
                        <h3>Tariff Details for <%=request.getAttribute("tollPlazaName")%>
                </center>

                <div id="print_content">
                    <center>
                        <br/>
                        <table>

                            <tr>
                                <td>Vehicle Type</td>
                                <td>:<%=request.getAttribute("vehicleType")%></td>
                            </tr>
                            <tr>
                                <td>&nbsp;</td>
                            </tr>
                            <tr>
                                <td>Pass Type</td>
                                <td>:<%=request.getAttribute("passType")%></td>
                            </tr>   
                            <tr>
                                <td>&nbsp;</td>
                            </tr>
                            <tr>
                                <td>Tariff as of Date</td>
                                <td>:<%=request.getAttribute("date")%></td>
                            </tr>   

                        </table>
                        <br>                           
                        <%String[][] fareDetail = (String[][]) request.getAttribute("fareDetail"); %>
                        <div class="CSSTableGenerator" style="width:700px;">
                            <table border=1>
                                <tr>

                                    <th>From</th>
                                    <th>To</th>   
                                    <th>Effect From</th>
                                    <th>Fare</th>

                                </tr>
                                <%for (int i = 0; i < fareDetail.length; i++) {%>
                                <tr>

                                    <td>
                                        <%= fareDetail[i][0]%>
                                    </td>
                                    <td>
                                        <%= fareDetail[i][1]%>
                                    </td>
                                    <td>
                                        <%= fareDetail[i][3]%>
                                    </td>
                                    <td>
                                        <%= fareDetail[i][2]%>
                                    </td>

                                </tr>
                                <%}%>
                            </table>


                    </center>
                </div>     
                <br><br>
                <a href="TariffMain"><button>back</button></a>        
            </div>
        </div>

    </body>

</html>

<%
    } else {
        response.sendRedirect("../RedirectUser");
    }
%>