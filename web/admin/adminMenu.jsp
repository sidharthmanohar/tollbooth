<%-- 
    Document   : adminMenu
    Created on : 6 Apr, 2014, 9:15:18 PM
    Author     : mari
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<div id="menu-wrapper">
    <% String menuSelected = request.getParameter("menu");
        if(menuSelected == null){
            menuSelected = "";
        }
    %>
    <div id="menu" class="container">
        <ul>                         

            <li  <% if (menuSelected.equals("report")) { %>                        
                class="current_page_item" <%}%> >
                <a href="reportMain.jsp">Report</a></li>
            <li  <% if (menuSelected.equals("Tariff")) { %>                        
                class="current_page_item" <%}%> >
                <a href="TariffMain">Tariff</a></li>
            <li  <% if (menuSelected.equals("UserManagement")) { %>                        
                class="current_page_item" <%}%> >
                <a href="userManagementHome.jsp">User Management</a></li>
            <li><a href="/tollbooth/LogOut"  >Logout</a></li>
        </ul>
    </div>
    <!-- end #menu --> 
</div>

