<%-- 
    Document   : tollPlazaReport
    Created on : 13 May, 2014, 11:12:18 AM
    Author     : Sidharth
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
        <link href="../css/table.css" rel="stylesheet" type="text/css" media="all" />   
        <jsp:include page="adminHeader.jsp"></jsp:include>
        <jsp:include page="adminMenu.jsp?menu=report"></jsp:include>

            <script>
                function makepage(divToPrint)
                {
                    // We break the closing script tag in half to prevent
                    // the HTML parser from seeing it as a part of
                    // the *main* page.

                    return "<html>\n" +
                            "<head>\n <link href=\"../css/table.css\" rel=\"stylesheet\" type=\"text/css\" media=\"all\" />   " +
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
            <div id="wrapper" style=height:545px;>
                
                <center>
                    <br><br>
                    
                     <div id="ticket">
                    <h3>Report of toll plaza <%=session.getAttribute("tollPlaza")%></h3>


                <h4>Between <%=session.getAttribute("fromDate")%> and <%=session.getAttribute("toDate")%></h4>
               
                    <div class="CSSTableGenerator" style="width:700px;height:370px;" >
                        <table>
                            <tr> 
                                <td>
                                    Tollbooth No
                                </td>
                                <td >
                                    No of Heavy vehicle
                                </td>
                                <td>
                                    Amount Collected from Heavy vehicle
                                </td>
                                <td >
                                    No of Light vehicle
                                </td>
                                <td>
                                    Amount Collected from light vehicle
                                </td>
                                <td >
                                    Total Amount in rupees
                                </td>

                            </tr>
                            <tr>
                                <td >
                                    Tollbooth 1
                                </td>
                                <td>
                                    6
                                </td>
                                <td>
                                    600
                                </td>
                                <td >
                                    10
                                </td>
                                <td>
                                    250
                                </td>
                                <td>
                                    850
                                </td>
                            </tr>

                            <tr>
                                <td >
                                    Tollbooth 2
                                </td>
                                <td>
                                    8
                                </td>
                                <td>
                                    800
                                </td>
                                <td >
                                    10
                                </td>
                                <td>
                                    250
                                </td>
                                <td>
                                    1050
                                </td>
                            </tr>

                            <tr>
                                <td >
                                    Tollbooth 3
                                </td>
                                <td>
                                    6
                                </td>
                                <td>
                                    600
                                </td>
                                <td >
                                    10
                                </td>
                                <td>
                                    250
                                </td>
                                <td>
                                    850
                                </td>
                            </tr>

                            <tr>
                                <td >
                                    Tollbooth 4
                                </td>
                                <td>
                                    8
                                </td>
                                <td>
                                    800
                                </td>
                                <td >
                                    10
                                </td>
                                <td>
                                    250
                                </td>
                                <td>
                                    1050
                                </td>
                            </tr>

                            <tr>
                                <td >
                                    Tollbooth 5
                                </td>
                                <td>
                                    4
                                </td>
                                <td>
                                    400
                                </td>
                                <td >
                                    5
                                </td>
                                <td>
                                    100
                                </td>
                                <td>
                                    500
                                </td>
                            </tr>
                            <tr>
                                <td >
                                    Tollbooth 6
                                </td>
                                <td>
                                    4
                                </td>
                                <td>
                                    400
                                </td>
                                <td >
                                    5
                                </td>
                                <td>
                                    100
                                </td>
                                <td>
                                    500
                                </td>
                            </tr>

                            <tr><td colspan=5>Total</td><td>4800</td></tr>


                        </table>
                        <br><br><br>  <br><br><br>
                    </div>
                </div>
                <br>
                
                <input type="button" value="Print" onClick="printme()">
            </center>

        </div>

    </body>
</html>