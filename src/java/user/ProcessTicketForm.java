package user;

import java.io.File;
import java.io.FileInputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;
import java.util.Properties;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import org.apache.tomcat.jni.Time;

/**
 *
 * @author sidharth
 */
public class ProcessTicketForm extends HttpServlet {

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
        //response.setContentType("application/pdf");
        HttpSession session = request.getSession(false);

        String toTollPlazaId = request.getParameter("toDestination");
        String vehicleTypeId = request.getParameter("vehicleType");
        String passTypeId = request.getParameter("passType");
        String vehicleNo = request.getParameter("vehicleNo");

        //load properties file
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

            String fromDestination = null, toDestination = null, vehicleType = null, passType = null, sql;

            String userID = (String) session.getAttribute("userID");

            //get boothNo and lane/direction
            sql = "SELECT tollbooth_no, toll_plaza_id,lane FROM user_detail where user_id = '" + userID + "';";
            rs = stmt.executeQuery(sql);
            rs.next();
            String fromTollPlazaId = rs.getString("toll_plaza_id");
            String boothNo = rs.getString("tollbooth_no");
            int direction = rs.getInt("lane");
            rs.close();

            //get fromDestination
            sql = "SELECT toll_plaza_name FROM toll_plaza where "
                    + "toll_plaza_id = " + fromTollPlazaId + ";";
            rs = stmt.executeQuery(sql);
            rs.next();
            fromDestination = rs.getString("toll_plaza_name");
            rs.close();

            //get toDestination
            if (direction == 1) {
                sql = "SELECT name FROM location WHERE "
                        + "location_id = " + (Integer.parseInt(toTollPlazaId) + 1) + ";";
            } else {
                sql = "SELECT name FROM location WHERE "
                        + "location_id = " + toTollPlazaId + ";";
            }
            System.out.println(sql);
            //sql = "SELECT toll_plaza_name FROM toll_plaza where "
            //        + "toll_plaza_id = " + toTollPlazaId + ";";
            rs = stmt.executeQuery(sql);
            rs.next();
            toDestination = rs.getString(1);
            rs.close();

            //get vehicle_type
            sql = "SELECT vehicle_type FROM vehicle_type where "
                    + "vehicle_type_id = " + vehicleTypeId + ";";
            rs = stmt.executeQuery(sql);
            rs.next();
            vehicleType = rs.getString("vehicle_type");
            rs.close();

            //get pass_type
            sql = "SELECT pass_type FROM pass_type where "
                    + "pass_id = " + passTypeId + ";";
            rs = stmt.executeQuery(sql);
            rs.next();
            passType = rs.getString("pass_type");
            rs.close();

