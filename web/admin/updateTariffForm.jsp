<%-- 
    Document   : updateTariffForm
    Created on : 2 Jun, 2014, 2:06:45 PM
    Author     : Sidharth
--%>
<%
    HttpSession currentSession = request.getSession(false);
    String user = (String) currentSession.getAttribute("userType");
    if (user != null && user.equals("admin")) {
%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
 <%String[][] fareDetail = (String[][]) request.getAttribute("fareDetail"); %>
<html>
    <head>
        <link rel="shortcut icon" href="../images/Madurai_Corporation_logo.jpg">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Update Tariff</title>
        <link href="../css/default.css" rel="stylesheet" type="text/css" media="all" />
        <link href="../css/fonts.css" rel="stylesheet" type="text/css" media="all" />   
        <link href="../css/table.css" rel="stylesheet" type="text/css" media="all" />   
        <jsp:include page="adminHeader.jsp"></jsp:include>
        <jsp:include page="adminMenu.jsp?menu=Tariff"></jsp:include>

         <script>
                function validator()
                {
                    var count = 0;
                    for (var i = 0; i < <%=fareDetail.length%>; i++) {
                        var txtBox = "fareBox" + i;
                        var input = document.getElementById(txtBox);
                        var val = input.value;
                        var value = input.value.replace(/\s/g, "");
                        if (value == "" || isNaN(val))
                        {
                            input.style.border = "2px solid red";
                            count = count + 1;
                        } else {
                            input.style.border = "2px solid black";
                        }

                    }
                    if (count == 0) {
                        return true;
                    }
                    return false;
                }
            </script>
        </head>

        <body>
            <div id="wrapper">
                <div id="page" class="pagebody-centre"> 
                    <center>
                        <h3>Enter Tariff Details for <%=request.getAttribute("tollPlazaName")%>

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
                                <td>Effect from date</td>
                                <td>:<%=request.getAttribute("date")%></td>
                            </tr>   

                        </table>
                        <br>       
                        <form action="UpdateTariff" method="post">

                           
                            <div class="CSSTableGenerator" style="width:700px;">
                                <table border=1>
                                    <tr>

                                        <th>From</th>
                                        <th>To</th>                              
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
                                            <% String id = "id=\"fareBox"+i+"\""; %>
                                            <input type="text" name="fareBox<%=i%>" <%=id%> >
                                        </td>
                                    </tr>
                                    <%}%>
                                </table>
                                </div>
                                <br>
                                <input type="submit" value="Update Tariff"  onclick="return validator()">
                        </form>
                    </center>
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