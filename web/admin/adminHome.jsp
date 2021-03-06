<%-- 
    Document   : adminHome
    Created on : Mar 12, 2014, 6:50:21 PM
    Author     : sidharth
--%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%
    HttpSession currentSession = request.getSession(false);
    String user = (String) currentSession.getAttribute("userType");
    if (user != null && user.equals("admin")) {
%>


<%@page contentType="text/html" pageEncoding="UTF-8" import="admin.AdminReport" import="javax.sql.rowset.CachedRowSet" %>
<!DOCTYPE html>
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
                    <center>
                        <h3>Daily Report
                        </h3>
                    </center>
                    <br/>

                    <div class="page-form">


                        <br/>
                        <form action="GetReport" method="post">

                            <center>

                                <table>
                                    <tr>
                                        <td>Toll Plaza</td>
                                        <td>&nbsp;:&nbsp;<select name="tollid"><%out.print(request.getAttribute("toll_list"));%></td>
                                </tr>
                                <tr>
                                    <td>&nbsp;</td>
                                </tr>
                                <tr>
                                    <td>Date</td>
                                    <td>&nbsp;:&nbsp;<input type="date" name="date" id="inputbox1"/></td>
                                </tr>
                                <tr>
                                    <td>&nbsp;</td>
                                </tr>
                            </table>
                            <input type="submit" value="Generate Report"/>
                        </center>
                    </form>
                    </center>              
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


    <script type="text/javascript" src="../js/jquery.js"></script>
    <script type="text/javascript" src="../js/jquery.datetimepicker.js"></script>
    <script type="text/javascript">
            $('#datetimepicker').datetimepicker()
                    .datetimepicker({value: '2015/04/15 05:03', step: 10});
    </script>




</html>

<%
    } else {
        response.sendRedirect("../RedirectUser");
    }
%>