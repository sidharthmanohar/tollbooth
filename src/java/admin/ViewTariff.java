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
 * @author Murali
 */
public class ViewTariff extends HttpServlet {

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

            String values[][] = new String[plazaNo + 1][4];

            sql = "SELECT name FROM location WHERE location_id = "+(tollPlazaId + 1);
            rs = stmt.executeQuery(sql);
            rs.next();
            String fromLocation = rs.getString(1);

            int i;
            SimpleDateFormat simpleDateFormat = new SimpleDateFormat("dd-MM-yyyy");
            for (i = 1; i <= tollPlazaId; i++) {
                values[i - 1][0] = fromLocation;
                sql = "SELECT name FROM location WHERE location_id = " + i;
                rs = stmt.executeQuery(sql);
                rs.next();
                values[i - 1][1] = rs.getString(1);

                sql = "SELECT fare,effect_from FROM toll_charge WHERE "
                        + " from_toll_plaza_id = " + tollPlazaId
                        + " AND to_toll_plaza_id = " + i
                        + " AND effect_from <= '" + date + "' "
                        + " AND vehicle_type_id = " + vehicleTypeId
                        + " AND pass_id = " + passTypeId
                        + " AND direction = 2"
                        + " ORDER BY effect_from DESC;";
                rs = stmt.executeQuery(sql);
                
                if (rs.next()) {
                    values[i - 1][2] = rs.getString(1);
                    values[i - 1][3] = simpleDateFormat.format(rs.getDate(2));
                } else {
                    values[i - 1][2] = "NOT DATA FOUND";
                    values[i - 1][3] = "NO DATA FOUND";
                }

            }
            //for(int j = 0; j < values.length; j++){
            //            System.out.println(values[j][0] +"\t"+values[j][1] +"\t"+values[j][2]);
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

                sql = "SELECT fare,effect_from FROM toll_charge WHERE "
                        + " from_toll_plaza_id = " + tollPlazaId
                        + " AND to_toll_plaza_id = " + i
                        + " AND effect_from <= '" + date + "' "
                        + " AND vehicle_type_id = " + vehicleTypeId
                        + " AND pass_id = " + passTypeId
                        + " AND direction = 1"
                        + " ORDER BY effect_from DESC;";
                rs = stmt.executeQuery(sql);
              
                if (rs.next()) {
                    values[i][2] = rs.getString(1);
                    values[i][3] = simpleDateFormat.format(rs.getDate(2));
                } else {
                    values[i][2] = "NO DATA FOUND";
                    values[i][3] = "NO DATA FOUND";
                }
                
            }

            //for(int j = 0; j < values.length; j++){
            //             System.out.println(values[j][0] +"\t"+values[j][1] +"\t"+values[j][2]);
            //}
            request.setAttribute("tollPlazaName", tollPlazaName);
            request.setAttribute("vehicleType", vehicleType);
            request.setAttribute("passType", passType);
            request.setAttribute("date", new SimpleDateFormat("dd-MM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(date)));
            request.setAttribute("fareDetail", values);
            RequestDispatcher dispatcher = servletContext.getRequestDispatcher("/admin/viewTariff.jsp");
            dispatcher.forward(request, response);

        } catch (ClassNotFoundException ex) {
            Logger.getLogger(ViewTariff.class.getName()).log(Level.SEVERE, null, ex);
            response.sendRedirect("error.jsp");
        } catch (SQLException ex) {
            Logger.getLogger(ViewTariff.class.getName()).log(Level.SEVERE, null, ex);
            response.sendRedirect("error.jsp");
        } catch (NullPointerException ex) {
            Logger.getLogger(ViewTariff.class.getName()).log(Level.SEVERE, null, ex);
            response.sendRedirect("error.jsp");
        } catch (NumberFormatException ex) {
            Logger.getLogger(ViewTariff.class.getName()).log(Level.SEVERE, null, ex);
            response.sendRedirect("error.jsp");
        } catch (ParseException ex) {
            Logger.getLogger(ViewTariff.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            try {
                if (stmt != null) {
                    stmt.close();
                }

            } catch (SQLException ex) {
                Logger.getLogger(ViewTariff.class.getName()).log(Level.SEVERE, null, ex);
            }
            try {
                if (conn != null) {
                    conn.close();
                }
            } catch (SQLException ex) {
                Logger.getLogger(ViewTariff.class.getName()).log(Level.SEVERE, null, ex);
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
