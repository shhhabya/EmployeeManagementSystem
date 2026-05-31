package com.ems.servlet;

import java.io.IOException;

import com.ems.dao.EmployeeDAO;
import com.ems.model.Employee;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import com.ems.util.MailUtil;
import com.ems.dao.NotificationDAO;
import java.text.SimpleDateFormat;
import java.util.Date;
@WebServlet("/updateEmployee")
public class UpdateEmployeeServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int id = Integer.parseInt(
        		request.getParameter("id")
        		);
        
        Employee oldEmp =
        		EmployeeDAO.getEmployeeById(id);
        
        String name = request.getParameter("name");
        String department = request.getParameter("department");
        long salary =
        		Long.parseLong(
        		request.getParameter("salary")
        		);
        String email = request.getParameter("email");

        Employee emp = new Employee();

        emp.setId(id);
        emp.setName(name);
        emp.setDepartment(department);
        emp.setSalary(salary);
        emp.setEmail(email);

        boolean nameChanged =
        		!oldEmp.getName().equals(
        		emp.getName()
        		);

        		boolean departmentChanged =
        		!oldEmp.getDepartment().equals(
        		emp.getDepartment()
        		);

        		boolean salaryChanged =
        		oldEmp.getSalary() !=
        		emp.getSalary();

        		boolean emailChanged =
        		!oldEmp.getEmail().equals(
        		emp.getEmail()
        		);
        
        boolean status = EmployeeDAO.updateEmployee(emp);
        
        StringBuilder emailBody =
        		new StringBuilder();

        		emailBody.append(
        		"Hello "
        		+ emp.getName()
        		+ ",\n\n"
        		);

        		String timestamp =
        		new SimpleDateFormat(
        		"dd MMM yyyy, hh:mm a"
        		).format(
        		new Date()
        		);

        		emailBody.append(
        		"The following changes were made by an administrator on\n"
        		+ timestamp
        		+ "\n\n"
        		);
        		
        		if(nameChanged){

        		    emailBody.append(
        		    "Name:\n"
        		    + oldEmp.getName()
        		    + " → "
        		    + emp.getName()
        		    + "\n\n"
        		    );

        		}

        		if(departmentChanged){

        		    emailBody.append(
        		    "Department:\n"
        		    + oldEmp.getDepartment()
        		    + " → "
        		    + emp.getDepartment()
        		    + "\n\n"
        		    );

        		}

        		if(salaryChanged){

        		    emailBody.append(
        		    "Salary:\n"
        		    + oldEmp.getSalary()
        		    + " → "
        		    + emp.getSalary()
        		    + "\n\n"
        		    );

        		}

        		if(emailChanged){

        		    emailBody.append(
        		    "Email:\n"
        		    + oldEmp.getEmail()
        		    + " → "
        		    + emp.getEmail()
        		    + "\n\n"
        		    );

        		}

        if(status) {

        	if(nameChanged){

        	    NotificationDAO.addNotification(
        	    id,
        	    "Name updated by admin\nFrom "
        	    + oldEmp.getName()
        	    + " to "
        	    + emp.getName()
        	    );

        	}

        	    if(departmentChanged){

        	        NotificationDAO.addNotification(
        	        id,
        	        "Department updated by admin\nFrom "
        	        + oldEmp.getDepartment()
        	        + " to "
        	        + emp.getDepartment()
        	        );

        	    }

        	    if(salaryChanged){

        	        NotificationDAO.addNotification(
        	        id,
        	        "Salary updated by admin\nFrom ₹"
        	        + oldEmp.getSalary()
        	        + " to ₹"
        	        + emp.getSalary()
        	        );

        	    }

        	    if(emailChanged){

        	        NotificationDAO.addNotification(
        	        id,
        	        "Email updated by admin\nFrom "
        	        + oldEmp.getEmail()
        	        + " to "
        	        + emp.getEmail()
        	        );

        	    }

        	    emailBody.append(
        	    "If you were not expecting these changes, please contact HR or your administrator."
        	    );

        	    if(emailChanged){

        	        MailUtil.sendEmail(
        	        oldEmp.getEmail(),
        	        "Employee Email Changed",
        	        emailBody.toString()
        	        );

        	        MailUtil.sendEmail(
        	        emp.getEmail(),
        	        "Employee Email Changed",
        	        emailBody.toString()
        	        );

        	    }else{

        	        MailUtil.sendEmail(
        	        oldEmp.getEmail(),
        	        "Employee Information Updated",
        	        emailBody.toString()
        	        );

        	    }
  
            response.sendRedirect("adminDashboard.jsp?updated=true#viewEmployees");

        } else {

            response.getWriter().println("Failed to Update Employee");

        }
    }
}