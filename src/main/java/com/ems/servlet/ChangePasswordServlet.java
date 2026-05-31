package com.ems.servlet;

import java.io.IOException;

import com.ems.dao.UserDAO;
import com.ems.util.PasswordUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import com.ems.dao.NotificationDAO;
import com.ems.dao.AdminDAO;

@WebServlet("/changePassword")
public class ChangePasswordServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session =
                request.getSession(false);

        String username =
                (String) session.getAttribute("username");

        String currentPassword =
                request.getParameter("currentPassword");

        String newPassword =
                request.getParameter("newPassword");

        String confirmPassword =
                request.getParameter("confirmPassword");

        if(!newPassword.equals(confirmPassword)){

        	response.sendRedirect(
        			"admin".equals(session.getAttribute("role"))
        			? "adminDashboard.jsp?password=mismatch"
        			: "employeeDashboard.jsp?password=mismatch"
        			);

            return;
        }

        if(!newPassword.matches(
        		"^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[@$!%*?&]).{8,}$"
        		)){

        	response.sendRedirect(
        			"admin".equals(session.getAttribute("role"))
        			? "adminDashboard.jsp?password=weak"
        			: "employeeDashboard.jsp?password=weak"
        			);

        		    return;
        		}
        
        boolean isAdmin =
        		AdminDAO.getAdminByUsername(
        		username
        		) != null;

        		boolean valid;

        		if(isAdmin){

        		    valid =
        		    AdminDAO.verifyAdmin(
        		    username,
        		    PasswordUtil.hashPassword(
        		    currentPassword
        		    )
        		    );

        		}else{

        		    valid =
        		    UserDAO.verifyUser(
        		    username,
        		    PasswordUtil.hashPassword(
        		    currentPassword
        		    )
        		    );

        		}

        		if(!valid){

        		    response.sendRedirect(
        		    (isAdmin
        		    ? "adminDashboard.jsp"
        		    : "employeeDashboard.jsp")
        		    + "?password=wrongcurrent"
        		    );

        		    return;
        		}

        		boolean updated;

        		if(isAdmin){

        		    updated =
        		    AdminDAO.updatePassword(
        		    username,
        		    PasswordUtil.hashPassword(
        		    newPassword
        		    )
        		    );

        		}else{

        		    updated =
        		    UserDAO.updatePassword(
        		    username,
        		    PasswordUtil.hashPassword(
        		    newPassword
        		    )
        		    );

        		}

        if(updated){
        	UserDAO.disableFirstLogin(
        			username
        			);
        	session.removeAttribute(
        			"forcePasswordChange"
        			);
            int employeeId =
            UserDAO.getEmployeeIdByUsername(
            username
            );

            NotificationDAO.addNotification(
            employeeId,
            "Password changed successfully"
            );

            response.sendRedirect(
            		(isAdmin
            		? "adminDashboard.jsp"
            		: "employeeDashboard.jsp")
            		+ "?password=success"
            		);

        } else {

        	response.sendRedirect(
        			(isAdmin
        			? "adminDashboard.jsp"
        			: "employeeDashboard.jsp")
        			+ "?password=failed"
        			);

        }
    }
}