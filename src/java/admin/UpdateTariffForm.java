/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package admin;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Properties;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author Sidharth
 */
public class UpdateTariffForm extends HttpServlet {

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

            int tollPlazaId = Integer.parseInt(request.getParameter("tollPlazaId"));
            String vehicleTypeId = request.getParameter("vehicleTypeId");
            String date = request.getParameter("date");
            
            String passTypeId = "1";

            String sql = "SELECT toll_plaza_name FROM toll_plaza WHERE toll_plaza_id = " + tollPlazaId;
            rs = stmt.executeQuery(sql);
            rs.next();
            String tollPlazaName = rs.getString(1);

            sql = "SELECT vehicle_type FROM vehicle_type where vehicle_type_id = " + vehicleTypeId;
            rs = stmt.executeQuery(sql);
            rs.next();
            String vehicleType = rs.getString(1);
            rs.close();

            sql = "SELECT pass_type FROM pass_type WHERE pass_Id= " + passTypeId;
            rs = stmt.executeQuery(sql);
            rs.next();
            String passType = rs.getString(1);

            sql = "SELECT count(*) FROM toll_plaza";
            rs = stmt.executeQuery(sql);
            rs.next();
            int plazaNo = rs.getInt(1);

            String values[][] = new String[plazaNo + 1][2];

            sql = "SELECT name FROM location WHERE location_id = "+(tollPlazaId + 1);
            rs = stmt.executeQuery(sql);
            rs.next();
            String fromLocation = rs.getString(1);
            
            int i;
            for (i = 1; i <= tollPlazaId; i++) {
                values[i - 1][0] = fromLocation;
                sql = "SELECT name FROM location WHERE location_id = " + i;
                 rs = stmt.executeQuery(sql);
                rs.next();
                values[i - 1][1] = rs.getString(1);

            }
            //for(int j = 0; j < values.length; j++){
            //             System.out.println(values[j][0] +"\t"+values[j][1] +"\t"+values[j][2]);
            //}

            i--;
             sql = "SELECT name FROM location WHERE location_id = "+tollPlazaId;
            rs = stmt.executeQuery(sql);
            rs.next();
            fromLocation = rs.getString(1);
            for (; i <= plazaNo; i++) {
               values[i][0] = fromLocation;
                sql = "SELECT name FROM location WHERE location_id = " + (i+1);
                rs = stmt.executeQuery(sql);
                rs.next();
                values[i][1] = rs.getString(1);
            }
            //for(int j = 0; j < values.length; j++){
            //             System.out.println(values[j][0] +"\t"+values[j][1] +"\t"+values[j][2]);
            //}
            request.setAttribute("tollPlazaName", tollPlazaName);
            request.setAttribute("vehicleType", vehicleType);
            request.setAttribute("passType", passType);
            request.setAttribute("date", date);
            request.setAttribute("fareDetail", values);
            HttpSession session = request.getSession(false);
            session.setAttribute("tTollPlazaId", tollPlazaId);
            session.setAttribute("tPassTypeId", passTypeId);
            session.setAttribute("tVehicleTypeId", vehicleTypeId);
            session.setAttribute("tDateEffect", date);
            RequestDispatcher dispatcher = servletContext.getRequestDispatcher("/admin/updateTariffForm.jsp");
            dispatcher.forward(request, response);

        } catch (ClassNotFoundException ex) {
            Logger.getLogger(UpdateTariffForm.class.getName()).log(Level.SEVERE, null, ex);
            response.sendRedirect("error.jsp");
        } catch (SQLException ex) {
            Logger.getLogger(UpdateTariffForm.class.getName()).log(Level.SEVERE, null, ex);
            response.sendRedirect("error.jsp");
        } catch (NullPointerException ex) {
            Logger.getLogger(UpdateTariffForm.class.getName()).log(Level.SEVERE, null, ex);
            response.sendRedirect("error.jsp");
        } catch (NumberFormatException ex) {
            Logger.getLogger(UpdateTariffForm.class.getName()).log(Level.SEVERE, null, ex);
            response.sendRedirect("error.jsp");
        } finally {
            try {
                if (stmt != null) {
                    stmt.close();
                }

            } catch (SQLException ex) {
                Logger.getLogger(UpdateTariffForm.class.getName()).log(Level.SEVERE, null, ex);
                response.sendRedirect("error.jsp");
            }
            try {
                if (conn != null) {
                    conn.close();
                }
            } catch (SQLException ex) {
                Logger.getLogger(UpdateTariffForm.class.getName()).log(Level.SEVERE, null, ex);
                response.sendRedirect("error.jsp");
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
