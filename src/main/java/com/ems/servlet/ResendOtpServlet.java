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

@WebServlet("/resendOtp")
public class ResendOtpServlet
extends HttpServlet {

    protected void doGet(
    HttpServletRequest request,
    HttpServletResponse response)
    throws ServletException,
    IOException {

        HttpSession session =
        request.getSession();

        String username =
        (String)session.getAttribute(
        "resetUsername"
        );

        if(username == null){

            response.sendRedirect(
            "forgotPassword.jsp"
            );

            return;

        }

        Employee emp =
        EmployeeDAO.getEmployeeByUsername(
        username
        );

        String otp =
        OtpGenerator.generateOtp();

        session.setAttribute(
        "otp",
        otp
        );

        session.setAttribute(
        "otpTime",
        System.currentTimeMillis()
        );

        MailUtil.sendEmail(

        emp.getEmail(),

        "Password Reset OTP",

        "Your new OTP is: " + otp

        );

        response.sendRedirect(
        "verifyOtp.jsp?resent=true"
        );

    }

}