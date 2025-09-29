# Use a lightweight OpenJDK 11 image
FROM eclipse-temurin:11-jre-alpine

WORKDIR /app

# Install procps for debugging if needed
RUN apk add --no-cache procps curl unzip bash

# Copy fat jar
COPY snippy-note-services-service-1.0.0-SNAPSHOT.jar app.jar

# JVM tuning variables
ENV JVM_XMS=100m
ENV JVM_XMX=200m
ENV RESERVED_CODE_CACHE=150m
ENV STACK_SIZE=512k

ENV JAVA_OPTS="-Xms${JVM_XMS} -Xmx${JVM_XMX} \
 -XX:ReservedCodeCacheSize=${RESERVED_CODE_CACHE} \
 -Xss${STACK_SIZE} -XX:+UseG1GC -XX:MaxGCPauseMillis=50"

# Expose port
EXPOSE 8081

# Run Java
ENTRYPOINT ["sh", "-c", "exec java $JAVA_OPTS -jar app.jar"]
