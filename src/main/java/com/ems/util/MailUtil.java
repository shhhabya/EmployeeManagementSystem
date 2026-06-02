package com.ems.util;

import java.util.Properties;

import jakarta.mail.Authenticator;
import jakarta.mail.Message;
import jakarta.mail.PasswordAuthentication;
import jakarta.mail.Session;
import jakarta.mail.Transport;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeMessage;

public class MailUtil {

	public static void sendEmail(String toEmail,
            String subject,
            String body) {

System.out.println("MAIL METHOD CALLED");
System.out.println("TO = " + toEmail);

final String fromEmail =
System.getenv("EMAIL_USER");

final String password =
System.getenv("EMAIL_PASSWORD");

System.out.println("EMAIL_USER = " + fromEmail);
System.out.println("EMAIL_PASSWORD NULL? " + (password == null));

        Properties props = new Properties();

        props.put("mail.smtp.host", "smtp-relay.brevo.com");
        props.put("mail.smtp.port", "587");
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");

        Session session = Session.getInstance(props,
            new Authenticator() {

                protected PasswordAuthentication
                getPasswordAuthentication() {

                    return new PasswordAuthentication(
                        fromEmail,
                        password
                    );
                }
            });

        try {

            Message message =
            new MimeMessage(session);

            message.setFrom(
                new InternetAddress(fromEmail)
            );

            message.setRecipients(
                Message.RecipientType.TO,
                InternetAddress.parse(toEmail)
            );

            message.setSubject(subject);

            message.setText(body);

            Transport.send(message);

            System.out.println(
                "Email Sent Successfully!"
            );

        } catch (Exception e) {

            e.printStackTrace();
        }
    }
}