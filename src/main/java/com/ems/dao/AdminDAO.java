package com.ems.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import com.ems.model.Admin;
import com.ems.util.DBConnection;

public class AdminDAO {

	public static Admin validateAdmin(
			String username,
			String password
			){

			    Admin admin = null;

			    try{

			        Connection con =
			        DBConnection.getConnection();

			        String query =
			        "SELECT * FROM admins "
			        +
			        "WHERE username=? "
			        +
			        "AND password=?";

			        PreparedStatement ps =
			        con.prepareStatement(query);

			        ps.setString(
			        1,
			        username
			        );

			        ps.setString(
			        2,
			        password
			        );

			        ResultSet rs =
			        ps.executeQuery();

			        if(rs.next()){
			            admin =
			            new Admin();

			            admin.setId(
			            rs.getInt("id")
			            );

			            admin.setUsername(
			            rs.getString("username")
			            );

			            admin.setPassword(
			            rs.getString("password")
			            );

			            admin.setProfilePicture(
			            rs.getString(
			            "profile_picture"
			            )
			            );

			            admin.setLastLogin(
			            rs.getTimestamp(
			            "last_login"
			            )
			            );

			        }else{

			            System.out.println(
			            "ADMIN NOT FOUND"
			            );

			        }

			    }catch(Exception e){

			        e.printStackTrace();

			    }

			    return admin;

			}

    public static Admin getAdminByUsername(
    String username
    ){

        Admin admin = null;

        try{

            Connection con =
            DBConnection.getConnection();

            String query =
            "SELECT * FROM admins "
            +
            "WHERE username=?";

            PreparedStatement ps =
            con.prepareStatement(query);

            ps.setString(
            1,
            username
            );

            ResultSet rs =
            ps.executeQuery();

            if(rs.next()){

                admin =
                new Admin();

                admin.setId(
                rs.getInt("id")
                );

                admin.setUsername(
                rs.getString("username")
                );

                admin.setPassword(
                rs.getString("password")
                );

                admin.setProfilePicture(
                rs.getString(
                "profile_picture"
                )
                );

                admin.setLastLogin(
                rs.getTimestamp(
                "last_login"
                )
                );

            }

        }catch(Exception e){

            e.printStackTrace();

        }

        return admin;

    }

    public static boolean updateProfilePicture(
    		String username,
    		String fileName
    		){

    		    try{

    		        Connection con =
    		        DBConnection.getConnection();

    		        String query =
    		        "UPDATE admins "
    		        +
    		        "SET profile_picture=? "
    		        +
    		        "WHERE username=?";

    		        PreparedStatement ps =
    		        con.prepareStatement(
    		        query
    		        );

    		        ps.setString(
    		        1,
    		        fileName
    		        );

    		        ps.setString(
    		        2,
    		        username
    		        );

    		        return ps.executeUpdate() > 0;

    		    }catch(Exception e){

    		        e.printStackTrace();

    		    }

    		    return false;
    		}

    public static boolean removeProfilePicture(
    		String username
    		){

    		    try{

    		        Connection con =
    		        DBConnection.getConnection();

    		        String query =
    		        "UPDATE admins "
    		        +
    		        "SET profile_picture=NULL "
    		        +
    		        "WHERE username=?";

    		        PreparedStatement ps =
    		        con.prepareStatement(query);

    		        ps.setString(
    		        1,
    		        username
    		        );

    		        return ps.executeUpdate() > 0;

    		    }catch(Exception e){

    		        e.printStackTrace();

    		    }

    		    return false;
    		}

    public static boolean updatePassword(
    int adminId,
    String password
    ){

        try{

            Connection con =
            DBConnection.getConnection();

            String query =
            "UPDATE admins "
            +
            "SET password=? "
            +
            "WHERE id=?";

            PreparedStatement ps =
            con.prepareStatement(query);

            ps.setString(
            1,
            password
            );

            ps.setInt(
            2,
            adminId
            );

            return
            ps.executeUpdate() > 0;

        }catch(Exception e){

            e.printStackTrace();

        }

        return false;

    }
    public static boolean verifyAdmin(
    		String username,
    		String password
    		){

    		    try{

    		        Connection con =
    		        DBConnection.getConnection();

    		        String query =
    		        "SELECT * FROM admins WHERE username=? AND password=?";

    		        PreparedStatement ps =
    		        con.prepareStatement(query);

    		        ps.setString(1, username);
    		        ps.setString(2, password);

    		        ResultSet rs =
    		        ps.executeQuery();

    		        return rs.next();

    		    }catch(Exception e){

    		        e.printStackTrace();

    		    }

    		    return false;
    		}
    public static boolean updatePassword(
    		String username,
    		String password
    		){

    		    try{

    		        Connection con =
    		        DBConnection.getConnection();

    		        String query =
    		        "UPDATE admins SET password=? WHERE username=?";

    		        PreparedStatement ps =
    		        con.prepareStatement(query);

    		        ps.setString(1, password);
    		        ps.setString(2, username);

    		        return ps.executeUpdate() > 0;

    		    }catch(Exception e){

    		        e.printStackTrace();

    		    }

    		    return false;
    		}

}