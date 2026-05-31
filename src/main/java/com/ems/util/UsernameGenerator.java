package com.ems.util;

public class UsernameGenerator {

    public static String generateUsername(
            String name) {

        return name
                .toLowerCase()
                .replaceAll("\\s+", "");
    }
}