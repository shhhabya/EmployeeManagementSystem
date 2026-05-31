package com.ems.servlet;

import java.io.File;
import java.io.IOException;

import com.ems.dao.EmployeeDAO;
import com.ems.dao.UserDAO;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import com.ems.dao.AdminDAO;
import com.ems.model.Admin;
@WebServlet("/uploadProfilePicture")
@MultipartConfig
public class UploadProfilePictureServlet
extends HttpServlet {

    protected void doPost(
    HttpServletRequest request,
    HttpServletResponse response)
    throws ServletException,
    IOException {

        HttpSession session =
        request.getSession();

        String username =
        		(String)session.getAttribute(
        		"username"
        		);

        		String role =
        				(String)session.getAttribute(
        				"role"
        				);

        				boolean isAdmin =
        				"admin".equals(role);

        				

        		int employeeId = -1;

        		if(!isAdmin){

        		    employeeId =
        		    UserDAO.getEmployeeIdByUsername(
        		    username
        		    );

        		}

        Part filePart =
        request.getPart(
        "profilePicture"
        );

        String fileName;

        if(isAdmin){

            fileName =
            "admin_"
            + filePart.getSubmittedFileName();

        }else{

            fileName =
            employeeId + "_"
            + filePart.getSubmittedFileName();

        }

        String uploadPath =
        		getServletContext().getRealPath(
        		"/uploads"
        		);

        File uploadDir =
        new File(uploadPath);

        if(!uploadDir.exists()){

        	uploadDir.mkdirs();

        }
        		
        filePart.write(
        uploadPath
        + File.separator
        + fileName
        );

        if(isAdmin){

            AdminDAO.updateProfilePicture(
            username,
            fileName
            );

            response.sendRedirect(
            "adminDashboard.jsp?picture=uploaded"
            );

        }else{

            EmployeeDAO.updateProfilePicture(
            employeeId,
            fileName
            );

            response.sendRedirect(
            "employeeDashboard.jsp?picture=uploaded"
            );

        }

    }

}