package com.ems.util;

import java.io.BufferedReader;
import java.io.InputStreamReader;
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
                    + body.replace("\"", "\\\"")
                    + "\""
                    + "}";

            try (OutputStream os =
                    con.getOutputStream()) {

                os.write(json.getBytes());

            }

            int responseCode =
                    con.getResponseCode();

            System.out.println(
                    "Brevo Response Code = "
                    + responseCode
            );

            if (responseCode >= 400) {

                BufferedReader br =
                        new BufferedReader(
                                new InputStreamReader(
                                        con.getErrorStream()
                                )
                        );

                String line;

                while ((line = br.readLine())
                        != null) {

                    System.out.println(
                            "BREVO ERROR: "
                            + line
                    );

                }

                br.close();

            }

        } catch (Exception e) {

            e.printStackTrace();

        }
    }
}