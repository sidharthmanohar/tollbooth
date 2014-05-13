<%-- 
    Document   : adminReport
    Created on : 6 Apr, 2014, 11:12:58 PM
    Author     : mari
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link href="../css/default.css" rel="stylesheet" type="text/css" media="all" />
        <link href="../css/fonts.css" rel="stylesheet" type="text/css" media="all" />      
        <jsp:include page="adminHeader.jsp"></jsp:include>
        <jsp:include page="adminMenu.jsp?menu=dialyreport"></jsp:include>
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
    <center>
        <h3>Welcome <%= session.getAttribute("userID") %>(<%= session.getAttribute("userType") %>)
        </h3>
    </center>
    <br/>
    <br/>
    <br/>
    <div id="print_content">
    <center>
        <h5>
            Report
        </h5>
        <br/>
            <h5>
                <%out.print(request.getAttribute("dailyreport"));%>
               </h5><br/><br/>
            <input type="button" value="Print Ticket" onclick="printPage('print_content');">
        
    </center>
    </div>       
            </div>
        </div>
    </body>
                           

</html>