# Use lightweight OpenJDK 11
FROM eclipse-temurin:11-jre-alpine

WORKDIR /app

RUN apk add --no-cache procps bash curl unzip

COPY snippy-note-services-service-1.0.0-SNAPSHOT.jar app.jar

# Compose JAVA_OPTS from environment variables (set via Railway UI)
ENV JAVA_OPTS="-Xms${JVM_XMS} -Xmx${JVM_XMX} \
 -XX:ReservedCodeCacheSize=${RESERVED_CODE_CACHE} \
 -Xss${STACK_SIZE} -XX:+UseG1GC -XX:MaxGCPauseMillis=70"

EXPOSE 8081

ENTRYPOINT ["sh", "-c", "exec java $JAVA_OPTS -jar app.jar"]
