<%-- 
    Document   : bankReport
    Created on : 20 May, 2014, 8:55:13 AM
    Author     : Chidambaram
--%>

<%@page import="java.util.Iterator"%>
<%@page import="java.util.List"%>
<%@page import="java.util.List"%>
<html>
    <head>
         <link rel="shortcut icon" href="../images/Madurai_Corporation_logo.jpg">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Report</title>
        <link href="../css/default.css" rel="stylesheet" type="text/css" media="all" />
        <link href="../css/fonts.css" rel="stylesheet" type="text/css" media="all" /> 
        <link href="../css/jquery.datetimepicker.css" rel="stylesheet" type="text/css" />

        <jsp:include page="adminHeader.jsp"></jsp:include>
        <jsp:include page="adminMenu.jsp?menu=report"></jsp:include>
        </head>
        <body>
            <div id="wrapper">
                <div id="page" class="pagebody-centre">
                    <h3>Brief Report</h3>
                    <br><br>
                    <div class="page-form">
                        <form action="GenerateBankReport" method="post">
                            Select Toll Plaza &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;:
                            <select name="tollPlazaId">
                            <%out.print(request.getAttribute("toll_list"));%>
                            </select><br/><br/>
                            Select Date and Time
                            <br><br>
                            From&nbsp;&nbsp;&nbsp;&nbsp;:
                            <input type="text"  id="datetimepicker1" name="fromDate"/>
                            <br><br>
                            To&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;:
                            <input type="text"  id="datetimepicker2" name="toDate"/>
                            <br><br>
                            <input type="submit" value="Generate Report"/>
                    </form>
                </div>
            </div>
        </div>
    </body>

    <script type="text/javascript" src="../js/jquery.js"></script>
    <script type="text/javascript" src="../js/jquery.datetimepicker.js"></script>
    <script type="text/javascript">
        $('#datetimepicker1').datetimepicker()
                .datetimepicker({value: '<%=request.getAttribute("date")%>', step: 10});
        $('#datetimepicker2').datetimepicker()
                .datetimepicker({value: '<%=request.getAttribute("date")%>', step: 10});
    </script>
</html>

