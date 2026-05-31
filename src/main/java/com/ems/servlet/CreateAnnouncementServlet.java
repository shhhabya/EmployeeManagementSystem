package com.ems.servlet;

import java.io.IOException;

import com.ems.dao.AnnouncementDAO;
import com.ems.model.Announcement;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/createAnnouncement")
public class CreateAnnouncementServlet
extends HttpServlet {

    protected void doPost(
    HttpServletRequest request,
    HttpServletResponse response)
    throws ServletException,
    IOException {

        String title =
        request.getParameter(
        "title"
        );

        String message =
        request.getParameter(
        "message"
        );
        
        String audienceType =
        		request.getParameter(
        		"audienceType"
        		);

        		String[] departments =
        		request.getParameterValues(
        		"departments"
        		);

        		String[] employeeIds =
        		request.getParameterValues(
        		"employeeIds"
        		);

        		String rangeFrom =
        		request.getParameter(
        		"rangeFrom"
        		);

        		String rangeTo =
        		request.getParameter(
        		"rangeTo"
        		);

        Announcement announcement =
        new Announcement();
        if(audienceType == null){

            audienceType = "ALL";

        }
        announcement.setTitle(
        title
        );

        announcement.setMessage(
        message
        );
        
        announcement.setAudienceType(
        		audienceType
        		);
        if(departments != null){

            announcement.setTargetDepartments(
            String.join(
            ",",
            departments
            )
            );

        }

        if(employeeIds != null){

            announcement.setTargetEmployeeIds(
            String.join(
            ",",
            employeeIds
            )
            );

        }

        if(rangeFrom != null
        && !rangeFrom.isEmpty()){

            announcement.setIdRangeFrom(
            Integer.parseInt(
            rangeFrom
            )
            );

        }

        if(rangeTo != null
        && !rangeTo.isEmpty()){

            announcement.setIdRangeTo(
            Integer.parseInt(
            rangeTo
            )
            );

        }
        AnnouncementDAO.addAnnouncement(
        announcement
        );

        response.sendRedirect(
        		"adminDashboard.jsp?announcement=success#announcements"
        );

    }

}