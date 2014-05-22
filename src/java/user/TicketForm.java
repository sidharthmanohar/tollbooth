package user;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
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
 * @author sidharth
 */
public class TicketForm extends HttpServlet {

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

            HttpSession session = request.getSession(false);
            String userID = (String) session.getAttribute("userID");
            String sql = "SELECT  toll_plaza_id FROM user_detail where user_id = '" + userID + "';";
            rs = stmt.executeQuery(sql);
            rs.next();
            String tollPlazaID = rs.getString("toll_plaza_id");
            rs.close();

            List<String> tollPlazaName = new ArrayList<String>();
            List<String> tollPlazaId = new ArrayList<String>();
            sql = "SELECT * FROM toll_plaza;";
            rs = stmt.executeQuery(sql);
            while (rs.next()) {

                tollPlazaId.add(rs.getString("toll_plaza_Id"));
                tollPlazaName.add(rs.getString("toll_plaza_name"));

            }
            rs.close();

            List<String> vehicleTypeId = new ArrayList<String>();
            List<String> vehicleType = new ArrayList<String>();
            sql = "SELECT * FROM vehicle_type;";
            rs = stmt.executeQuery(sql);
            while (rs.next()) {
                vehicleTypeId.add(rs.getString("vehicle_type_id"));
                vehicleType.add(rs.getString("vehicle_type"));
            }
            rs.close();

            List<String> passTypeId = new ArrayList<String>();
            List<String> passType = new ArrayList<String>();
            sql = "SELECT * FROM pass_type;";
            rs = stmt.executeQuery(sql);
            while (rs.next()) {
                passTypeId.add(rs.getString("pass_Id"));
                passType.add(rs.getString("pass_type"));
            }
            rs.close();

            request.setAttribute("tollPlazaId", tollPlazaId);
            request.setAttribute("tollPlazaName", tollPlazaName);
            request.setAttribute("vehicleTypeId", vehicleTypeId);
            request.setAttribute("vehicleType", vehicleType);
            request.setAttribute("passTypeId", passTypeId);
            request.setAttribute("passType", passType);

            RequestDispatcher dispatcher = servletContext.getRequestDispatcher("/user/ticketForm.jsp");
            dispatcher.forward(request, response);

        } catch (ClassNotFoundException ex) {
            Logger.getLogger(TicketForm.class.getName()).log(Level.SEVERE, null, ex);
            response.sendRedirect("/tollbooth/user/error.jsp");
        } catch (SQLException ex) {
            Logger.getLogger(TicketForm.class.getName()).log(Level.SEVERE, null, ex);
            response.sendRedirect("/tollbooth/user/error.jsp");
        } finally {
            try {
                if (stmt != null) {
                    stmt.close();
                }

            } catch (SQLException ex) {
                Logger.getLogger(TicketForm.class.getName()).log(Level.SEVERE, null, ex);
            }
            try {
                if (conn != null) {
                    conn.close();
                }
            } catch (SQLException ex) {
                Logger.getLogger(TicketForm.class.getName()).log(Level.SEVERE, null, ex);
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
