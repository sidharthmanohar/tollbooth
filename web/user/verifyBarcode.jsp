<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link href="css/default.css" rel="stylesheet" type="text/css" media="all" />
        <link href="css/fonts.css" rel="stylesheet" type="text/css" media="all" />      
        <jsp:include page="userHeader.jsp"></jsp:include>
        <jsp:include page="menu.jsp?menu=validate"></jsp:include>
    </head>
    <body>

        <div id="wrapper">


            <div id="page" class="pagebody-centre">
                <h3>Ticket Form</h3>
                <form  method="post" action="VerifyCodeServlet"> 
                    Barcode : <input type="password" name="bar_id"/> 
                    <br><br>
                    Toll Plaza
                    <select name="toll_id" >
                        <option value="1">T1</option>
                        <option value="2">T2</option>
                        <option value="3">T3</option>
                        <option value="4">T4</option>
                        <option value="5">T5</option>

                    </select>

                    <br><br>
                    <input type="submit" value="Submit"> 
                </form>
            </div>
        </div>
    </body>

</html>
