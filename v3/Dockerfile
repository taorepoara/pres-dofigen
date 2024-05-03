# syntax=docker/dockerfile:1.4

# builder-0
FROM maven:3.9-eclipse-temurin-17-alpine AS builder-0
ADD --link . ./
USER 0
RUN \
    mvn clean package -DskipTests

# runtime
FROM eclipse-temurin:17-jre-alpine AS runtime
COPY --link --chown=1000:1000 --from=builder-0 "target/*.jar" "app.jar"
USER 1000
CMD ["java","-jar","app.jar"]
