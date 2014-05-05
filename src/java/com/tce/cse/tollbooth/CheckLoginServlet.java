/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package com.tce.cse.tollbooth;

import java.io.IOException;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author sidharth
 */

public class CheckLoginServlet extends HttpServlet {
    public String userID;
    public String password;
    public String userType;
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

        //form values from login.jsp
        userID = request.getParameter("username");
        password = request.getParameter("password");

        //load properties file
        

        Connection conn = null;
        Statement stmt = null;
        ResultSet rs = null;
        try {
            conn = ConnectionManager.getDatabaseConnection(request.getServletContext());
            stmt = conn.createStatement();

            String sql = "SELECT * FROM user_detail WHERE user_id = '"+userID+"';";

            rs = stmt.executeQuery(sql);

            if (rs.next()) {
                if (rs.getString("password").trim().equals(password)) {

                    HttpSession session = request.getSession(true);
                    session.setAttribute("user", this);

                    if (rs.getString("user_type").equals("1")) {
                        response.sendRedirect("admin/adminHome.jsp");
                    } else {
                        response.sendRedirect("user/userHome.jsp");
                    }
                } else {
                    response.sendRedirect("login.jsp?error=invalidPassword");
                }
            } else {
                response.sendRedirect("login.jsp?error=invalidUser");
            }
            rs.close();

        }
        catch (SQLException ex) {
            Logger.getLogger(CheckLoginServlet.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            try {
                if (stmt != null) {
                    stmt.close();
                }

            } catch (SQLException ex) {
                Logger.getLogger(CheckLoginServlet.class.getName()).log(Level.SEVERE, null, ex);
            }
            try {
                if (conn != null) {
                    conn.close();
                }
            } catch (SQLException ex) {
                Logger.getLogger(CheckLoginServlet.class.getName()).log(Level.SEVERE, null, ex);
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