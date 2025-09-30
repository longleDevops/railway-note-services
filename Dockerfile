# Use lightweight OpenJDK 11 with full JDK tools
FROM eclipse-temurin:11-jdk-alpine

WORKDIR /app

# Install procps, bash, curl, unzip for diagnostics
RUN apk add --no-cache procps bash curl unzip

# Copy fat jar
COPY snippy-note-services-service-1.0-runner.jar app.jar

# Expose app port
EXPOSE 8081

# JVM tuning environment variables (can override in Railway UI)
ENV JVM_XMS=80m
ENV JVM_XMX=100m
ENV RESERVED_CODE_CACHE=130m
ENV STACK_SIZE=300k
ENV MAX_GC_PAUSE=20

# Compose all JVM options into a single environment variable
ENV JAVA_OPTS="-Xms${JVM_XMS} -Xmx${JVM_XMX} \
 -XX:ReservedCodeCacheSize=${RESERVED_CODE_CACHE} \
 -Xss${STACK_SIZE} -XX:+UseG1GC -XX:MaxGCPauseMillis=${MAX_GC_PAUSE}"

# Run Java directly with JAVA_OPTS
ENTRYPOINT ["sh", "-c", "exec java -jar app.jar"]
