<%-- 
    Document   : userManagementHome 
    Author     : Sidharth
--%>
<%
    HttpSession currentSession = request.getSession(false);
    String user = (String) currentSession.getAttribute("userType");
    if (user != null && user.equals("admin")) {
%>
<%@page import="java.util.List"%>
<%@page import="java.util.Iterator"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <link rel="shortcut icon" href="../images/Madurai_Corporation_logo.jpg">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>User Management</title>
        <link href="../css/default.css" rel="stylesheet" type="text/css" media="all" />
        <link href="../css/fonts.css" rel="stylesheet" type="text/css" media="all" />    
        <link href="../css/jquery.datetimepicker.css" rel="stylesheet" type="text/css" />
        <jsp:include page="adminHeader.jsp"></jsp:include>
        <jsp:include page="adminMenu.jsp?menu=UserManagement"></jsp:include>           

            <script>


                function validateNewPassword()
                {

                    var count = 0;
                    var txtBox = "changePasswordUserID";
                    var input = document.getElementById(txtBox);
                    var value = input.value.replace(/\s/g, "");
                    if (value == "")
                    {
                        input.style.border = "2px solid red";
                        count = count + 1;
                    } else {
                        input.style.border = "2px solid black";
                    }
                    txtBox = "oldPassword";
                    var input = document.getElementById(txtBox);
                    var value = input.value.replace(/\s/g, "");
                    if (value == "")
                    {
                        input.style.border = "2px solid red";
                        count = count + 1;
                    } else {
                        input.style.border = "2px solid black";
                    }
                    txtBox = "newPassword";
                    input = document.getElementById(txtBox);
                    value = input.value.replace(/\s/g, "");
                    if (value == "")
                    {
                        input.style.border = "2px solid red";
                        count = count + 1;
                    } else {
                        input.style.border = "2px solid black";
                    }
                    if (count == 0) {
                        return true;
                    }
                    return false;
                }
            </script>
        </head>

        <body>
            <div id="wrapper">
                <div id="page" class="pagebody-centre">

                    <h4>Change Password</h4>
                    <form action="ChangePassword" method="post">
                        <center>

                            <table>
                                <tr>
                                    <td>UserID</td>
                                    <td>:&nbsp;<input type="text" name="changePasswordUserID" id="changePasswordUserID" autofocus ></td>
                                </tr>
                                <tr>
                                    <td>&nbsp;</td>
                                </tr>
                                <tr>
                                    <td>Your Password</td>
                                    <td>:&nbsp;<input type="password" name="oldPassword" id="oldPassword"></td>
                                </tr>
                                <tr>
                                    <td>&nbsp;</td>
                                </tr>
                                <tr>
                                    <td>New Password</td>
                                    <td>:&nbsp;<input type="password" name="newPassword" id="newPassword"></td>
                                </tr>
                                <tr>
                                    <td>&nbsp;</td>
                                </tr>
                            </table>

                        </center>
                        <br>
                        <input type="submit" value="Change Password"  onclick="{
                                    return validateNewPassword();
                                }"/>
                    </form>                  
                    <br>
                    <h4>Note: Only your password and tollplaza user's password can be changed.</h4>
                </div>
            </div>

        </body>
    </html>

<%
    } else {
        response.sendRedirect("../RedirectUser");
    }
%>