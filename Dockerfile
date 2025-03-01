# Build stage
    FROM maven:3.9.9-amazoncorretto-23-debian-bookworm AS build
    WORKDIR /app

    # Cache dependencies separately
    COPY pom.xml .
    RUN mvn dependency:go-offline -B

    # Copy source and build
    COPY src ./src
    RUN mvn package -DskipTests

    # Extract layers for better caching (if using Spring Boot 2.3.0+)
    RUN mkdir -p target/extracted && \
        java -Djarmode=layertools -jar target/*.jar extract --destination target/extracted

    # Runtime stage - using distroless for smaller attack surface
    FROM eclipse-temurin:23-jre-alpine
    WORKDIR /app

    # Add non-root user
    RUN addgroup --system --gid 1001 appuser && \
        adduser --system --uid 1001 --ingroup appuser appuser

    # Set proper permissions
    VOLUME /tmp
    RUN mkdir -p /app/logs && \
        chown -R appuser:appuser /app /tmp

    # Copy application by layers (if using layered jars)
    COPY --from=build --chown=appuser:appuser /app/target/*.jar /app/app.jar

    # Container metadata
    LABEL maintainer="InfoTitans Team" \
          application="TundeObi Application" \
          version="1.0"

    # JVM tuning for containers
    ENV JAVA_OPTS="-XX:+UseContainerSupport -XX:MaxRAMPercentage=75.0 -XX:+ExitOnOutOfMemoryError -Djava.security.egd=file:/dev/./urandom"

    # Configure graceful shutdown
    ENV SERVER_SHUTDOWN=graceful

    # Switch to non-root user
    USER appuser

    # Health check
    HEALTHCHECK --interval=30s --timeout=3s --retries=3 \
        CMD wget -q --spider http://localhost:8080/actuator/health || exit 1

    # Expose port
    EXPOSE 8080

    # Run the application
    ENTRYPOINT exec java $JAVA_OPTS -jar app.jar