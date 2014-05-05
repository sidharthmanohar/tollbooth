<%-- 
    Document   : chargeEntry
    Created on : 5 May, 2014, 4:06:20 PM
    Author     : priya p
--%>

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
        <jsp:include page="adminHeader.jsp"></jsp:include>
        <jsp:include page="adminMenu.jsp?menu=Tariff"></jsp:include>           

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
                    <h3>Enter tariff detail</h3>
                    <br><br>
                    <div class="page-form">
                        <form action="ProcessTicketForm" method="post">
                            Toll Plaza 1&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;:
                            <select name="tollPlaza1">            
                            <%
                                Iterator<String> tollPlazaId = ((List<String>) request.getAttribute("tollPlazaId")).iterator();
                                Iterator<String> tollPlazaName = ((List<String>) request.getAttribute("tollPlazaName")).iterator();
                                while (tollPlazaId.hasNext() && tollPlazaName.hasNext()) {
                            %>
                            <option value="<%=tollPlazaId.next()%>"><%= tollPlazaName.next()%></option>
                            <%}%> 
                        </select>
                        <br><br>
                        Toll Plaza 2&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;:
                        <select name="tollPlaza2">            
                            <%
                                tollPlazaId = ((List<String>) request.getAttribute("tollPlazaId")).iterator();
                                tollPlazaName = ((List<String>) request.getAttribute("tollPlazaName")).iterator();
                                while (tollPlazaId.hasNext() && tollPlazaName.hasNext()) {
                            %>
                            <option value="<%=tollPlazaId.next()%>"><%= tollPlazaName.next()%></option>
                            <%}%> 
                        </select>
                        <br><br>
                        Vehicle Type&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;: 
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

                        Pass Type&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;: 
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

                        Effect From&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;:
                        <input type="date" name="EffectFromDate"/>
                        <br><br>
                        Tariff&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;:
                        <input type="text" name="Fare"/>
                        <br><br>
                        <input type="submit" value="Issue Ticket" onclick="return validator()"/>
                </div>
            </div>
        </div>
    </body>

</html>
