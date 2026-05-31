package com.ems.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;

import com.ems.util.DBConnection;

import java.util.ArrayList;
import java.util.List;
import java.sql.ResultSet;
import com.ems.model.Notification;

import java.sql.Timestamp;
import java.text.SimpleDateFormat;

public class NotificationDAO {

    public static void addNotification(
            int employeeId,
            String message){

        try{

            Connection con =
            DBConnection.getConnection();

            String query =
            "INSERT INTO notifications(employee_id,message) VALUES(?,?)";

            PreparedStatement ps =
            con.prepareStatement(query);

            ps.setInt(
            1,
            employeeId
            );

            ps.setString(
            2,
            message
            );

            ps.executeUpdate();

        }catch(Exception e){

            e.printStackTrace();

        }

    }
    public static List<Notification> getLatestNotifications(
            int employeeId){

        List<Notification> notifications =
        new ArrayList<>();

        try{

            Connection con =
            DBConnection.getConnection();

            String query =
            "SELECT * FROM notifications "
            + "WHERE employee_id=? "
            + "ORDER BY created_at DESC "
            + "LIMIT 10";

            PreparedStatement ps =
            con.prepareStatement(query);

            ps.setInt(
            1,
            employeeId
            );

            ResultSet rs =
            ps.executeQuery();

            while(rs.next()){

                Notification notification =
                new Notification();

                notification.setId(
                rs.getInt("id")
                );

                notification.setEmployeeId(
                rs.getInt("employee_id")
                );

                notification.setMessage(
                rs.getString("message")
                );

                Timestamp timestamp =
                		rs.getTimestamp(
                		"created_at"
                		);

                		SimpleDateFormat sdf =
                		new SimpleDateFormat(
                		"dd MMM yyyy, hh:mm a"
                		);

                		notification.setCreatedAt(
                		sdf.format(timestamp)
                		);

                notifications.add(
                notification
                );

            }

        }catch(Exception e){

            e.printStackTrace();

        }

        return notifications;
    }

}