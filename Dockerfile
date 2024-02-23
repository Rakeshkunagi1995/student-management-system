FROM openjdk:17-alpine AS builder

# Set working directory
WORKDIR /app

# Copy project files
COPY src /app/src
COPY pom.xml /app

# Install Maven dependencies
RUN apk add --no-cache maven

# Build the project
RUN mvn -f /app/pom.xml clean package -DskipTests

# Create a slimmer image for production
FROM openjdk:17-alpine

# Copy JAR file from build stage
COPY --from=build /app/target/sms-0.0.1-SNAPSHOT.jar /app/sms.jar

# Set working directory
WORKDIR /app

# Expose port 9001
EXPOSE 9001

# Start the application
CMD ["java", "-jar", "sms.jar"]
