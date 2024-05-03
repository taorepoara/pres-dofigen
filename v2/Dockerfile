# syntax=docker/dockerfile:1.4

# runtime
FROM eclipse-temurin:17-jdk AS runtime
ADD --link . ./
USER 0
RUN \
    ./mvnw clean package -DskipTests && \
    mv target/*.jar app.jar
USER 1000
CMD ["java","-jar","app.jar"]
