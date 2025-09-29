# Use lightweight OpenJDK 11
FROM eclipse-temurin:11-jre-alpine

WORKDIR /app

RUN apk add --no-cache procps bash curl unzip

COPY snippy-note-services-service-1.0.0-SNAPSHOT.jar app.jar

# Expose port
EXPOSE 8081

# Build JAVA_OPTS dynamically at runtime (Railway UI env vars will exist here)
ENTRYPOINT ["sh", "-c", "exec java -Xms${JVM_XMS} -Xmx${JVM_XMX} \
 -XX:ReservedCodeCacheSize=${RESERVED_CODE_CACHE} \
 -Xss${STACK_SIZE} -XX:+UseG1GC -XX:MaxGCPauseMillis=50 -jar app.jar"]
