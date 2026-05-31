package com.ems.servlet;

import java.io.IOException;

import com.ems.dao.EmployeeDAO;
import com.ems.model.Employee;
import com.ems.util.MailUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import com.ems.dao.UserDAO;
import com.ems.util.PasswordGenerator;
import com.ems.util.PasswordUtil;
import com.ems.util.UsernameGenerator;
import com.ems.dao.NotificationDAO;
@WebServlet("/addEmployee")
public class AddEmployeeServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String name = request.getParameter("name");
        String department = request.getParameter("department");
        long salary =
        		Long.parseLong(
        		request.getParameter("salary")
        		);
        String email = request.getParameter("email");

        if(name == null || name.trim().isEmpty() ||
           department == null || department.trim().isEmpty() ||
           email == null || email.trim().isEmpty()){

            response.sendRedirect("adminDashboard.jsp?error=emptyfields");
            return;
        }

        if(salary <= 0){

            response.sendRedirect("adminDashboard.jsp?error=invalidsalary");
            return;
        }

        if(!email.contains("@") || !email.contains(".")){

            response.sendRedirect("adminDashboard.jsp?error=invalidemail");
            return;
        }

        if(EmployeeDAO.emailExists(email)){

            response.sendRedirect(
            "adminDashboard.jsp?error=emailExists#addEmployee"
            );

            return;
        }

        Employee emp = new Employee();

        emp.setName(name);
        emp.setDepartment(department);
        emp.setSalary(salary);
        emp.setEmail(email);

        int employeeId =
        		EmployeeDAO.addEmployee(emp);

        		if(employeeId > 0){

        		    String username =
        		    UsernameGenerator.generateUsername(
        		    emp.getName()
        		    );

        		    String temporaryPassword =
        		    PasswordGenerator.generatePassword();
        		    
        		    
        		    System.out.println(
        		    		"TEMP PASSWORD = " +
        		    		temporaryPassword
        		    		);
        		    
        		    
        		    String encryptedPassword =
        		    PasswordUtil.hashPassword(
        		    temporaryPassword
        		    );
        		    System.out.println(
        		    		"HASH = " +
        		    		encryptedPassword
        		    		);
        		    UserDAO.addUser(
        		    username,
        		    encryptedPassword,
        		    "employee",
        		    employeeId
        		    );

        		    NotificationDAO.addNotification(
        		    		employeeId,
        		    		"Employee account created"
        		    		);
        		    
        		    String employeeCode =
        		    String.format(
        		    "EMP%05d",
        		    employeeId
        		    );

        		    MailUtil.sendEmail(

        		        emp.getEmail(),

        		        "Employee Account Created",

        		        "Hello " + emp.getName() +

        		        "\n\nEmployee ID: " + employeeCode +

        		        "\nUsername: " + username +

        		        "\nTemporary Password: " +
        		        temporaryPassword +

        		        "\n\nPlease login and change your password after your first login."

        		    );

        		    response.sendRedirect(
        		    		"adminDashboard.jsp?added=true#viewEmployees"
        		    );

        		}else{

        		    response.getWriter().println(
        		    "Failed to Add Employee"
        		    );

        		}
    }
}