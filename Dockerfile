FROM openjdk:17-alpine AS builder
ADD target/sms-0.0.1-SNAPSHOT.jar sms.jar
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "sms.jar"]

