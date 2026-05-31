package com.ems.model;

import java.sql.Timestamp;

public class Admin {

    private int id;

    private String username;

    private String password;

    private String profilePicture;

    private Timestamp lastLogin;

    public Admin() {
    }

    public int getId() {

        return id;

    }

    public void setId(
    int id
    ) {

        this.id = id;

    }

    public String getUsername() {

        return username;

    }

    public void setUsername(
    String username
    ) {

        this.username = username;

    }

    public String getPassword() {

        return password;

    }

    public void setPassword(
    String password
    ) {

        this.password = password;

    }

    public String getProfilePicture() {

        return profilePicture;

    }

    public void setProfilePicture(
    String profilePicture
    ) {

        this.profilePicture = profilePicture;

    }

    public Timestamp getLastLogin() {

        return lastLogin;

    }

    public void setLastLogin(
    Timestamp lastLogin
    ) {

        this.lastLogin = lastLogin;

    }

}