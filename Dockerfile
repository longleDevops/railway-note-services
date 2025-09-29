# Use lightweight OpenJDK 11
FROM eclipse-temurin:11-jre-alpine

WORKDIR /app

RUN apk add --no-cache procps bash curl unzip

COPY snippy-note-services-service-1.0.0-SNAPSHOT.jar app.jar
COPY start.sh start.sh

EXPOSE 8081

ENTRYPOINT ["sh", "start.sh"]

