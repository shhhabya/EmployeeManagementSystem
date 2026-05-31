package com.ems.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;

import com.ems.util.DBConnection;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
public class UserDAO {

    public static boolean addUser(
            String username,
            String password,
            String role,
            int employeeId) {

        try {

            Connection con =
                    DBConnection.getConnection();

            String query =
                    "INSERT INTO users(username,password,role,employee_id) VALUES(?,?,?,?)";

            PreparedStatement ps =
                    con.prepareStatement(query);

            ps.setString(1, username);
            ps.setString(2, password);
            ps.setString(3, role);
            ps.setInt(4, employeeId);

            return ps.executeUpdate() > 0;

        } catch(Exception e) {

            e.printStackTrace();

        }

        return false;
    }
    public static int getEmployeeIdByUsername(
            String username){

        int employeeId = -1;

        try{

            Connection con =
            DBConnection.getConnection();

            String query =
            "SELECT employee_id FROM users WHERE username=?";

            PreparedStatement ps =
            con.prepareStatement(query);

            ps.setString(1, username);

            ResultSet rs =
            ps.executeQuery();

            if(rs.next()){

                employeeId =
                rs.getInt("employee_id");

            }

        }catch(Exception e){

            e.printStackTrace();

        }

        return employeeId;
    }
    public static boolean verifyUser(
            String username,
            String password) {

        boolean status = false;

        try {

            Connection con =
                    DBConnection.getConnection();

            String query =
                    "SELECT * FROM users WHERE username=? AND password=?";

            PreparedStatement ps =
                    con.prepareStatement(query);

            ps.setString(1, username);
            ps.setString(2, password);

            ResultSet rs =
                    ps.executeQuery();

            if(rs.next()) {

                status = true;

            }

        } catch(Exception e) {

            e.printStackTrace();

        }

        return status;
    }
    public static boolean updatePassword(
            String username,
            String newPassword) {

        boolean status = false;

        try {

            Connection con =
                    DBConnection.getConnection();

            String query =
                    "UPDATE users SET password=? WHERE username=?";

            PreparedStatement ps =
                    con.prepareStatement(query);

            ps.setString(1, newPassword);
            ps.setString(2, username);

            int rows =
                    ps.executeUpdate();

            if(rows > 0) {

                status = true;

            }

        } catch(Exception e) {

            e.printStackTrace();

        }

        return status;
    }
    public static void updateLastLogin(
            String username){

        try{

            Connection con =
            DBConnection.getConnection();

            String query =
            "UPDATE users SET last_login=NOW() WHERE username=?";

            PreparedStatement ps =
            con.prepareStatement(query);

            ps.setString(
            1,
            username
            );

            ps.executeUpdate();

        }catch(Exception e){

            e.printStackTrace();

        }

    }
    public static String getLastLogin(
            String username){

        String lastLogin = "Not Available";

        try{

            Connection con =
            DBConnection.getConnection();

            String query =
            "SELECT last_login FROM users WHERE username=?";

            PreparedStatement ps =
            con.prepareStatement(query);

            ps.setString(
            1,
            username
            );

            ResultSet rs =
            ps.executeQuery();

            if(rs.next()
               && rs.getTimestamp("last_login") != null){

            	Timestamp timestamp =
            			rs.getTimestamp(
            			"last_login"
            			);

            			SimpleDateFormat sdf =
            			new SimpleDateFormat(
            			"dd MMM yyyy, hh:mm a"
            			);

            			lastLogin =
            			sdf.format(
            			timestamp
            			);

            }

        }catch(Exception e){

            e.printStackTrace();

        }

        return lastLogin;
    }
    public static void disableFirstLogin(
            String username){

        try{

            Connection con =
            DBConnection.getConnection();

            String query =
            "UPDATE users SET first_login=FALSE WHERE username=?";

            PreparedStatement ps =
            con.prepareStatement(query);

            ps.setString(
            1,
            username
            );

            ps.executeUpdate();

        }catch(Exception e){

            e.printStackTrace();

        }

    }
    public static boolean isFirstLogin(
            String username){

        boolean firstLogin = false;

        try{

            Connection con =
            DBConnection.getConnection();

            String query =
            "SELECT first_login FROM users WHERE username=?";

            PreparedStatement ps =
            con.prepareStatement(query);

            ps.setString(
            1,
            username
            );

            ResultSet rs =
            ps.executeQuery();

            if(rs.next()){

                firstLogin =
                rs.getBoolean(
                "first_login"
                );

            }

        }catch(Exception e){

            e.printStackTrace();

        }

        return firstLogin;
    }
}