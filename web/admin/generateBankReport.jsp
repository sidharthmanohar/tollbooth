<%-- 
    Document   : generateBankReport
    Created on : 20 May, 2014, 9:28:38 AM
    Author     : Chidambaram
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
         <link rel="shortcut icon" href="../images/Madurai_Corporation_logo.jpg">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Report</title>
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
                    var divToPrint = document.getElementById("print_content").innerHTML;
                    pw.document.open();
                    pw.document.write(makepage(divToPrint));
                    pw.document.close();
                }
            </script>       
        </head>

       <body>

            <div id="wrapper">
                <div id="page" class="pagebody-centre"> 
                <br/>
                <div id="print_content">
                    <center>
<table width="600">
                                <tr >
                                    <td>
                                        <img src="../images/Madurai_Corporation_logo_BW.jpg" alt="" width="90" height="90" style="float: left">
                                    </td>
                                    <td>
                                        <h3>MADURAI CORPORATION</h3>
                                        <h4>TOLL COLLECTION REPORT</h4>
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="2"> <hr>
                                    </td>
                                </tr>
                            </table>
                        
                      
                        <table>
                            <tr>
                                <td>
                                    Toll Gate
                                </td>
                                <td>
                                     :<%=request.getAttribute("tollPlaza")%>
                                </td>
                            </tr>
                            <tr>
                                <td>&nbsp;</td>
                            </tr>
                            <tr>
                                
                                <td>
                                From
                            </td>
                            <td>
                                :<%=request.getAttribute("fromDate")%>
                            </td>
                            </tr>
                            <tr>
                                <td>&nbsp;</td>
                            <tr>
                                
                                <td>
                                To
                            </td>
                            <td>
                                :<%=request.getAttribute("toDate")%>
                            </td>
                            </tr>
                        </table>  

                        <br/>

                        <div class="CSSTableGenerator" style="width:700px;">
                            <%out.print(request.getAttribute("generateBankReport"));%>
                        </div>
                        <br/><br/>

                    </center>
                </div>   
                        <input type="button" value="Print" onclick="printme();">
            </div>
        </div>
    </body>


</html>