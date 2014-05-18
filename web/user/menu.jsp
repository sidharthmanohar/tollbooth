<%-- 
    Document   : menu
    Created on : Mar 18, 2014, 9:45:38 PM
    Author     : Sidharth
--%>

<div id="menu-wrapper">
    <% String menuSelected = request.getParameter("menu");
    if(menuSelected == null){
        menuSelected = "";
    }
    %>
    <div id="menu" class="container">
        <ul>       
            <li <% if (menuSelected.equals("home")) { %>
                class="current_page_item" <%}%>>
                <a href="/tollbooth/user/userHome.jsp">Home</a></li>
            <li  <% if (menuSelected.equals("issueticket")) { %>
                class="current_page_item" <%}%>>
                <a href="/tollbooth/user/TicketForm">Issue Ticket</a></li>
            <li <% if (menuSelected.equals("validate")) { %>
                class="current_page_item" <%}%>>
                <a href="/tollbooth/user/verifyBarcode.jsp">Validate</a></li>
            <li><a href="/tollbooth/LogOut"  >Logout</a></li>
        </ul>
    </div>
</div>
