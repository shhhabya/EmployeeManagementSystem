package com.ems.model;

import java.sql.Timestamp;

public class Announcement {

    private int id;

    private String title;

    private String message;

    private Timestamp createdAt;
    
    private String audienceType;

    private String targetDepartments;

    private String targetEmployeeIds;

    private int idRangeFrom;
    
    private Timestamp updatedAt;

    private int idRangeTo;
    public int getId() {

        return id;

    }

    public void setId(int id) {

        this.id = id;

    }

    public String getTitle() {

        return title;

    }

    public void setTitle(String title) {

        this.title = title;

    }

    public String getMessage() {

        return message;

    }

    public void setMessage(String message) {

        this.message = message;

    }

    public Timestamp getCreatedAt() {

        return createdAt;

    }

    public void setCreatedAt(
    Timestamp createdAt
    ) {

        this.createdAt = createdAt;

    }
    public String getAudienceType() {

        return audienceType;

    }

    public void setAudienceType(
    String audienceType
    ) {

        this.audienceType =
        audienceType;

    }

    public String getTargetDepartments() {

        return targetDepartments;

    }

    public void setTargetDepartments(
    String targetDepartments
    ) {

        this.targetDepartments =
        targetDepartments;

    }

    public String getTargetEmployeeIds() {

        return targetEmployeeIds;

    }

    public void setTargetEmployeeIds(
    String targetEmployeeIds
    ) {

        this.targetEmployeeIds =
        targetEmployeeIds;

    }

    public int getIdRangeFrom() {

        return idRangeFrom;

    }

    public void setIdRangeFrom(
    int idRangeFrom
    ) {

        this.idRangeFrom =
        idRangeFrom;

    }

    public int getIdRangeTo() {

        return idRangeTo;

    }

    public void setIdRangeTo(
    int idRangeTo
    ) {

        this.idRangeTo =
        idRangeTo;

    }
    public Timestamp getUpdatedAt() {

        return updatedAt;

    }
    public void setUpdatedAt(
    		Timestamp updatedAt
    		) {

    		    this.updatedAt = updatedAt;

    		}

}