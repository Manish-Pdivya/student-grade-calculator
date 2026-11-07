
# Stage 1: Build the Maven application
FROM maven:3.9-eclipse-temurin-17 AS build

WORKDIR /app

COPY pom.xml .
COPY src ./src

# Compile, run JUnit tests and create the JAR
RUN mvn clean package

# Stage 2: Create the runtime image
FROM eclipse-temurin:17-jre

WORKDIR /app

# Copy the generated JAR from the build stage
COPY --from=build /app/target/student-grade-calculator-1.0-SNAPSHOT.jar app.jar

# Run the Java application
ENTRYPOINT ["java", "-cp", "app.jar", "com.example.GradeCalculator"]