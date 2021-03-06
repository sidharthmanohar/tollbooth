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
        <title>Issue Ticket</title>
        <link href="../css/default.css" rel="stylesheet" type="text/css" media="all" />
        <link href="../css/fonts.css" rel="stylesheet" type="text/css" media="all" />      
        <script>
            function makepage(divToPrint)
            {
                // We break the closing script tag in half to prevent
                // the HTML parser from seeing it as a part of
                // the *main* page.

                return "<html>\n" +
                        "<head>\n" +
                        "<script>\n" +
                        "function step1() {\n" +
                        "  setTimeout('step2()', 10);\n" +
                        "}\n" +
                        "function step2() {\n" +
                        "  window.print();\n" +
                        "  window.close();\n" +
                        "}\n" +
                        "</scr" + "ipt>\n" +
                        "</head>\n" +
                        "<body onLoad='step1()'>\n" +
                        divToPrint +
                        "</body>\n" +
                        "</html>\n";
            }

            function printme()
            {
                link = "about:blank";
                var pw = window.open(link, "_new");
                var divToPrint = document.getElementById("ticket").innerHTML;
                pw.document.open();
                pw.document.write(makepage(divToPrint));
                pw.document.close();
            }
        </script>
    </head>
    <body>
        <div id="wrapper">
            <jsp:include page="userHeader.jsp"></jsp:include>
            <jsp:include page="menu.jsp?menu=issueticket"></jsp:include>

                <div id="page" class="pagebody-centre">            
                    <div class="page-form">
                        <div id="ticket">
                            <table>
                                <tr style="border-bottom-color:  black">
                                    <td colspan="2">
                                <center>
                                    <h4>MADURAI  CORPORATION  
                                        <img src="../images/Madurai_Corporation_logo_BW.jpg" alt="" width="50" height="50" style="float: left">
                                        <br>TOLL COLLECTION</h4>
                                    <hr/>
                                </center>                               
                                </td> 

                                </tr>
                               
                          
                                <tr>
                                    <td>Ticket No.</td>
                                    <td>: &nbsp;<%= session.getAttribute("ticketNo")%> </td>           
                            </tr>   
                            <tr>
                                <td>Toll Plaza  </td>
                                <td>: &nbsp;<%= session.getAttribute("fromDestination")%> </td>           
                            </tr>   
                            <tr>
                                <td>Booth No.</td>
                                <td>: &nbsp;<%= session.getAttribute("boothNo")%> </td>           
                            </tr>
                            <tr>
                                <td>Destination</td>
                                <td>:&nbsp; <%= session.getAttribute("toDestination")%> </td>           
                            </tr>

                            <tr>
                                <td>Date</td>
                                <td>: &nbsp;<%= session.getAttribute("date")%> </td>           
                            </tr>
                            <tr>
                                <td>Validity</td>
                                <td>: &nbsp;<%= session.getAttribute("validity")%> </td>           
                            </tr>                           
                            <tr>
                                <td>Pass Type</td>
                                <td>: &nbsp;<%= session.getAttribute("passType")%> </td>           
                            </tr>

                            <tr>
                                <td>Fee</td>
                                <td>: &nbsp;<%= session.getAttribute("fare")%> </td>           
                            </tr>
                            <tr>
                                <td>Vehicle Type</td>
                                <td>:&nbsp; <%= session.getAttribute("vehicleType")%> </td>           
                            </tr>

                            <tr>
                                <td>Vehicle No</td>
                                <td>: &nbsp;<%= session.getAttribute("vehicleNo")%> </td>           
                            </tr>                           

                            <tr>
                                <td colspan="2">
                                    <img src="../GenerateBarcodeServlet?barcodeNo=<%= session.getAttribute("barcodeNo")%>"  width="275" height="55">
                                </td>
                            </tr>
                            <tr>
                                <td colspan="2">
                            <center>
                                Happy Journey!!

                            </center>
                            </td>
                            </tr>
                        </table>                                 


                    </div>
                    <br>

                    <form action="TicketForm">
                        <input type="button" value="Print Ticket" onClick="printme()">
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                        <input type="submit" value="Next Ticket">
                    </form>
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
