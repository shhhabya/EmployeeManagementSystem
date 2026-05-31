package com.ems.util;

import java.security.SecureRandom;

public class PasswordGenerator {

    private static final String CHARS =
            "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
            + "abcdefghijklmnopqrstuvwxyz"
            + "0123456789";

    public static String generatePassword() {

        SecureRandom random =
                new SecureRandom();

        StringBuilder password =
                new StringBuilder();

        for(int i = 0; i < 8; i++) {

            password.append(
                    CHARS.charAt(
                            random.nextInt(
                                    CHARS.length()
                            )
                    )
            );
        }

        return password.toString();
    }
}