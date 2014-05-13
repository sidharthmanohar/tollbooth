<%-- 
    Document   : adminHome
    Created on : Mar 12, 2014, 6:50:21 PM
    Author     : sidharth
--%>
<%
    HttpSession currentSession = request.getSession(false);
    String user = (String) currentSession.getAttribute("userType");
    if (user != null && user.equals("admin")) {
%>


<%@page contentType="text/html" pageEncoding="UTF-8" import="admin.AdminReport" import="javax.sql.rowset.CachedRowSet" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link href="../css/default.css" rel="stylesheet" type="text/css" media="all" />
        <link href="../css/fonts.css" rel="stylesheet" type="text/css" media="all" /> 
        <link href="../css/jquery.datetimepicker.css" rel="stylesheet" type="text/css" />

       
        <jsp:include page="adminHeader.jsp"></jsp:include>
        <jsp:include page="adminMenu.jsp?menu=dialyreport"></jsp:include>
        </head>
        <body>

            <div id="wrapper">


                <div id="page" class="pagebody-centre"> 
                    <center>
                        <h3>Welcome <%= session.getAttribute("userID")%>(<%= session.getAttribute("userType")%>)
                    </h3>
                </center>
                <br/>
                <br/>
                <br/>
                <div class="page-form">
                    <center>
                        <h5>
                            Select a Tollbooth for report
                        </h5>
                        <br/>
                        <form action="GetReport" method="post">
                            <h5>select toll plaza:&nbsp;&nbsp;<select name="tollid">
                                    <%out.print(request.getAttribute("toll_list"));%>
                                </select></h5><br/><br/>

                            <input type="submit" value="submit"/>
                        </form>
                    </center>

                    <input type="text" value="2014/03/15 05:06" id="datetimepicker"/><br><br>
                </div>
            </div>
        </div>
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