package com.ems.servlet;

import java.io.IOException;

import com.ems.dao.AnnouncementDAO;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/deleteAnnouncement")
public class DeleteAnnouncementServlet
extends HttpServlet{

    protected void doGet(
    HttpServletRequest request,
    HttpServletResponse response)
    throws IOException{

        int id =
        Integer.parseInt(
        request.getParameter("id")
        );

        AnnouncementDAO.deleteAnnouncement(
        id
        );

        response.sendRedirect(
        	"adminDashboard.jsp?announcementDeleted=true#announcements"
        );

    }

}