package com.ems.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.ems.model.Announcement;
import com.ems.util.DBConnection;

public class AnnouncementDAO {

    public static boolean addAnnouncement(
    Announcement announcement
    ){

        try{

            Connection con =
            DBConnection.getConnection();

            String query =
            		"INSERT INTO announcements("
            		+
            		"title,"
            		+
            		"message,"
            		+
            		"audience_type,"
            		+
            		"target_departments,"
            		+
            		"target_employee_ids,"
            		+
            		"id_range_from,"
            		+
            		"id_range_to"
            		+
            		") VALUES(?,?,?,?,?,?,?)";

            PreparedStatement ps =
            con.prepareStatement(query);

            ps.setString(
            		1,
            		announcement.getTitle()
            		);

            		ps.setString(
            		2,
            		announcement.getMessage()
            		);

            		ps.setString(
            		3,
            		announcement.getAudienceType()
            		);

            		ps.setString(
            		4,
            		announcement.getTargetDepartments()
            		);

            		ps.setString(
            		5,
            		announcement.getTargetEmployeeIds()
            		);

            		ps.setInt(
            		6,
            		announcement.getIdRangeFrom()
            		);

            		ps.setInt(
            		7,
            		announcement.getIdRangeTo()
            		);

            return ps.executeUpdate() > 0;

        }catch(Exception e){

            e.printStackTrace();

        }

        return false;

    }

    public static List<Announcement> getAnnouncementsForEmployee(
    		int employeeId,
    		String department
    		){
    		    List<Announcement> list =
    		    new ArrayList<>();

    		    try{

    		        Connection con =
    		        DBConnection.getConnection();

    		        String query =
    		        "SELECT * FROM announcements ORDER BY id DESC";

    		        PreparedStatement ps =
    		        con.prepareStatement(query);

    		        ResultSet rs =
    		        ps.executeQuery();

    		        while(rs.next()){

    		            String audienceType =
    		            rs.getString("audience_type");

    		            boolean allowed = false;

    		            if("ALL".equals(audienceType)){

    		                allowed = true;

    		            }

    		            else if("DEPARTMENT".equals(audienceType)){

    		                String targetDepartments =
    		                rs.getString("target_departments");

    		                if(targetDepartments != null
    		                &&
    		                targetDepartments.contains(department)){

    		                    allowed = true;

    		                }

    		            }

    		            else if("CUSTOM".equals(audienceType)){

    		                String targetIds =
    		                rs.getString("target_employee_ids");

    		                if(targetIds != null
    		                &&
    		                targetIds.contains(
    		                String.valueOf(employeeId)
    		                )){

    		                    allowed = true;

    		                }

    		            }

    		            else if("RANGE".equals(audienceType)){

    		                int from =
    		                rs.getInt("id_range_from");

    		                int to =
    		                rs.getInt("id_range_to");

    		                if(employeeId >= from
    		                &&
    		                employeeId <= to){

    		                    allowed = true;

    		                }

    		            }

    		            if(allowed){

    		                Announcement announcement =
    		                new Announcement();

    		                announcement.setId(
    		                rs.getInt("id")
    		                );

    		                announcement.setTitle(
    		                rs.getString("title")
    		                );

    		                announcement.setMessage(
    		                rs.getString("message")
    		                );

    		                announcement.setCreatedAt(
    		                		rs.getTimestamp("created_at")
    		                		);

    		                		announcement.setUpdatedAt(
    		                		rs.getTimestamp("updated_at")
    		                		);

    		                		list.add(
    		                		announcement
    		                		);

    		            }

    		        }

    		    }catch(Exception e){

    		        e.printStackTrace();

    		    }

    		    return list;

    		}

    public static boolean deleteAnnouncement(
    		int id
    		){

    		    try{

    		        Connection con =
    		        DBConnection.getConnection();

    		        String query =
    		        "DELETE FROM announcements WHERE id=?";

    		        PreparedStatement ps =
    		        con.prepareStatement(query);

    		        ps.setInt(
    		        1,
    		        id
    		        );

    		        return ps.executeUpdate() > 0;

    		    }catch(Exception e){

    		        e.printStackTrace();

    		    }

    		    return false;

    		}
    public static List<Announcement> getAllAnnouncements(){

        List<Announcement> list =
        new ArrayList<>();

        try{

            Connection con =
            DBConnection.getConnection();

            String query =
            "SELECT * FROM announcements ORDER BY id DESC";

            PreparedStatement ps =
            con.prepareStatement(query);

            ResultSet rs =
            ps.executeQuery();

            while(rs.next()){

                Announcement announcement =
                new Announcement();

                announcement.setId(
                rs.getInt("id")
                );

                announcement.setTitle(
                rs.getString("title")
                );

                announcement.setMessage(
                rs.getString("message")
                );

                announcement.setCreatedAt(
                rs.getTimestamp("created_at")
                );
                
                announcement.setUpdatedAt(
                		rs.getTimestamp("updated_at")
                		);

                list.add(
                announcement
                );

            }

        }catch(Exception e){

            e.printStackTrace();

        }

        return list;

    }
    public static Announcement getAnnouncementById(
    		int id
    		){

    		    Announcement announcement =
    		    null;

    		    try{

    		        Connection con =
    		        DBConnection.getConnection();

    		        String query =
    		        "SELECT * FROM announcements WHERE id=?";

    		        PreparedStatement ps =
    		        con.prepareStatement(query);

    		        ps.setInt(
    		        1,
    		        id
    		        );

    		        ResultSet rs =
    		        ps.executeQuery();

    		        if(rs.next()){

    		            announcement =
    		            new Announcement();

    		            announcement.setId(
    		            rs.getInt("id")
    		            );

    		            announcement.setTitle(
    		            rs.getString("title")
    		            );

    		            announcement.setMessage(
    		            rs.getString("message")
    		            );
    		            
    		            announcement.setUpdatedAt(
    		            		rs.getTimestamp("updated_at")
    		            		);

    		            announcement.setCreatedAt(
    		            rs.getTimestamp("created_at")
    		            );

    		        }

    		    }catch(Exception e){

    		        e.printStackTrace();

    		    }

    		    return announcement;

    		}
    public static boolean updateAnnouncement(
    		Announcement announcement
    		){

    		    try{

    		        Connection con =
    		        DBConnection.getConnection();

    		        String query =
    		        		"UPDATE announcements "
    		        		+
    		        		"SET title=?, "
    		        		+
    		        		"message=?, "
    		        		+
    		        		"updated_at=NOW() "
    		        		+
    		        		"WHERE id=?";

    		        PreparedStatement ps =
    		        con.prepareStatement(query);

    		        ps.setString(
    		        1,
    		        announcement.getTitle()
    		        );

    		        ps.setString(
    		        2,
    		        announcement.getMessage()
    		        );

    		        ps.setInt(
    		        3,
    		        announcement.getId()
    		        );

    		        return ps.executeUpdate() > 0;

    		    }catch(Exception e){

    		        e.printStackTrace();

    		    }

    		    return false;

    		}

}