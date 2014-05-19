/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package user;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;
import java.util.Calendar;
import java.util.Properties;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author Sidharth
 */
@WebServlet(name = "VerifyTicket", urlPatterns = {"/userVerifyTicket"})
public class VerifyTicket extends HttpServlet {

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
        //load properties file
        //System.out.println("Called VerifyTicket");
        ServletContext servletContext = request.getServletContext();
        String propertiesFilePath = servletContext.getRealPath("WEB-INF/tollbooth.properties");
        Properties properties = new Properties();
        properties.load(new FileInputStream(new File(propertiesFilePath)));

        Connection conn = null;
        Statement stmt = null;
        ResultSet rs = null;

        try {
            Class.forName(properties.getProperty("sqldriver"));
            conn = DriverManager.getConnection(
                    properties.getProperty("sqlurl"),
                    properties.getProperty("sqluser"),
                    properties.getProperty("sqlpassword"));
            stmt = conn.createStatement();

            //Finding current tollPlazaID
            HttpSession session = request.getSession(false);
            String userID = (String) session.getAttribute("userID");
            String sql = "SELECT  toll_plaza_id,lane,tollbooth_no FROM user_detail where user_id = '" + userID + "';";
            rs = stmt.executeQuery(sql);
            rs.next();
            String tollPlazaID = rs.getString("toll_plaza_id");
            int currentLane = rs.getInt("lane");
            int cur = Integer.parseInt(tollPlazaID);
            int boothNo = rs.getInt("tollbooth_no");
            rs.close();

            String barcode = request.getParameter("barcode");
            barcode = barcode.trim();
            //------start-----------//
            sql = "SELECT MAX(registration_time) FROM vehicle_tracking WHERE barcode='" + barcode + "' AND toll_plaza_id=" + tollPlazaID + " AND booth_no=" + boothNo;
            rs = stmt.executeQuery(sql);
            rs.next();
            Timestamp regTime = rs.getTimestamp(1);
            Timestamp now = new Timestamp(System.currentTimeMillis() - 600000);
            System.out.println(now);
            if (regTime != null && regTime.after(now)) {
                //user is validating same barcode within 10 min
                response.sendRedirect("validateResult.jsp?valid=true");
            } else {
                sql = "SELECT from_toll_plaza_id,to_toll_plaza_id,registration_time,pass_type,validity FROM ticket WHERE barcode = '" + barcode + "';";
                rs = stmt.executeQuery(sql);
                // System.out.println(barcode);
                if (rs.next()) {
                    Timestamp date_tkt = rs.getTimestamp("registration_time");
                    int pass = rs.getInt("pass_type");
                    int src = rs.getInt("from_toll_plaza_id");
                    int dest = rs.getInt("to_toll_plaza_id");
                    Timestamp date_exp = rs.getTimestamp("validity");
                    Timestamp cur_date = new Timestamp(System.currentTimeMillis());

                    if (cur_date.before(date_exp)) {
                        if (pass == 1) {
                            String order = (src < dest) ? "MAX" : "MIN";
                            int lane = (src < dest) ? 1 : 2;
                        //lane 1 is from 1 to 5
                            //lane 2 is from 5 to 1                    
                            sql = "SELECT " + order + "(toll_plaza_id) FROM vehicle_tracking WHERE barcode='" + barcode + "'";
                            rs = stmt.executeQuery(sql);
                            rs.next();
                            int plazaRecenttlyReached = rs.getInt(1);

                            if (currentLane == lane) {
                                if (lane == 1) {
                                    if (cur > src && cur <= dest && cur > plazaRecenttlyReached) {
                                        updateVehicleTracking(stmt, barcode, cur, boothNo);
                                        response.sendRedirect("validateResult.jsp?valid=true");
                                    } else {
                                    //already passed this gate
                                        // System.out.println("already passes this gate");
                                        response.sendRedirect("validateResult.jsp?valid=false");
                                    }
                                } else {
                                    if (cur < src && cur >= dest && cur < plazaRecenttlyReached) {
                                        updateVehicleTracking(stmt, barcode, cur, boothNo);
                                        response.sendRedirect("validateResult.jsp?valid=true");
                                    } else {
                                    //already passes this gate
                                        //System.out.println("already passed this gate");
                                        response.sendRedirect("validateResult.jsp?valid=false");
                                    }
                                }
                            } else {
                                //vehicle is returning with one way pass
                                response.sendRedirect("validateResult.jsp?valid=false");
                            }

                        } else if (pass == 2) {
                            if (cur >= src && cur <= dest || cur <= src && cur >= dest) {
                                sql = "SELECT count(*) FROM vehicle_tracking WHERE barcode='" + barcode + "' AND toll_plaza_id=" + tollPlazaID;
                                rs = stmt.executeQuery(sql);
                                rs.next();
                                int count = rs.getInt(1);

                                if (count == 0) {
                                    updateVehicleTracking(stmt, barcode, cur, boothNo);
                                    response.sendRedirect("validateResult.jsp?valid=true");
                                } else if (count == 1) {
                                    sql = "SELECT booth_no FROM vehicle_tracking WHERE barcode='" + barcode + "' AND toll_plaza_id=" + tollPlazaID;
                                    rs = stmt.executeQuery(sql);
                                    rs.next();
                                    int previousLane = rs.getInt(1);
                                    if (previousLane != currentLane) {
                                        updateVehicleTracking(stmt, barcode, cur, boothNo);
                                        response.sendRedirect("validateResult.jsp?valid=true");
                                    } else {
                                        //  System.out.println("Vehicle is re-entering");
                                        response.sendRedirect("validateResult.jsp?valid=false");
                                    }

                                } else {
                                    // System.out.println("Vehicle is re-entering");
                                    response.sendRedirect("validateResult.jsp?valid=false");
                                }
                            } else {
                                //   System.out.println("Vehicle out of range");
                                response.sendRedirect("validateResult.jsp?valid=false");
                            }

                        } else if (pass == 3) {
                            if (cur >= src && cur <= dest || cur <= src && cur >= dest) {

                                Calendar expCal = Calendar.getInstance();
                                expCal.setTimeInMillis(date_exp.getTime());
                                Calendar curCal = Calendar.getInstance();

                                if (curCal.get(Calendar.MONTH) == expCal.get(Calendar.MONTH) && curCal.get(Calendar.YEAR) == expCal.get(Calendar.YEAR)) {
                                    updateVehicleTracking(stmt, barcode, cur, boothNo);
                                    response.sendRedirect("validateResult.jsp?valid=true");
                                } else {
                                    //   System.out.println("Time Expired");
                                    response.sendRedirect("validateResult.jsp?valid=false");
                                }
                            } else {
                                //    System.out.println("Vehicle out of range");
                                response.sendRedirect("validateResult.jsp?valid=false");
                            }

                        } else {
                            //no such pass
                        }

                    } else {
                        //Ticket has expired
                        response.sendRedirect("validateResult.jsp?valid=false");
                    }

                } else {
                //invalid barcode
                    // System.out.println("Invalid barcode");
                    response.sendRedirect("validateResult.jsp?valid=false");
                }

            }

        } catch (SQLException ex) {
            Logger.getLogger(VerifyTicket.class.getName()).log(Level.SEVERE, null, ex);
            response.sendRedirect("/tollbooth/user/error.jsp");
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(VerifyTicket.class.getName()).log(Level.SEVERE, null, ex);
            response.sendRedirect("/tollbooth/user/error.jsp");
        } finally {
            try {
                if (stmt != null) {
                    stmt.close();
                }

            } catch (SQLException ex) {
                Logger.getLogger(VerifyTicket.class.getName()).log(Level.SEVERE, null, ex);
            }
            try {
                if (conn != null) {
                    conn.close();
                }
            } catch (SQLException ex) {
                Logger.getLogger(VerifyTicket.class.getName()).log(Level.SEVERE, null, ex);
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

    private void updateVehicleTracking(Statement stmt, String barcode, int tollPlazaID, int boothNo) throws SQLException {
        String sql = "INSERT INTO vehicle_tracking VALUES ("
                + "'" + barcode + "', "
                + tollPlazaID + ", "
                + "'" + new Timestamp(System.currentTimeMillis()) + "',"
                + boothNo + ")";
        stmt.executeUpdate(sql);

    }
}
