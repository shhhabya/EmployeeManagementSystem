package com.ems.servlet;

import java.io.IOException;

import com.ems.dao.AnnouncementDAO;
import com.ems.model.Announcement;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/updateAnnouncement")
public class UpdateAnnouncementServlet
extends HttpServlet {

    protected void doPost(
    HttpServletRequest request,
    HttpServletResponse response)
    throws ServletException,
    IOException {

        int id =
        Integer.parseInt(
        request.getParameter(
        "id"
        )
        );

        String title =
        request.getParameter(
        "title"
        );

        String message =
        request.getParameter(
        "message"
        );

        Announcement announcement =
        new Announcement();

        announcement.setId(
        id
        );

        announcement.setTitle(
        title
        );

        announcement.setMessage(
        message
        );

        AnnouncementDAO.updateAnnouncement(
        announcement
        );

        response.sendRedirect(
        "adminDashboard.jsp?announcementUpdated=true#announcements"
        );

    }

}