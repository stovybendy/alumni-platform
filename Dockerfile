# Stage 1: Build the application using Maven
FROM maven:3.8.5-openjdk-17-slim AS build
WORKDIR /app
COPY pom.xml .
# Download dependencies first to cache them
RUN mvn dependency:go-offline -B
COPY src ./src
# Build the WAR file
RUN mvn clean package -DskipTests

# Stage 2: Run in Tomcat
FROM tomcat:10.1-jdk17
# Remove default webapps
RUN rm -rf /usr/local/tomcat/webapps/*
# Copy the built WAR from the build stage
COPY --from=build /app/target/alumni-platform.war /usr/local/tomcat/webapps/ROOT.war

EXPOSE 8080
CMD ["catalina.sh", "run"]
