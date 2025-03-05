# Use the official Tomcat base image
FROM tomcat:latest

# Copy .war file from the "target" directory to the Tomcat webapps directory
COPY webapp/target/*.war /usr/local/tomcat/webapps/

# Expose Tomcat's default port
EXPOSE 8080

# Start Tomcat server
CMD ["catalina.sh", "run"]
