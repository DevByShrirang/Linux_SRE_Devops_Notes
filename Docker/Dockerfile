#FROM maven:3.8.5-openjdk-11-eclipse-temurin AS build
FROM maven:3.8.5-eclipse-temurin-17 AS build
WORKDIR /app

# Copy pom.xml and download dependencies first (better caching)
COPY pom.xml .
RUN mvn dependency:resolve

# Copy source and build the app
COPY src ./src
RUN mvn clean package -DskipTests

# -------- Runtime Stage --------

#FROM openjdk:17-jre-slim AS runtime
FROM eclipse-temurin:17-jre-jammy AS runtime
WORKDIR /app
# --from=build /app/target/*.jar app.
COPY --from=build /app/target/*.jar app.jar

# Expose application port
EXPOSE 8000

# Create non-root user with home directory
RUN useradd -ms /bin/bash appuser

# Switch to non-root user
USER appuser

#set jvm option
ENV JAVA_OPTS="-Xms256m -Xmx512m"     

#set ENTRYPOINT & CMD
ENTRYPOINT ["java", "-jar", "app.jar"]
CMD ["--spring.profiles.active=prod"]