package com.ems.servlet;

import java.io.File;
import java.io.IOException;

import com.ems.dao.EmployeeDAO;
import com.ems.dao.UserDAO;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import com.ems.dao.AdminDAO;
import com.ems.model.Admin;
@WebServlet("/deleteProfilePicture")
public class DeleteProfilePictureServlet
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

        		Admin admin = null;

        		if(isAdmin){

        		    admin =
        		    AdminDAO.getAdminByUsername(
        		    username
        		    );

        		}

        		String fileName;

        		int employeeId = -1;

        		if(isAdmin){

        		    fileName =
        		    admin.getProfilePicture();

        		}else{

        		    employeeId =
        		    UserDAO.getEmployeeIdByUsername(
        		    username
        		    );

        		    fileName =
        		    EmployeeDAO.getProfilePicture(
        		    employeeId
        		    );

        		}

        if(fileName != null){

        	String uploadPath =
        			getServletContext().getRealPath(
        			"/uploads"
        			);

        			File imageFile =
        			new File(
        			uploadPath
        			+ File.separator
        			+ fileName
        			);

            if(imageFile.exists()){

                imageFile.delete();

            }

        }

        if(isAdmin){

            AdminDAO.removeProfilePicture(
            username
            );

            response.sendRedirect(
            "adminDashboard.jsp?picture=deleted"
            );

        }else{

            EmployeeDAO.removeProfilePicture(
            employeeId
            );

            response.sendRedirect(
            "employeeDashboard.jsp?picture=deleted"
            );

        }

    }

}