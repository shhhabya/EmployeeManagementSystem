package com.ems.servlet;

import com.ems.util.DBConnection;
import jakarta.servlet.http.HttpSession;
import com.ems.util.PasswordUtil;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import com.ems.dao.UserDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import com.ems.dao.AdminDAO;
import com.ems.model.Admin;
@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    	
        response.setContentType("text/html");


        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String encryptedPassword =
        		PasswordUtil.hashPassword(
        		password
        		);
        Admin admin =
        		AdminDAO.validateAdmin(
        		username,
        		encryptedPassword
        		);

        try {

        	if(admin != null){        		
        	    HttpSession session =
        	    request.getSession();

        	    session.setAttribute(
        	    		"username",
        	    		username
        	    		);

        	    		session.setAttribute(
        	    		"role",
        	    		"admin"
        	    		);

        	    response.sendRedirect(
        	    "adminDashboard.jsp"
        	    );

        	    return;

        	}

        	Connection con =
        	DBConnection.getConnection();

        	String query =
        	"SELECT * FROM users WHERE username=? AND password=?";

        	PreparedStatement ps =
        	con.prepareStatement(query);

        	ps.setString(
        	1,
        	username
        	);

        	ps.setString(
        	2,
        	encryptedPassword
        	);

        	ResultSet rs =
        	ps.executeQuery();

        	if(rs.next()){
            	
            	
                String role =
                rs.getString("role");

                HttpSession session =
                request.getSession();

                session.setAttribute(
                "username",
                username
                );

                session.setAttribute(
                "role",
                role
                );
                
                UserDAO.updateLastLogin(
                		username
                		);

                if(role.equals("admin")){

                    response.sendRedirect(
                    "adminDashboard.jsp"
                    );

                }else if(role.equals("employee")){

                    if(UserDAO.isFirstLogin(
                       username
                       )){
                    	session.setAttribute(
                    			"forcePasswordChange",
                    			true
                    			);
                        response.sendRedirect(
                        "employeeDashboard.jsp?firstLogin=true"
                        );

                    }else{

                        response.sendRedirect(
                        "employeeDashboard.jsp"
                        );

                    }

                }

            } else {
                response.sendRedirect(
                "login.jsp?error=invalid"
                );

            }

        } catch(Exception e) {

            e.printStackTrace();

        }

    }
    

}