/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package admin;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.sql.Connection;
import java.sql.Date;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Properties;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author priya p
 */
public class ProcessTariffForm extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        String tollPlazaId1 = request.getParameter("tollPlazaId1");
        String tollPlazaId2 = request.getParameter("tollPlazaId2");

        String vehicleTypeId = request.getParameter("vehicleTypeId");
        String passTypeId = request.getParameter("passTypeId");
        String effectFromDate = request.getParameter("effectFromDate");
        String fare = request.getParameter("fare");

        ServletContext servletContext = request.getServletContext();
        String propertiesFilePath = servletContext.getRealPath("WEB-INF/tollbooth.properties");
        Properties properties = new Properties();
        properties.load(new FileInputStream(new File(propertiesFilePath)));

        Connection conn = null;
        Statement stmt = null;
        ResultSet rs;

        try {

            Class.forName(properties.getProperty("sqldriver"));
            conn = DriverManager.getConnection(
                    properties.getProperty("sqlurl"),
                    properties.getProperty("sqluser"),
                    properties.getProperty("sqlpassword"));

            stmt = conn.createStatement();

            //enter one way
            String sql = "INSERT INTO toll_charge ("
                    + "from_toll_plaza_id,to_toll_plaza_id,pass_id,fare,vehicle_type_id,effect_from)"
                    + " VALUES ("
                    + tollPlazaId1 + ", " + tollPlazaId2 + ", "
                    + passTypeId + ", " + fare + ", " + vehicleTypeId + ", '"
                    + effectFromDate + "')";
            stmt.executeUpdate(sql);

            //enter opposite way
            sql = "INSERT INTO toll_charge ("
                    + "from_toll_plaza_id,to_toll_plaza_id,pass_id,fare,vehicle_type_id,effect_from)"
                    + " VALUES ("
                    + tollPlazaId2 + ", " + tollPlazaId1 + ", "
                    + passTypeId + ", " + fare + ", " + vehicleTypeId + ", '"
                    + effectFromDate + "')";
            stmt.executeUpdate(sql);

            response.sendRedirect("tariffResult.jsp?status=true");

        } catch (ClassNotFoundException ex) {
            //handle error!!!
            Logger.getLogger(ProcessTariffForm.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            response.sendRedirect("tariffResult.jsp");
        } finally {
            try {
                if (stmt != null) {
                    stmt.close();
                }

            } catch (SQLException ex) {
                Logger.getLogger(ProcessTariffForm.class.getName()).log(Level.SEVERE, null, ex);
            }
            try {
                if (conn != null) {
                    conn.close();
                }
            } catch (SQLException ex) {
                Logger.getLogger(ProcessTariffForm.class.getName()).log(Level.SEVERE, null, ex);
            }

        }
    }

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
