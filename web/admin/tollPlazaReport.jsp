<%-- 
    Document   : tollPlazaReport
    Created on : 19 May, 2014, 11:31:49 PM
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
                function printPage(id)
                {
                    var html = "<html>";
                    html += document.getElementById(id).innerHTML;
                    html += "</html>";

                    var printWin = window.open('', '', 'left=0,top=0,width=1,height=1,toolbar=0,scrollbars=0,status  =0');
                    printWin.document.write(html);
                    printWin.document.close();
                    printWin.focus();
                    printWin.print();
                    printWin.close();
                }
            </script>    
        </head>

        <body>

            <div id="wrapper">
                <div id="page" class="pagebody-centre"> 
                <br/>
                <div id="print_content">
                    <center>

                        <h3>Specific Report for <%=request.getAttribute("tollPlaza")%></h3>
                        <br>
                        <br>
                        
                        <table>
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
                            <%out.print(request.getAttribute("tollPlazaReport"));%>
                        </div>
                        <br/><br/>

                    </center>
                </div>   
                <input type="button" value="Print" onclick="printPage('print_content');">
            </div>
        </div>
    </body>
</html>