package com.ems.servlet;

import java.io.IOException;
import com.ems.model.Employee;
import com.ems.dao.EmployeeDAO;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import com.ems.util.MailUtil;
@WebServlet("/deleteEmployee")
public class DeleteEmployeeServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int id = Integer.parseInt(request.getParameter("id"));
        Employee emp = EmployeeDAO.getEmployeeById(id);

        boolean status = EmployeeDAO.deleteEmployee(id);

        if(status && emp != null){

            MailUtil.sendEmail(
                emp.getEmail(),
                "Employee Record Deleted",
                "Hello " + emp.getName() +
                ", your employee record has been deleted from the system."
            );
        }

        if(status){

            response.sendRedirect("adminDashboard.jsp?deleted=true#viewEmployees");

        } else {

            response.getWriter().println("Failed to Delete Employee");

        }
    }
}