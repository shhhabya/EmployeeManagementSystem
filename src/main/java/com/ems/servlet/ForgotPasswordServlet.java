package com.ems.servlet;

import java.io.IOException;

import com.ems.dao.EmployeeDAO;
import com.ems.model.Employee;
import com.ems.util.MailUtil;
import com.ems.util.OtpGenerator;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/forgotPassword")
public class ForgotPasswordServlet
extends HttpServlet {

    protected void doPost(
    HttpServletRequest request,
    HttpServletResponse response)
    throws ServletException,
    IOException {

        String username =
        request.getParameter(
        "username"
        );

        Employee emp =
        EmployeeDAO.getEmployeeByUsername(
        username
        );

        if(emp == null){

            response.sendRedirect(
            "forgotPassword.jsp?error=usernotfound"
            );

            return;
        }

        String otp =
        OtpGenerator.generateOtp();

        HttpSession session =
        request.getSession();

        session.setAttribute(
        "otp",
        otp
        );
        session.setAttribute(
        		"otpTime",
        		System.currentTimeMillis()
        		);
        
        
        session.setAttribute(
        "resetUsername",
        username
        );

        MailUtil.sendEmail(

        emp.getEmail(),

        "Password Reset OTP",

        "Your OTP is: " + otp

        );

        response.sendRedirect(
        "verifyOtp.jsp"
        );

    }

}