            //finding fare
            double fare = 0;
            if (passTypeId.equals("1")) {
                sql = "SELECT fare FROM toll_charge WHERE "
                        + " from_toll_plaza_id = " + fromTollPlazaId
                        + " AND to_toll_plaza_id = " + toTollPlazaId
                        + " AND effect_from <= CURDATE() "
                        + " AND vehicle_type_id = " + vehicleTypeId
                        + " AND pass_id = " + passTypeId
                        + " AND direction = " + direction
                        + " ORDER BY effect_from DESC;";
                rs = stmt.executeQuery(sql);
                rs.next();
                fare = Double.parseDouble(rs.getString("fare"));

            } else if (passTypeId.equals("2")) {
                sql = "SELECT fare FROM toll_charge WHERE "
                        + " from_toll_plaza_id = " + fromTollPlazaId
                        + " AND to_toll_plaza_id = " + toTollPlazaId
                        + " AND effect_from <= CURDATE() "
                        + " AND vehicle_type_id = " + vehicleTypeId
                        + " AND pass_id = 1"
                        + " AND direction = " + direction
                        + " ORDER BY effect_from DESC;";
                rs = stmt.executeQuery(sql);
                rs.next();
                fare = Double.parseDouble(rs.getString("fare"));

                int oppositeDirection = (direction == 1) ? 2 : 1;
                sql = "SELECT fare FROM toll_charge WHERE "
                        + " from_toll_plaza_id = " + toTollPlazaId
                        + " AND to_toll_plaza_id = " + fromTollPlazaId
                        + " AND effect_from <= CURDATE() "
                        + " AND vehicle_type_id = " + vehicleTypeId
                        + " AND pass_id = 1"
                        + " AND direction = " + oppositeDirection
                        + " ORDER BY effect_from DESC;";
                rs = stmt.executeQuery(sql);
                rs.next();
                fare += Double.parseDouble(rs.getString("fare"));
            } else if (passTypeId.equals("3")) {
                sql = "SELECT fare FROM toll_charge WHERE "
                        + " from_toll_plaza_id = " + fromTollPlazaId
                        + " AND to_toll_plaza_id = " + toTollPlazaId
                        + " AND effect_from <= CURDATE() "
                        + " AND vehicle_type_id = " + vehicleTypeId
                        + " AND pass_id = 1"
                        + " AND direction = " + direction
                        + " ORDER BY effect_from DESC;";
                rs = stmt.executeQuery(sql);
                rs.next();
                fare = Double.parseDouble(rs.getString("fare"));
                fare *= 3;
            } else if (passTypeId.equals("4")) {

                sql = "SELECT fare FROM toll_charge WHERE "
                        + " from_toll_plaza_id = " + fromTollPlazaId
                        + " AND to_toll_plaza_id = " + toTollPlazaId
                        + " AND effect_from <= CURDATE() "
                        + " AND vehicle_type_id = " + vehicleTypeId
                        + " AND pass_id = 1"
                        + " AND direction = " + direction
                        + " ORDER BY effect_from DESC;";
                rs = stmt.executeQuery(sql);
                rs.next();
                fare = Double.parseDouble(rs.getString("fare"));

                int oppositeDirection = (direction == 1) ? 2 : 1;
                sql = "SELECT fare FROM toll_charge WHERE "
                        + " from_toll_plaza_id = " + toTollPlazaId
                        + " AND to_toll_plaza_id = " + fromTollPlazaId
                        + " AND effect_from <= CURDATE() "
                        + " AND vehicle_type_id = " + vehicleTypeId
                        + " AND pass_id = 1"
                        + " AND direction = " + oppositeDirection
                        + " ORDER BY effect_from DESC;";
                rs = stmt.executeQuery(sql);
                rs.next();
                fare += Double.parseDouble(rs.getString("fare"));

                Calendar cal = Calendar.getInstance();
                cal.set(Calendar.MONTH, Integer.parseInt(request.getParameter("month")));
                cal.set(Calendar.YEAR, Integer.parseInt(request.getParameter("year")));

                if (cal.get(Calendar.YEAR) < Calendar.getInstance().get(Calendar.YEAR)) {
                    throw new Exception("Illegal request");
                } else {
                    if (cal.get(Calendar.YEAR) == Calendar.getInstance().get(Calendar.YEAR) && cal.get(Calendar.MONTH) < Calendar.getInstance().get(Calendar.MONTH)) {
                        throw new Exception("Illegal request");
                    }
                }

                fare *= cal.getActualMaximum(Calendar.DAY_OF_MONTH);
            } else {
                //no pass functionality defined
            }

            //barcode encoding
            String barcode = "";
            barcode += fromTollPlazaId;
            barcode += boothNo;
            barcode += Long.toString(System.currentTimeMillis() / 1000);

            long time = System.currentTimeMillis();
            Calendar calender = Calendar.getInstance();

            Timestamp timeStamp = new Timestamp(calender.getTimeInMillis());
            Timestamp validity = null;
            String validityDate = "";
            if (Integer.parseInt(passTypeId) == 1 || Integer.parseInt(passTypeId) == 2 || Integer.parseInt(passTypeId) == 3) {
                validity = new Timestamp(time + 86400000);
                Calendar cValidity = Calendar.getInstance();
                cValidity.setTime(validity);
                validityDate += "till "+cValidity.get(Calendar.DAY_OF_MONTH) + "/" + (cValidity.get(Calendar.MONTH) + 1) + "/" + cValidity.get(Calendar.YEAR) + " " + String.format("%02d", cValidity.get(Calendar.HOUR_OF_DAY)) + ":" + String.format("%02d", cValidity.get(Calendar.MINUTE));
            } else if (Integer.parseInt(passTypeId) == 4) {
                Calendar calValidity = Calendar.getInstance();
                calValidity.set(Calendar.MONTH, Integer.parseInt((String) request.getParameter("month")));
                calValidity.set(Calendar.YEAR, Integer.parseInt((String) request.getParameter("year")));
                calValidity.set(Calendar.DAY_OF_MONTH, calValidity.getActualMaximum(Calendar.DAY_OF_MONTH));
                calValidity.set(Calendar.HOUR_OF_DAY, 23);
                calValidity.set(Calendar.MINUTE, 59);
                calValidity.set(Calendar.SECOND, 59);
                validity = new Timestamp(calValidity.getTimeInMillis());
                
                Calendar cValidity = Calendar.getInstance();
                cValidity.setTime(validity);
                validityDate += "During "+new SimpleDateFormat("MMM/yyyy").format(cValidity.getTime());
            }

