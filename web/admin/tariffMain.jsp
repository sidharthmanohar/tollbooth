<%-- 
    Document   : tariffMain
    Created on : 31 May, 2014, 9:48:29 AM
    Author     : Murali
--%>

<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
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
        <title>Tariff</title>
        <link href="../css/default.css" rel="stylesheet" type="text/css" media="all" />
        <link href="../css/fonts.css" rel="stylesheet" type="text/css" media="all" />    
        <link href="../css/jquery.datetimepicker.css" rel="stylesheet" type="text/css" />
        <jsp:include page="adminHeader.jsp"></jsp:include>
        <jsp:include page="adminMenu.jsp?menu=Tariff"></jsp:include>           

            <script>
                function validator()
                {
                    var count = 0;
                    for (var i = 1; i <= 2; i++) {
                        var txtBox = "inputbox" + i;
                        var input = document.getElementById(txtBox);
                        var value = input.value.replace(/\s/g, "");
                        if (value == "")
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
                    <h3>Tariff Details</h3>
                    <br><br>
                    <div class="page-form">
                        <form  method="post">
                            <table>
                                <tr>
                                    <td>
                                        Toll Plaza
                                    </td>   
                                    <td>
                                        &nbsp;:&nbsp;<select name="tollPlazaId">            
                                        <%
                                            Iterator<String> tollPlazaId = ((List<String>) request.getAttribute("tollPlazaId")).iterator();
                                            Iterator<String> tollPlazaName = ((List<String>) request.getAttribute("tollPlazaName")).iterator();
                                            while (tollPlazaId.hasNext() && tollPlazaName.hasNext()) {
                                        %>
                                        <option value="<%=tollPlazaId.next()%>"><%= tollPlazaName.next()%></option>
                                        <%}%> 
                                    </select>
                                </td>   
                            </tr>
                            <tr>
                                <td>
                                    &nbsp;
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    Vehicle Type
                                </td>

                                <td>
                                    &nbsp;:&nbsp;<select name="vehicleTypeId">  
                                        <%
                                            Iterator<String> vehicleTypeId = ((List<String>) request.getAttribute("vehicleTypeId")).iterator();
                                            Iterator<String> vehicleType = ((List<String>) request.getAttribute("vehicleType")).iterator();
                                            while (vehicleTypeId.hasNext() && vehicleType.hasNext()) {
                                        %>              
                                        <option value="<%= vehicleTypeId.next()%>"><%=vehicleType.next()%></option>
                                        <%}%> 
                                    </select>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    &nbsp;
                                </td>
                            </tr>
                         
                            <tr>
                                <td>
                                    Date*
                                </td>
                                <td>
                                    &nbsp;:&nbsp;<input type="date" name="date" id="inputbox1"/>
                                </td>
                            </tr>
                        </table>
                                    <h6>*View tariff as on date specified / <br>update tariff effect from date specified</h6>
                        <br>

                        <input type="submit" value="View Tariff" onclick="form.action = 'ViewTariff';"/>
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                        <input type="submit" value="Update Tariff" onclick="form.action = 'UpdateTariffForm';"/>
                </div>
            </div>
        </div>
        <script type="text/javascript" src="../js/jquery.js"></script>
        <script type="text/javascript" src="../js/jquery.datetimepicker.js"></script>
        <script type="text/javascript">
                            $('#inputbox1').datetimepicker({
                                timepicker: false,
                                formatDate: 'Y-m-d',
                                format: 'Y-m-d',
                                closeOnDateSelect: true,
                                value: '<%= new SimpleDateFormat("yyyy-MM-dd").format(new Date())%>'
                            });
        </script>
    </body>


</html>

<%
    } else {
        response.sendRedirect("../RedirectUser");
    }
%>