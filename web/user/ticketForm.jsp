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
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link href="../css/default.css" rel="stylesheet" type="text/css" media="all" />
        <link href="../css/fonts.css" rel="stylesheet" type="text/css" media="all" />      
        <jsp:include page="userHeader.jsp"></jsp:include>
        <jsp:include page="menu.jsp?menu=issueticket"></jsp:include>           

            <script>
                function validator()
                {
                    //this function validates only one check box
                    //put a for loop in here to check for each text box
                    //u could use a count and if count=0 then all boxes are filled
                    //even if u enter only spaces in the textbox this function will apprehend u!!!
                    var input = document.getElementById("inputbox");
                    var msgbox = document.getElementById("hiddendiv");
                    var value = input.value.replace(/\s/g, "");
                    if (value == "")
                    {
                        input.style.border = "2px solid red";
                        return false;
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
                    <div class="page-form">
                        <form action="ProcessTicketForm" method="post">
                            To&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;:
                            <select name="toDestination">            
                            <%
                                Iterator<String> tollPlazaId = ((List<String>) request.getAttribute("tollPlazaId")).iterator();
                                Iterator<String> tollPlazaName = ((List<String>) request.getAttribute("tollPlazaName")).iterator();
                                while (tollPlazaId.hasNext() && tollPlazaName.hasNext()) {
                            %>
                            <option value="<%=tollPlazaId.next()%>"><%= tollPlazaName.next()%></option>
                            <%}%> 
                        </select>

                        <br><br>
                        Vehicle Type: 
                        <select name="vehicleType">  
                            <%
                                Iterator<String> vehicleTypeId = ((List<String>) request.getAttribute("vehicleTypeId")).iterator();
                                Iterator<String> vehicleType = ((List<String>) request.getAttribute("vehicleType")).iterator();
                                while (vehicleTypeId.hasNext() && vehicleType.hasNext()) {
                            %>              
                            <option value="<%= vehicleTypeId.next()%>"><%=vehicleType.next()%></option>
                            <%}%> 
                        </select>
                        <br><br>

                        Pass Type&nbsp;&nbsp;&nbsp;&nbsp;: 
                        <select name="passType">   
                            <%
                                Iterator<String> passTypeId = ((List<String>) request.getAttribute("passTypeId")).iterator();
                                Iterator<String> passType = ((List<String>) request.getAttribute("passType")).iterator();
                                while (passTypeId.hasNext() && passType.hasNext()) {
                            %> 

                            <option value="<%=passTypeId.next()%>"><%=passType.next()%></option>
                            <%}%> 
                        </select>
                        <br><br>

                        Vehicle No&nbsp;&nbsp;&nbsp;&nbsp;:
                        <input type="text" name="vehicleNo" id="inputbox"/> 
                        <br><br>
                        <input type="submit" value="Issue Ticket" onclick="return validator()"/>
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
