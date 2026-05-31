package com.ems.servlet;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.OutputStream;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/profileImage")
public class ProfileImageServlet extends HttpServlet {

    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        String fileName =
        request.getParameter("file");

        if(fileName == null ||
           fileName.isEmpty()) {

            response.sendError(
            HttpServletResponse.SC_NOT_FOUND);

            return;
        }

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

        if(!imageFile.exists()) {

            response.sendError(
            HttpServletResponse.SC_NOT_FOUND);

            return;
        }

        response.setContentType(
        "image/jpeg");

        FileInputStream fis =
        new FileInputStream(imageFile);

        OutputStream os =
        response.getOutputStream();

        byte[] buffer =
        new byte[4096];

        int bytesRead;

        while((bytesRead =
        fis.read(buffer)) != -1) {

            os.write(
            buffer,
            0,
            bytesRead
            );
        }

        fis.close();
        os.close();
    }
}