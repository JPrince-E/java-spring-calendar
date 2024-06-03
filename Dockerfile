# Stage 1: Build the application with Maven
FROM maven:3.8.5-openjdk-17 AS build
WORKDIR /app
COPY . .
RUN mvn clean package -DskipTests

# Stage 2: Copy the built application to a minimal image and run it
FROM openjdk:17.0.1-jdk-slim
COPY --from=build /app/target/calendar-0.0.1-SNAPSHOT.jar calendar.jar
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "calendar.jar"]
