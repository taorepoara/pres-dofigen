# syntax=docker/dockerfile:1.7
# This file is generated by Dofigen v2.1.0
# See https://github.com/lenra-io/dofigen

# runtime
FROM eclipse-temurin@sha256:4b2851daf1f84dfc80b2574de320a6040fb91ddd409f60ac0482f5bcb8d46dea AS runtime
COPY \
    --chown=1000:1000 \
    --link \
    "." "./"
USER 0:0
RUN <<EOF
./mvnw clean package -DskipTests
mv target/*.jar app.jar
EOF
USER 1000:1000
CMD ["java", "-jar", "app.jar"]
