# Build stage
FROM gradle:8-jdk21 as builder
WORKDIR /app
COPY . .
RUN gradle build --no-daemon -x test 2>&1 || true

# Runtime stage
FROM eclipse-temurin:21-jre-alpine
WORKDIR /app
COPY --from=builder /app/build/libs/*.jar app.jar

EXPOSE 8080
ENTRYPOINT ["java", "-jar", "app.jar"]
