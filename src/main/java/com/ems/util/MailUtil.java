package com.ems.util;

import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;

public class MailUtil {

    public static void sendEmail(
            String toEmail,
            String subject,
            String body) {

        try {

            String apiKey =
                    System.getenv("BREVO_API_KEY");

            URL url = new URL(
                    "https://api.brevo.com/v3/smtp/email"
            );

            HttpURLConnection con =
                    (HttpURLConnection)
                    url.openConnection();

            con.setRequestMethod("POST");
            con.setRequestProperty(
                    "accept",
                    "application/json"
            );

            con.setRequestProperty(
                    "api-key",
                    apiKey
            );

            con.setRequestProperty(
                    "content-type",
                    "application/json"
            );

            con.setDoOutput(true);

            String json =
                    "{"
                    + "\"sender\":{\"email\":\"ggnubz69420@gmail.com\"},"
                    + "\"to\":[{\"email\":\"" + toEmail + "\"}],"
                    + "\"subject\":\"" + subject + "\","
                    + "\"textContent\":\""
                    + body.replace("\"","\\\"")
                    + "\""
                    + "}";

            try(OutputStream os =
                    con.getOutputStream()) {

                os.write(json.getBytes());
            }

            System.out.println(
                    "Brevo Response Code = "
                    + con.getResponseCode()
            );

        } catch(Exception e) {

            e.printStackTrace();

        }
    }
}