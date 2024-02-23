FROM openjdk:17-alpine AS builder
COPY src /app/src
COPY pom.xml /app

RUN mvn -f /app/pom.xml clean package -DskipTests
FROM openjdk:17-alpine

COPY --from=maven-builder app/target/sms-0.0.1-SNAPSHOT.jar /app-service/sms.jar
WORKDIR /app-service

EXPOSE 8080
ENTRYPOINT ["java","-jar","sms.jar"]
