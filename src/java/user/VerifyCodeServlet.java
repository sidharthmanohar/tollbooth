package user;

/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;
import java.util.Calendar;
import java.util.Date;
import java.util.logging.Level;
import java.util.logging.Logger;
import java.sql.PreparedStatement;

/**
 *
 * @author Jasmine
 */
public class VerifyCodeServlet extends HttpServlet {

    public String barid;
    public Timestamp date_cur;
    public Timestamp date_tkt;
    public Timestamp date_exp;
    public String s;
    public Date dNow;
    public int cur;

    /**
     * Processes requests for both HTTP
     * <code>GET</code> and
     * <code>POST</code> methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException, Exception {

        response.setContentType("text/html;charset=UTF-8");
        barid = request.getParameter("bar_id");
        s= request.getParameter("toll_id");
        cur = Integer.parseInt(s);
        //PrintWriter out = response.getWriter();
        Connection conn = null;
        Statement stmt = null;
        ResultSet rs = null;
        try {
            //conn = ConnectionManager.getDatabaseConnection(request.getServletContext());
            stmt = conn.createStatement();

            String sql = "SELECT from_toll_plaza_id,to_toll_plaza_id,registration_time,pass_type FROM ticket WHERE barcode = '" + barid + "';";

            dNow = new Date();
            date_cur = new Timestamp(dNow.getTime());
            /*Calendar cal=Calendar.getInstance();
             cal.setTime(dNow);
             cal.add(Calendar.MINUTE, 1440);
             dNow=cal.getTime();
             date_cur =  Calendar.getInstance().getTime();
             int i;*/
            rs = stmt.executeQuery(sql);
            if (rs.next()) {
                date_tkt = rs.getTimestamp("registration_time");
                int pass = rs.getInt("pass_type");
                int src = rs.getInt("from_toll_plaza_id");
                int dest = rs.getInt("to_toll_plaza_id");
                Calendar cal = Calendar.getInstance();
                cal.setTimeInMillis(date_tkt.getTime());
                cal.add(Calendar.SECOND, 86400);
                date_exp = new Timestamp(cal.getTime().getTime());
                if ((cur > src && cur <= dest) || (cur > dest && cur < src)) {
                    if (pass == 1) {

                        //if(date_cur.after(date_tkt)&&date_cur.before(cur))
                        //i=date_cur.compareTo(dNow);
                        if (date_cur.after(date_tkt) && date_cur.before(date_exp)) {
                            response.sendRedirect("user/ticketValid.jsp");
                           // stmt.executeUpdate("INSERT INTO vehicle_tracking VALUES('" + barid + "''" + cur + "''" + date_cur + "')");
                            PreparedStatement p=conn.prepareStatement("INSERT INTO vehicle_tracking VALUES(?,?,?)");
                            p.setString(1, barid);
                            p.setInt(2, cur);
                            p.setTimestamp(3, date_cur);
                            p.executeUpdate();
                        } else {
                            response.sendRedirect("user/validateError.jsp");
                        }
                    } else if (pass == 2) {
                        //if(date_cur.after(date_tkt)&&date_cur.before())
                        if (date_cur.after(date_tkt) && date_cur.before(date_exp)) {
                            response.sendRedirect("user/ticketValid.jsp");
                            //stmt.executeUpdate("INSERT INTO vehicle_registry VALUES('" + barid + "''" + cur + "''" + date_cur + "')");
                             PreparedStatement p=conn.prepareStatement("INSERT INTO vehicle_tracking VALUES(?,?,?)");
                            p.setString(1, barid);
                            p.setInt(2, cur);
                            p.setTimestamp(3, date_cur);
                            p.executeUpdate();
                        } else {
                            response.sendRedirect("user/userHome.jsp");
                        }
                    } else {
                        response.sendRedirect("user/validateError.jsp");
                    }

                } else {
                    response.sendRedirect("user/validateError.jsp");
                }

            } else {
                response.sendRedirect("user/validateError.jsp");
            }
            /* TODO output your page here. You may use following sample code. */
            rs.close();
            stmt.close();
        } catch (SQLException ex) {
            Logger.getLogger(VerifyCodeServlet.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            try {
                if (stmt != null) {
                    stmt.close();
                }

            } catch (SQLException ex) {
                Logger.getLogger(VerifyCodeServlet.class.getName()).log(Level.SEVERE, null, ex);
            }
            try {
                if (conn != null) {
                    conn.close();
                }
            } catch (SQLException ex) {
                Logger.getLogger(VerifyCodeServlet.class.getName()).log(Level.SEVERE, null, ex);
            }

        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            processRequest(request, response);
        } catch (SQLException ex) {
            Logger.getLogger(VerifyCodeServlet.class.getName()).log(Level.SEVERE, null, ex);
        } catch (Exception ex) {
            Logger.getLogger(VerifyCodeServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            processRequest(request, response);
        } catch (SQLException ex) {
            Logger.getLogger(VerifyCodeServlet.class.getName()).log(Level.SEVERE, null, ex);
        } catch (Exception ex) {
            Logger.getLogger(VerifyCodeServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
}
