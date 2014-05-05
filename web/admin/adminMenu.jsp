<%-- 
    Document   : adminMenu
    Created on : 6 Apr, 2014, 9:15:18 PM
    Author     : mari
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>User Menu</title>
        <link href="css/default.css" rel="stylesheet" type="text/css" media="all" />
        <link href="css/fonts.css" rel="stylesheet" type="text/css" media="all" />         
    </head>
    <body>
        <div id="menu-wrapper">
            <% String menuSelected = request.getParameter("menu");
              
            %>
            <div id="menu" class="container">
                <ul>       
                    
                    <li  <% if(menuSelected.equals("dialyreport")){ %>
                           
                           class="current_page_item" <%}%> ><a href="/tollbooth/AdminHome"
                           
                          >Daily Report</a></li>
                     <li <% if(menuSelected.equals("validate")){ %>
                           class="current_page_item" <%}%>><a href="/tollbooth/ValidateDispatch"  >Validate</a></li> 
                    <li><a href="/tollbooth/LogOut"  >Logout</a></li>
                </ul>
            </div>
            <!-- end #menu --> 
        </div>
    </body>
</html>

