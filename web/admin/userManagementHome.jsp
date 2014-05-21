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
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link href="../css/default.css" rel="stylesheet" type="text/css" media="all" />
        <link href="../css/fonts.css" rel="stylesheet" type="text/css" media="all" />    
        <link href="../css/jquery.datetimepicker.css" rel="stylesheet" type="text/css" />
        <jsp:include page="adminHeader.jsp"></jsp:include>
        <jsp:include page="adminMenu.jsp?menu=UserManagement"></jsp:include>           

            <script>
                function validateAdmin()
                {
                    var count = 0;
                    var txtBox = "adminUserID";
                    var input = document.getElementById(txtBox);
                    var value = input.value.replace(/\s/g, "");
                    if (value == "")
                    {
                        input.style.border = "2px solid red";
                        count = count + 1;
                    } else {
                        input.style.border = "2px solid black";
                    }
                    txtBox = "adminPassword";
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

                function validateEditUser()
                {
                    var txtBox = "editUserID";
                    var input = document.getElementById(txtBox);
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

                    <h4>Change Password</h4>
                    <form action="ChangePassword" method="post">
                        UserID &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                        :&nbsp;<input type="text" name="changePasswordUserID" id="changePasswordUserID">
                        <br><br>
                        New Password&nbsp;
                        :&nbsp;<input type="password" name="newPassword" id="newPassword">
                        <br><br>
                        <input type="submit" value="Change Password"  onclick="{
                                    return validateNewPassword();
                                }"/>
                    </form>                  
                    <br><br>
                    <p>-------------------------------------------------------------------------------------</p>
                    <h4>Create New Administrator</h4>
                    <form action="CreateAdmin" method="post">
                        UserID &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                        :&nbsp;<input type="text" name="adminUserID" id="adminUserID">
                        <br><br>
                        Password&nbsp;
                        :&nbsp;<input type="password" name="adminPassword" id="adminPassword">
                        <br><br>
                        <input type="submit" value="Create Administrator"  onclick="{
                                    return validateAdmin();
                                }"/>

                    </form>
                    <p>-------------------------------------------------------------------------------------</p>
                    <h4>Edit User Detail</h4>
                    <form >
                        UserID &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                        :&nbsp;<input type="text" name="editUserID" id="editUserID">
                        <br><br>                      
                        <input type="submit" value="Edit User"  onclick="{
                                    return validateEditUser();
                                }"/>

                    </form>
                </div>
            </div>

        </body>
    </html>

<%
    } else {
        response.sendRedirect("../RedirectUser");
    }
%>