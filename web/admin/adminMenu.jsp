<%-- 
    Document   : adminMenu
    Created on : 6 Apr, 2014, 9:15:18 PM
    Author     : mari
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<div id="menu-wrapper">
    <% String menuSelected = request.getParameter("menu");

    %>
    <div id="menu" class="container">
        <ul>                         
            <li  <% if (menuSelected.equals("dialyreport")) { %>                        
                class="current_page_item" <%}%> >
                <a href="AdminHome">Daily Report</a></li>
            <li  <% if (menuSelected.equals("Tariff")) { %>                        
                class="current_page_item" <%}%> >
                <a href="TariffForm">Tariff</a></li>
            
            <li <% if (menuSelected.equals("validate")) { %>
                class="current_page_item" <%}%>>
                <a href="/tollbooth/ValidateDispatch">Validate</a></li> 
            <li><a href="/tollbooth/LogOut"  >Logout</a></li>
        </ul>
    </div>
    <!-- end #menu --> 
</div>

