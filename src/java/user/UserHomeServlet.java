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
import java.util.Properties;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.RequestDispatcher;
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
@WebServlet(name = "UserHomeServlet", urlPatterns = {"/user/UserHomeServlet"})
public class UserHomeServlet extends HttpServlet {

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

            HttpSession session = request.getSession(true);
            String userID = (String) session.getAttribute("userID");

            String sql = "SELECT tollbooth_no, toll_plaza_name,u.lane FROM user_detail u ,toll_plaza t where user_id = '" + userID + "' AND t.toll_plaza_id = u.toll_plaza_id;";
            rs = stmt.executeQuery(sql);
            rs.next();
            int lane = rs.getInt("lane");
            System.out.println(lane);
            session.setAttribute("tollBoothNo", rs.getString("tollbooth_no"));
            session.setAttribute("tollPlazaName", rs.getString("toll_plaza_name"));

            rs.close();
            String order;
            if (lane == 1) {
               order = "DESC";
            }else{
                order = "ASC";
            }

            sql = "SELECT toll_plaza_name FROM toll_plaza ORDER BY toll_plaza_id "+order;
            rs = stmt.executeQuery(sql);
            rs.next();
            
            session.setAttribute("direction", rs.getString("toll_plaza_name"));
            
            RequestDispatcher dispatcher = servletContext.getRequestDispatcher("/user/userHome.jsp");
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
