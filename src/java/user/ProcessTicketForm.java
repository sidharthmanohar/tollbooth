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
import java.util.Calendar;
import java.util.Date;

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

            //get boothNo
            sql = "SELECT tollbooth_no, toll_plaza_id FROM user_detail where user_id = '" + userID + "';";
            rs = stmt.executeQuery(sql);
            rs.next();
            String fromTollPlazaId = rs.getString("toll_plaza_id");
            String boothNo = rs.getString("tollbooth_no");
            rs.close();

            //get fromDestination
            sql = "SELECT toll_plaza_name FROM toll_plaza where "
                    + "toll_plaza_id = " + fromTollPlazaId + ";";
            rs = stmt.executeQuery(sql);
            rs.next();
            fromDestination = rs.getString("toll_plaza_name");
            rs.close();

            //get toDestination
            sql = "SELECT toll_plaza_name FROM toll_plaza where "
                    + "toll_plaza_id = " + toTollPlazaId + ";";
            rs = stmt.executeQuery(sql);
            rs.next();
            toDestination = rs.getString("toll_plaza_name");
            rs.close();

            //get vehicle_type
            sql = "SELECT vehicle_type FROM vehicle_type where "
                    + "vehicle_type_id = " + vehicleTypeId + ";";
            rs = stmt.executeQuery(sql);
            rs.next();
            vehicleType = rs.getString("vehicle_type");
            rs.close();

            //get pass_type
            System.out.println(passTypeId);
            sql = "SELECT pass_type FROM pass_type where "
                    + "pass_id = " + passTypeId + ";";
            rs = stmt.executeQuery(sql);
            rs.next();
            passType = rs.getString("pass_type");
            rs.close();

            double fare = 0;
            sql = "SELECT fare FROM toll_charge WHERE "
                    + " from_toll_plaza_id = " + fromTollPlazaId
                    + " AND to_toll_plaza_id = " + toTollPlazaId
                    + " AND effect_from <= CURDATE() "
                    + " AND vehicle_type_id = " + vehicleTypeId
                    + " AND pass_id = " + passTypeId
                    + " ORDER BY effect_from DESC;";
            rs = stmt.executeQuery(sql);
            if (rs.next()) {
                fare = Double.parseDouble(rs.getString("fare"));
            } else {
                //error no entry found!!!
            }

            //barcode encoding
            String barcode = "";
            barcode += fromTollPlazaId;
            barcode += boothNo;
            barcode += Long.toString(System.currentTimeMillis()/1000);
            
            Timestamp timeStamp = new Timestamp(System.currentTimeMillis());

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
                    + "'" + timeStamp + "' );";
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
            session.setAttribute("timeStamp", timeStamp);
            //RequestDispatcher dispatcher = servletContext.getRequestDispatcher("/user/printTicket.jsp");
            //dispatcher.forward(request, response);
            response.sendRedirect("/tollbooth/user/printTicket.jsp");

        } catch (ClassNotFoundException ex) {
            Logger.getLogger(ProcessTicketForm.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(ProcessTicketForm.class.getName()).log(Level.SEVERE, null, ex);
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
