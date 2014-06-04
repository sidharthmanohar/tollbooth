<%-- 
    Document   : issueTicket
    Created on : Mar 13, 2014, 7:27:43 PM
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
        <link rel="shortcut icon" href="../images/Madurai_Corporation_logo.jpg">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Issue Ticket</title>
        <link href="../css/default.css" rel="stylesheet" type="text/css" media="all" />
        <link href="../css/fonts.css" rel="stylesheet" type="text/css" media="all" />      
        <jsp:include page="userHeader.jsp"></jsp:include>
        <jsp:include page="menu.jsp?menu=issueticket"></jsp:include>           

            <script>

                window.onload = function populateDiv()
                {

                    var year = document.getElementById("year");
                    var d = new Date();
                    var showYear = d.getFullYear();
                    for (var i = 0; i < 2; i++)
                    {
                        var opt = document.createElement("option");
                        opt.value = showYear + i;
                        opt.innerHTML = showYear + i;
                        year.appendChild(opt);
                    }


                    var selects = document.getElementById("passType");
                    var selectedValue = selects.options[selects.selectedIndex].value;
                    var validityDiv = document.getElementById("validity");
                    if (selectedValue == 3) {
                        validityDiv.style.visibility = visibility = 'visible';

                    } else {
                        validityDiv.style.visibility = visibility = 'hidden';
                    }

                }




                function confirmSubmit() {

                    var input = document.getElementById("inputbox");
                    var value = input.value.replace(/\s/g, "");
                    if (value == "")
                    {
                        input.style.border = "2px solid red";
                        return false;
                    }

                    var answer = confirm("Once OK is clicked the operation cannot be cancelled.\nAre you sure you want to continue?");
                    if (answer == true)
                    {
                        return true;
                    }
                    else
                    {
                        return false;
                    }
                }


                function validityToggle() {
                    var selects = document.getElementById("passType");
                    var selectedValue = selects.options[selects.selectedIndex].value;// will gives u 2
                    var validityDiv = document.getElementById("validity");
                    if (selectedValue == 4) {
                        validityDiv.style.visibility = visibility = 'visible';

                    } else {
                        validityDiv.style.visibility = visibility = 'hidden';
                    }
                    return true;
                }

            </script>
        </head>
        <body>
            <div id="wrapper">   
                <div id="page" class="pagebody-centre">
                    <h3>Ticket Form</h3>
                    <br><br>
                    <form action="ProcessTicketForm" method="post">
                        <div class="page-form">
                            <table>
                                <tr>
                                    <td>
                                        &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                                    </td>
                                    <td>
                                        Destination
                                    </td>
                                    <td>:
                                        <select name="toDestination">            
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
                                <td>&nbsp;</td>
                            </tr>


                            <tr><td>
                                    &nbsp;
                                </td>
                                <td>
                                    Vehicle No
                                </td>

                                <td>:
                                    <input type="text" name="vehicleNo" id="inputbox"/> 
                                </td>
                            </tr>
                            <tr>
                                <td>&nbsp;</td>
                            </tr>
                            <tr>
                                <td>
                                    &nbsp;
                                </td>
                                <td>
                                    Vehicle Type
                                </td>
                                <td>:
                                    <select name="vehicleType">  
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
                                <td>&nbsp;</td>
                            </tr>
                            <tr>
                                <td>
                                    &nbsp;
                                </td>
                                <td>
                                    Pass Type
                                </td>
                                <td>:
                                    <select name="passType" id="passType" onchange="validityToggle()" >
                                        <%
                                            Iterator<String> passTypeId = ((List<String>) request.getAttribute("passTypeId")).iterator();
                                            Iterator<String> passType = ((List<String>) request.getAttribute("passType")).iterator();
                                            while (passTypeId.hasNext() && passType.hasNext()) {
                                        %> 

                                        <option value="<%=passTypeId.next()%>"><%=passType.next()%></option>
                                        <%}%> 
                                    </select>
                                </td>
                            </tr>
                            <tr>
                                <td>&nbsp;</td>
                            </tr>
                            <tr id="validity" style="visibility: hidden">
                                <td>
                                    &nbsp;
                                </td>
                                <td>
                                    Validity
                                </td>
                                <td>:
                                    <select name="month" id="month">
                                        <option value="0">Jan</option>
                                        <option value="1">Feb</option>
                                        <option value="2">Mar</option>
                                        <option value="3">Apr</option>
                                        <option value="4">May</option>
                                        <option value="5">Jun</option>
                                        <option value="6">Jul</option>
                                        <option value="7">Aug</option>
                                        <option value="8">Sep</option>
                                        <option value="9">Oct</option>
                                        <option value="10">Nov</option>
                                        <option value="11">Dec</option>                            
                                    </select>
                                    <select name="year" id="year">
                                    </select>
                                </td>
                            </tr>
                        </table>
                        <br>

                    </div>
                    <input type="submit" value="Issue Ticket" onclick="{
                                return confirmSubmit();
                            }"/>
                </form>
            </div>
        </div>
    </body>
</html>

<%
    } else {
        response.sendRedirect("../RedirectUser");
    }
%>
