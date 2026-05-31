package com.ems.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.ems.model.Employee;
import com.ems.util.DBConnection;
public class EmployeeDAO {

	public static int addEmployee(Employee emp) {

	    int employeeId = -1;

	    try {

	        Connection con = DBConnection.getConnection();

	        String query =
	        "INSERT INTO employees(name, department, salary, email) VALUES(?,?,?,?)";

	        PreparedStatement ps =
	        con.prepareStatement(
	        query,
	        PreparedStatement.RETURN_GENERATED_KEYS
	        );

	        ps.setString(1, emp.getName());
	        ps.setString(2, emp.getDepartment());
	        ps.setLong(3, emp.getSalary());
	        ps.setString(4, emp.getEmail());

	        int rows = ps.executeUpdate();

	        if(rows > 0) {

	            ResultSet rs =
	            ps.getGeneratedKeys();

	            if(rs.next()) {

	                employeeId = rs.getInt(1);

	            }

	        }

	    } catch(Exception e) {

	        e.printStackTrace();

	    }

	    return employeeId;
	}

    public static List<Employee> getAllEmployees() {

        List<Employee> list = new ArrayList<>();

        try {

            Connection con = DBConnection.getConnection();

            String query = "SELECT * FROM employees";

            PreparedStatement ps = con.prepareStatement(query);

            ResultSet rs = ps.executeQuery();

            while(rs.next()) {

                Employee emp = new Employee();

                emp.setId(rs.getInt("id"));
                emp.setName(rs.getString("name"));
                emp.setDepartment(rs.getString("department"));
                emp.setSalary(rs.getLong("salary"));
                emp.setEmail(rs.getString("email"));

                list.add(emp);
            }

        } catch(Exception e) {

            e.printStackTrace();

        }

        return list;
    }
    public static Employee getEmployeeById(int id) {

        Employee emp = null;

        try {

            Connection con = DBConnection.getConnection();

            String query = "SELECT * FROM employees WHERE id=?";

            PreparedStatement ps = con.prepareStatement(query);

            ps.setInt(1, id);

            ResultSet rs = ps.executeQuery();

            if(rs.next()) {

                emp = new Employee();

                emp.setId(rs.getInt("id"));
                emp.setName(rs.getString("name"));
                emp.setDepartment(rs.getString("department"));
                emp.setSalary(rs.getLong("salary"));
                emp.setEmail(rs.getString("email"));
                
                
                emp.setProfilePicture(
                		rs.getString("profile_picture")
                		);
            }

        } catch(Exception e) {

            e.printStackTrace();

        }

        return emp;
    }
    public static boolean updateEmployee(Employee emp) {

        boolean status = false;

        try {

            Connection con = DBConnection.getConnection();

            String query = "UPDATE employees SET name=?, department=?, salary=?, email=? WHERE id=?";

            PreparedStatement ps = con.prepareStatement(query);

            ps.setString(1, emp.getName());
            ps.setString(2, emp.getDepartment());
            ps.setLong(3, emp.getSalary());
            ps.setString(4, emp.getEmail());
            ps.setInt(5, emp.getId());

            int rows = ps.executeUpdate();

            if(rows > 0) {

                status = true;

            }

        } catch(Exception e) {

            e.printStackTrace();

        }

        return status;
    }
    public static boolean deleteEmployee(int id) {

        boolean status = false;

        try {

            Connection con =
            DBConnection.getConnection();

            PreparedStatement ps1 =
            con.prepareStatement(
            "DELETE FROM users WHERE employee_id=?"
            );

            ps1.setInt(1, id);

            ps1.executeUpdate();

            PreparedStatement ps2 =
            con.prepareStatement(
            "DELETE FROM employees WHERE id=?"
            );

            ps2.setInt(1, id);

            int rows =
            ps2.executeUpdate();

            status = rows > 0;

        } catch(Exception e) {

            e.printStackTrace();

        }

        return status;
    }
    public static List<Employee> getEmployeesByPage(
    		int start,
    		int total
    		){

    		List<Employee> list =
    		new ArrayList<Employee>();

    		try{

    		Connection con =
    		DBConnection.getConnection();

    		PreparedStatement ps =
    		con.prepareStatement(
    		"SELECT * FROM employees ORDER BY id ASC LIMIT ?, ?"
    		);

    		ps.setInt(1, start);
    		ps.setInt(2, total);

    		ResultSet rs = ps.executeQuery();

    		while(rs.next()){

    		Employee emp =
    		new Employee();

    		emp.setId(
    		rs.getInt("id")
    		);

    		emp.setName(
    		rs.getString("name")
    		);

    		emp.setDepartment(
    		rs.getString("department")
    		);

    		emp.setSalary(
    		rs.getLong("salary")
    		);

    		emp.setEmail(
    		rs.getString("email")
    		);

    		list.add(emp);

    		}

    		con.close();

    		}catch(Exception e){

    		e.printStackTrace();

    		}

    		return list;

    		}
    public static int getEmployeeCount(){

        int count = 0;

        try{

            Connection con = DBConnection.getConnection();

            String query =
            "SELECT COUNT(*) FROM employees";

            PreparedStatement ps =
            con.prepareStatement(query);

            ResultSet rs = ps.executeQuery();

            while(rs.next()){

                count = rs.getInt(1);

            }

        } catch(Exception e){

            e.printStackTrace();

        }

        return count;
    }
    public static List<Employee> sortEmployees(
    		String column,
    		int start,
    		int total
    		){

    		    List<Employee> list =
    		    new ArrayList<Employee>();

    		    try{

    		        Connection con =
    		        DBConnection.getConnection();

    		        String query =
    		        "SELECT * FROM employees ORDER BY "
    		        + column +
    		        " ASC LIMIT ?, ?";

    		        PreparedStatement ps =
    		        con.prepareStatement(query);

    		        ps.setInt(1, start);
    		        ps.setInt(2, total);

    		        ResultSet rs = ps.executeQuery();

    		        while(rs.next()){

    		            Employee emp = new Employee();

    		            emp.setId(rs.getInt("id"));
    		            emp.setName(rs.getString("name"));
    		            emp.setDepartment(
    		                rs.getString("department")
    		            );
    		            emp.setSalary(
    		                rs.getLong("salary")
    		            );
    		            emp.setEmail(
    		                rs.getString("email")
    		            );

    		            list.add(emp);

    		        }

    		    } catch(Exception e){

    		        e.printStackTrace();

    		    }

    		    return list;
    		}
    public static List<Employee> searchEmployees(
    		String keyword,
    		int start,
    		int total
    		){

    		List<Employee> list =
    		new ArrayList<Employee>();

    		try{

    		Connection con =
    		DBConnection.getConnection();

    		String query =
    		"SELECT * FROM employees " +
    		"WHERE name LIKE ? " +
    		"LIMIT ?, ?";

    		PreparedStatement ps =
    		con.prepareStatement(query);

    		ps.setString(
    				1,
    				"%" + keyword + "%"
    				);

    				ps.setInt(
    				2,
    				start
    				);

    				ps.setInt(
    				3,
    				total
    				);

    		ResultSet rs =
    		ps.executeQuery();

    		while(rs.next()){

    		Employee emp =
    		new Employee();

    		emp.setId(rs.getInt("id"));
    		emp.setName(rs.getString("name"));
    		emp.setDepartment(rs.getString("department"));
    		emp.setSalary(rs.getLong("salary"));
    		emp.setEmail(rs.getString("email"));

    		list.add(emp);

    		}

    		}catch(Exception e){

    		e.printStackTrace();

    		}

    		return list;

    		}
    public static Employee getEmployeeByUsername(
            String username){

        Employee employee = null;

        try{

            Connection con =
            DBConnection.getConnection();

            String query =
            "SELECT e.* "
            + "FROM employees e "
            + "JOIN users u "
            + "ON e.id = u.employee_id "
            + "WHERE u.username=?";

            PreparedStatement ps =
            con.prepareStatement(query);

            ps.setString(
            1,
            username
            );

            ResultSet rs =
            ps.executeQuery();

            if(rs.next()){

                employee =
                new Employee();

                employee.setId(
                rs.getInt("id")
                );

                employee.setName(
                rs.getString("name")
                );

                employee.setDepartment(
                rs.getString("department")
                );

                employee.setSalary(
                rs.getLong("salary")
                );

                employee.setEmail(
                rs.getString("email")
                );

            }

        }catch(Exception e){

            e.printStackTrace();

        }

        return employee;

    }
    public static boolean updateProfilePicture(
            int employeeId,
            String fileName){

        try{

            Connection con =
            DBConnection.getConnection();

            String query =
            "UPDATE employees SET profile_picture=? WHERE id=?";

            PreparedStatement ps =
            con.prepareStatement(query);

            ps.setString(
            1,
            fileName
            );

            ps.setInt(
            2,
            employeeId
            );

            return ps.executeUpdate() > 0;

        }catch(Exception e){

            e.printStackTrace();

        }

        return false;

    }
    public static String getProfilePicture(
            int employeeId){

        try{

            Connection con =
            DBConnection.getConnection();

            String query =
            "SELECT profile_picture FROM employees WHERE id=?";

            PreparedStatement ps =
            con.prepareStatement(query);

            ps.setInt(
            1,
            employeeId
            );

            ResultSet rs =
            ps.executeQuery();

            if(rs.next()){

                return rs.getString(
                "profile_picture"
                );

            }

        }catch(Exception e){

            e.printStackTrace();

        }

        return null;

    }
    public static boolean removeProfilePicture(
    		int employeeId
    		){

    		    try{

    		        Connection con =
    		        DBConnection.getConnection();

    		        String query =
    		        "UPDATE employees SET profile_picture=NULL WHERE id=?";

    		        PreparedStatement ps =
    		        con.prepareStatement(query);

    		        ps.setInt(
    		        1,
    		        employeeId
    		        );

    		        return ps.executeUpdate() > 0;

    		    }catch(Exception e){

    		        e.printStackTrace();

    		    }

    		    return false;

    		}
    public static boolean emailExists(String email){

        boolean exists = false;

        try{

            Connection con =
            DBConnection.getConnection();

            String query =
            "SELECT id FROM employees WHERE email=?";

            PreparedStatement ps =
            con.prepareStatement(query);

            ps.setString(
            1,
            email
            );

            ResultSet rs =
            ps.executeQuery();

            exists = rs.next();

        }catch(Exception e){

            e.printStackTrace();

        }

        return exists;
    }
}