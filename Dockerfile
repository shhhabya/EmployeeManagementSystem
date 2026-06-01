FROM tomcat:11.0-jdk21

COPY EmployeeManagementSystem.war /usr/local/tomcat/webapps/ROOT.war

EXPOSE 8080

CMD ["catalina.sh", "run"]