🔹 Interview-Ready Explanation of This Dockerfile

👉 “I’ve written a multi-stage Dockerfile for a Java Spring Boot application to optimize image size, caching, and security. Let me explain step by step.”

1. Multi-stage build concept

“I used two stages — a build stage with Maven and a runtime stage with JRE.
This ensures that Maven and other build tools are not part of the final image, reducing size and security risks.”

2. Build stage
FROM maven:3.8.5-openjdk-11-eclipse-temurin AS build
WORKDIR /app
COPY pom.xml .
RUN mvn dependency:resolve
COPY src ./src
RUN mvn clean package


“Here I pull the Maven image with JDK 11.
First, I copy only pom.xml and download dependencies. This leverages Docker layer caching, so if only source code changes, dependencies are not redownloaded every time.
Then maven will download all dependencies defined in pom.xml into local Maven repository.(~/.m2/repository). maven dependencies plugin will download all direct dependencies of project.



**Very important**
maven dependencies plugin will download all direct project dependencies present in pom.xml(~/.m2/repositroy) docker caches this layer. means suppsoe when we want change only source code (src) dependencies dont need to be download again.

mvn clean → removes any previously compiled classes and target artifacts (ensures a fresh build).
mvn package → compiles the source code, runs tests, and packages the application into a JAR/WAR in the target/ directory.
Why we do it in Docker:
Generates the final artifact inside the container, which can then be copied to the runtime stage in a multi-stage build.
Keeps the runtime image clean (without Maven, source code, or build tools), reducing image size and attack surface.

3. Runtime stage
FROM openjdk:11-jre-slim AS runtime
WORKDIR /app
COPY --from=build /app/target/*.jar app.jar


“In runtime, I use a lightweight openjdk:11-jre-slim base image, which contains only what is required to run the JAR.
I copy the JAR from the build stage to keep the final image clean and small.”

4. Application configuration
EXPOSE 8000
RUN useradd -ms /bin/bash appuser
USER appuser
ENV JAVA_OPTS="-Xmx512m -Xms256m"


“I expose port 8000 for external access.
For security, I run the application as a non-root user instead of root.
I also define JAVA_OPTS for JVM tuning (heap size) so that memory consumption is controlled in containerized environments.”

5. Entrypoint and CMD
ENTRYPOINT ["sh", "-c", "java $JAVA_OPTS -jar app.jar"]
CMD ["--spring.profiles.active=prod"]


“I use ENTRYPOINT to define the main process (java -jar app.jar).
I use CMD to pass additional runtime arguments, like setting the Spring profile to prod.
This way, I can override profiles easily at runtime without changing the image.”

✅ Wrap-up Summary

👉 “In short, this Dockerfile follows best practices — multi-stage for smaller images, caching dependencies for faster builds, running as non-root for security, JVM tuning with JAVA_OPTS, and flexible runtime configuration using ENTRYPOINT + CMD. This is production-ready, efficient, and secure.”


during the build stage maven reads pom.xml to download dependencies
and compile the source code into runnable JAR file which is then
copied into final runtime image