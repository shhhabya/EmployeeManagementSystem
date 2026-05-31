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
import com.ems.dao.EmployeeDAO;
import com.ems.model.Employee;
import com.ems.util.MailUtil;

@WebServlet("/resetPassword")
public class ResetPasswordServlet
extends HttpServlet {

    protected void doPost(
    HttpServletRequest request,
    HttpServletResponse response)
    throws ServletException,
    IOException {

        String password =
        request.getParameter(
        "newPassword"
        );

        String confirmPassword =
        request.getParameter(
        "confirmPassword"
        );

        if(!password.equals(
        confirmPassword
        )){

            response.sendRedirect(
            "resetPassword.jsp?error=nomatch"
            );

            return;

        }
        
        if(!password.matches(
        		"^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[@$!%*?&]).{8,}$"
        		)){

        		    response.sendRedirect(
        		    "resetPassword.jsp?error=weak"
        		    );

        		    return;

        		}

        HttpSession session =
        request.getSession();

        String username =
        (String)session.getAttribute(
        "resetUsername"
        );

        String encryptedPassword =
        PasswordUtil.hashPassword(
        password
        );

        boolean status =
        UserDAO.updatePassword(
        username,
        encryptedPassword
        );

        if(status){
        	Employee emp =
        			EmployeeDAO.getEmployeeByUsername(
        			username
        			);

        			MailUtil.sendEmail(

        			emp.getEmail(),

        			"Password Reset Successful",

        			"Hello "
        			+ emp.getName()
        			+ ",\n\nYour password was reset successfully.\n\nIf you did not perform this action, please contact your administrator immediately."

        			);
        	int employeeId =
        			UserDAO.getEmployeeIdByUsername(
        			username
        			);

        			NotificationDAO.addNotification(
        			employeeId,
        			"Password reset successfully"
        			);
        			
        			
            session.removeAttribute(
            "otp"
            );

            session.removeAttribute(
            "resetUsername"
            );

            response.sendRedirect(
            "login.jsp?reset=success"
            );

        }else{

            response.sendRedirect(
            "resetPassword.jsp?error=failed"
            );

        }

    }

}