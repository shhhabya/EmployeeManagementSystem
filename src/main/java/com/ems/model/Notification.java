package com.ems.model;

public class Notification {

    private int id;
    private int employeeId;
    private String message;
    private String createdAt;

    public int getId() {

        return id;

    }

    public void setId(int id) {

        this.id = id;

    }

    public int getEmployeeId() {

        return employeeId;

    }

    public void setEmployeeId(
            int employeeId) {

        this.employeeId = employeeId;

    }

    public String getMessage() {

        return message;

    }

    public void setMessage(
            String message) {

        this.message = message;

    }

    public String getCreatedAt() {

        return createdAt;

    }

    public void setCreatedAt(
            String createdAt) {

        this.createdAt = createdAt;

    }

}