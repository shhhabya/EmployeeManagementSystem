package com.ems.servlet;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/verifyOtp")
public class VerifyOtpServlet
extends HttpServlet {

    protected void doPost(
    HttpServletRequest request,
    HttpServletResponse response)
    throws ServletException,
    IOException {

        String enteredOtp =
        request.getParameter(
        "otp"
        );

        HttpSession session =
        request.getSession();

        String actualOtp =
        (String)session.getAttribute(
        "otp"
        );
        Long otpTime =
        		(Long)session.getAttribute(
        		"otpTime"
        		);

        		if(otpTime == null){

        		    response.sendRedirect(
        		    "forgotPassword.jsp"
        		    );

        		    return;

        		}
        if(System.currentTimeMillis()
        		- otpTime
        		> 300000){

        		    response.sendRedirect(
        		    "verifyOtp.jsp?error=expired"
        		    );

        		    return;

        		}

        		if(actualOtp != null
        		&& actualOtp.equals(
        		enteredOtp
        		)){

        		    response.sendRedirect(
        		    "resetPassword.jsp"
        		    );
        		    session.removeAttribute(
        		    		"otp"
        		    		);

        		    		session.removeAttribute(
        		    		"otpTime"
        		    		);
        		}else{

        		    response.sendRedirect(
        		    "verifyOtp.jsp?error=invalid"
        		    );

        		}

    }

}