FROM maven:3.9.9-amazoncorretto-23-debian-bookworm AS build
WORKDIR /app

# Copy the pom.xml file
COPY pom.xml .
# Download all required dependencies into one layer
RUN mvn dependency:go-offline -B

# Copy source code
COPY src ./src

# Build the application
RUN mvn package -DskipTests

# For the runtime image
FROM eclipse-temurin:23-jre-alpine
VOLUME /tmp
WORKDIR /app

# Copy the entire JAR file
COPY --from=build /app/target/*.jar app.jar

# Run the application
ENTRYPOINT ["java", "-jar", "app.jar"]

# Container runs on port 8080
EXPOSE 8080