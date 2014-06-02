package admin;

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
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
 * @author Sidharth
 */
public class UpdateTariff extends HttpServlet {

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
        HttpSession session = request.getSession(false);

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

            String sql = "SELECT count(*) FROM toll_plaza";
            rs = stmt.executeQuery(sql);
            rs.next();

            int plazaNo = rs.getInt(1);
            int i;

            //if tariff with same data other than fare is found it is first deleted
            //new tarif is inserted
            for (i = 1; i <= (Integer) session.getAttribute("tTollPlazaId"); i++) {

                sql = "SELECT * FROM toll_charge WHERE "
                        + "from_toll_plaza_id= " + session.getAttribute("tTollPlazaId") + " AND "
                        + "to_toll_plaza_id = " + i + " AND "
                        + "pass_id = " + session.getAttribute("tPassTypeId") + " AND "
                        + "vehicle_type_id = " + session.getAttribute("tVehicleTypeId") + " AND "
                        + "direction=2" + " AND "
                        + "effect_from='" + session.getAttribute("tDateEffect") + "';";

                rs = stmt.executeQuery(sql);
                if (rs.next()) {
                    sql = "DELETE FROM toll_charge WHERE "
                            + "from_toll_plaza_id= " + session.getAttribute("tTollPlazaId") + " AND "
                            + "to_toll_plaza_id = " + i + " AND "
                            + "pass_id = " + session.getAttribute("tPassTypeId") + " AND "
                            + "vehicle_type_id = " + session.getAttribute("tVehicleTypeId") + " AND "
                            + "direction=2" + " AND "
                            + "effect_from='" + session.getAttribute("tDateEffect") + "';";
                    stmt.executeUpdate(sql);
                }
                sql = "INSERT INTO toll_charge ("
                        + "from_toll_plaza_id,to_toll_plaza_id,pass_id,fare,vehicle_type_id,effect_from,direction)"
                        + " VALUES ("
                        + session.getAttribute("tTollPlazaId") + ", " + i + ", "
                        + session.getAttribute("tPassTypeId") + ", " + request.getParameter("fareBox" + (i - 1)) + ", " + session.getAttribute("tVehicleTypeId") + ", '"
                        + session.getAttribute("tDateEffect") + "'"
                        + ",2)";
                stmt.executeUpdate(sql);

            }
            //for(int j = 0; j < values.length; j++){
            //             System.out.println(values[j][0] +"\t"+values[j][1] +"\t"+values[j][2]);
            //}

            i--;
            for (; i <= plazaNo; i++) {
                
                sql = "SELECT * FROM toll_charge WHERE "
                        + "from_toll_plaza_id= " + session.getAttribute("tTollPlazaId") + " AND "
                        + "to_toll_plaza_id = " + i + " AND "
                        + "pass_id = " + session.getAttribute("tPassTypeId") + " AND "
                        + "vehicle_type_id = " + session.getAttribute("tVehicleTypeId") + " AND "
                        + "direction=1" + " AND "
                        + "effect_from='" + session.getAttribute("tDateEffect") + "';";

                rs = stmt.executeQuery(sql);
                if (rs.next()) {
                    sql = "DELETE FROM toll_charge WHERE "
                            + "from_toll_plaza_id= " + session.getAttribute("tTollPlazaId") + " AND "
                            + "to_toll_plaza_id = " + i + " AND "
                            + "pass_id = " + session.getAttribute("tPassTypeId") + " AND "
                            + "vehicle_type_id = " + session.getAttribute("tVehicleTypeId") + " AND "
                            + "direction=1" + " AND "
                            + "effect_from='" + session.getAttribute("tDateEffect") + "';";
                    stmt.executeUpdate(sql);
                }
     
                
                sql = "INSERT INTO toll_charge ("
                        + "from_toll_plaza_id,to_toll_plaza_id,pass_id,fare,vehicle_type_id,effect_from,direction)"
                        + " VALUES ("
                        + session.getAttribute("tTollPlazaId") + ", " + i + ", "
                        + session.getAttribute("tPassTypeId") + ", " + request.getParameter("fareBox" + (i)) + ", " + session.getAttribute("tVehicleTypeId") + ", '"
                        + session.getAttribute("tDateEffect") + "'"
                        + ",1)";
                stmt.executeUpdate(sql);

            }
            //for(int j = 0; j < values.length; j++){
            //             System.out.println(values[j][0] +"\t"+values[j][1] +"\t"+values[j][2]);
            //}

            session.setAttribute("tTollPlazaId", null);
            session.setAttribute("tPassTypeId", null);
            session.setAttribute("tVehicleTypeId", null);
            session.setAttribute("tDateEffect", null);

            response.sendRedirect("tariffResult.jsp?status=true");

        } catch (ClassNotFoundException ex) {
            response.sendRedirect("tariffResult.jsp");
            Logger.getLogger(UpdateTariff.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            response.sendRedirect("tariffResult.jsp");
            Logger.getLogger(UpdateTariff.class.getName()).log(Level.SEVERE, null, ex);
        }  catch (NullPointerException ex) {
            Logger.getLogger(UpdateTariff.class.getName()).log(Level.SEVERE, null, ex);
            response.sendRedirect("error.jsp");
        } catch (NumberFormatException ex) {
            Logger.getLogger(UpdateTariff.class.getName()).log(Level.SEVERE, null, ex);
            response.sendRedirect("error.jsp");
        } finally {
            try {
                if (stmt != null) {
                    stmt.close();
                }

            } catch (SQLException ex) {
                Logger.getLogger(UpdateTariff.class.getName()).log(Level.SEVERE, null, ex);
            }
            try {
                if (conn != null) {
                    conn.close();
                }
            } catch (SQLException ex) {
                Logger.getLogger(UpdateTariff.class.getName()).log(Level.SEVERE, null, ex);
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