            //get last ticket no
            sql = "SELECT MAX(CONVERT(SUBSTRING(ticket_no,6),UNSIGNED INTEGER)) FROM ticket WHERE tollbooth_id = " + boothNo + " AND from_toll_plaza_id = " + fromTollPlazaId;
            rs = stmt.executeQuery(sql);
            long ticketNo = 0;
            if (rs.next()) {
                String prevTicketNo = rs.getString(1);
                if (prevTicketNo != null) {
                    ticketNo = Long.parseLong(prevTicketNo);
                }
            }
            ticketNo++;
            String newTicketNo = "T" + fromTollPlazaId + "B" + boothNo + "-" + ticketNo;

            //enter details in databse         
            sql = "INSERT INTO ticket VALUES ("
                    + " '" + barcode + "' ,"
                    + fromTollPlazaId + ","
                    + toTollPlazaId + ","
                    + boothNo + ","
                    + passTypeId + ","
                    + "'" + vehicleNo + "',"
                    + vehicleTypeId + ","
                    + fare + ", "
                    + "'" + timeStamp + "', '"
                    + newTicketNo + "', '" + validity + "');";
            stmt.executeUpdate(sql);
            //update vehicle_tracking table
            sql = "INSERT INTO `vehicle_tracking` VALUES ('"
                    + barcode + "',"
                    + fromTollPlazaId + ","
                    + " '" + timeStamp + "', "
                    + boothNo + ");";
            stmt.executeUpdate(sql);

            session.setAttribute("fromDestination", fromDestination);
            session.setAttribute("toDestination", toDestination);
            session.setAttribute("vehicleType", vehicleType);
            session.setAttribute("passType", passType);
            session.setAttribute("vehicleNo", vehicleNo);
            session.setAttribute("fare", fare);
            session.setAttribute("barcodeNo", barcode);
            session.setAttribute("boothNo", boothNo);
            session.setAttribute("ticketNo", newTicketNo);
            session.setAttribute("validity",validityDate );
            session.setAttribute("date", calender.get(Calendar.DAY_OF_MONTH) + "/" + (calender.get(Calendar.MONTH) + 1) + "/" + calender.get(Calendar.YEAR) + " " + String.format("%02d", calender.get(Calendar.HOUR_OF_DAY)) + ":" + String.format("%02d", calender.get(Calendar.MINUTE)));

            response.sendRedirect("/tollbooth/user/printTicket.jsp");

        } catch (ClassNotFoundException ex) {
            Logger.getLogger(ProcessTicketForm.class.getName()).log(Level.SEVERE, null, ex);
            response.sendRedirect("/tollbooth/user/error.jsp");
        } catch (SQLException ex) {
            Logger.getLogger(ProcessTicketForm.class.getName()).log(Level.SEVERE, null, ex);
            response.sendRedirect("/tollbooth/user/error.jsp");
        } catch (Exception ex) {
            Logger.getLogger(ProcessTicketForm.class.getName()).log(Level.SEVERE, null, ex);
            response.sendRedirect("/tollbooth/user/error.jsp");
        } finally {
            try {
                if (stmt != null) {
                    stmt.close();
                }

            } catch (SQLException ex) {
                Logger.getLogger(ProcessTicketForm.class.getName()).log(Level.SEVERE, null, ex);
            }
            try {
                if (conn != null) {
                    conn.close();
                }
            } catch (SQLException ex) {
                Logger.getLogger(ProcessTicketForm.class.getName()).log(Level.SEVERE, null, ex);
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
