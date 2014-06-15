/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package admin;

import java.io.File;
import java.io.FileInputStream;
import login.ConnectionManager;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Properties;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Chidambaram
 */
public class GenerateReportForm extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        ServletContext servletContext = request.getServletContext();
        String propertiesFilePath = servletContext.getRealPath("WEB-INF/tollbooth.properties");
        Properties properties = new Properties();
        properties.load(new FileInputStream(new File(propertiesFilePath)));

        Connection conn = null;
        Statement stmt = null;
        ResultSet rs = null;
        try {

            String tollid = request.getParameter("tollPlazaId");
            String fromDate = request.getParameter("fromDate");
            String toDate = request.getParameter("toDate");
            Class.forName(properties.getProperty("sqldriver"));

            conn = DriverManager.getConnection(
                    properties.getProperty("sqlurl"),
                    properties.getProperty("sqluser"),
                    properties.getProperty("sqlpassword"));
            stmt = conn.createStatement();

            String query = "SELECT toll_plaza_name FROM toll_plaza WHERE toll_plaza_id = " + tollid;
            rs = stmt.executeQuery(query);
            rs.next();
            request.setAttribute("tollPlaza", rs.getString(1));
            request.setAttribute("fromDate", new SimpleDateFormat("dd-MM-yyyy HH:ss").format(new SimpleDateFormat("yyyy/MM/dd HH:ss").parse(fromDate)));
            request.setAttribute("toDate", new SimpleDateFormat("dd-MM-yyyy HH:ss").format(new SimpleDateFormat("yyyy/MM/dd HH:ss").parse(toDate)));

            query = "select l.name,pt.pass_type,t.vehicle_no,v.vehicle_type,t.fare_collected,t.ticket_no from ticket t,toll_plaza p,pass_type pt,vehicle_type v, location l where v.vehicle_type_id=t.vehicle_type_id and pt.pass_id=t.pass_type and p.toll_plaza_id=t.to_toll_plaza_id and date(t.registration_time) BETWEEN '" + fromDate + "' AND '" + toDate + "' and t.from_toll_plaza_id='" + tollid +"' AND t.to_location_id = l.location_id";
            String table = "<table border=1><tr><th>Ticket No</th><th>Destination</th><th>Pass Type</th><th>Registration No</th><th>Vechile Type</th><th>Fare</th></tr>";
            rs = stmt.executeQuery(query);
            int total = 0;
            //out.print(today);
            while (rs.next()) {
                table = table + "<tr><td>" + rs.getString(6) + "</td>"+"<td>" + rs.getString(1) + "</td><td>" + rs.getString(2) + "</td><td>" + rs.getString(3) + "</td><td>" + rs.getString(4) + "</td><td>" + rs.getInt(5) + "</td></tr>";
                total = total + rs.getInt(5);
            }
            table = table + "<tr><td colspan=5>Total</td><td>" + total + "</td></tr></table>";
            request.setAttribute("tollPlazaReport", table);
            RequestDispatcher dispatcher = servletContext.getRequestDispatcher("/admin/tollPlazaReport.jsp");
            dispatcher.forward(request, response);

        } catch (SQLException ex) {
            Logger.getLogger(GenerateReportForm.class.getName()).log(Level.SEVERE, null, ex);
            response.sendRedirect("error.jsp");
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(GenerateReportForm.class.getName()).log(Level.SEVERE, null, ex);
            response.sendRedirect("error.jsp");
        } catch (ParseException ex) {
            Logger.getLogger(GenerateReportForm.class.getName()).log(Level.SEVERE, null, ex);
            response.sendRedirect("error.jsp");
        } finally {
            try {
                if (stmt != null) {
                    stmt.close();
                }

            } catch (SQLException ex) {
                Logger.getLogger(GenerateReportForm.class.getName()).log(Level.SEVERE, null, ex);
                response.sendRedirect("error.jsp");
            }
            try {
                if (conn != null) {
                    conn.close();
                }
            } catch (SQLException ex) {
                Logger.getLogger(GenerateReportForm.class.getName()).log(Level.SEVERE, null, ex);
                response.sendRedirect("error.jsp");
            }
        }
    }

    /**
     *
     * @return
     */
    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
