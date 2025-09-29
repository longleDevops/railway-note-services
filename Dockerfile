# Lightweight OpenJDK 11 Alpine image
FROM eclipse-temurin:11-jdk-alpine

WORKDIR /app

# Install minimal utilities
RUN apk add --no-cache procps bash curl unzip

# Copy fat jar
COPY snippy-note-services-service-1.0.0-SNAPSHOT.jar app.jar

# JVM tuning variables optimized for ~50 concurrent users
ENV JVM_XMS=250m
ENV JVM_XMX=250m
ENV METASPACE=120m
ENV RESERVED_CODE_CACHE=80m
ENV STACK_SIZE=512k
ENV GC_THREADS=2
ENV CI_COMPILER=2

# Compose JAVA_OPTS with performance enhancements
ENV JAVA_OPTS="-Xms${JVM_XMS} -Xmx${JVM_XMX} \
 -XX:MaxMetaspaceSize=${METASPACE} \
 -XX:ReservedCodeCacheSize=${RESERVED_CODE_CACHE} \
 -Xss${STACK_SIZE} \
 -XX:CICompilerCount=${CI_COMPILER} \
 -XX:ConcGCThreads=${GC_THREADS} \
 -XX:G1ConcRefinementThreads=${GC_THREADS} \
 -XX:MaxGCPauseMillis=15 \
 -XX:+UseCompressedOops \
 -XX:+UseCompressedClassPointers \
 -XX:+TieredCompilation \
 -XX:+AggressiveOpts \
 -XX:+AlwaysPreTouch \
 -XX:+OptimizeStringConcat \
 -XX:+UseStringDeduplication \
 -XX:+UnlockExperimentalVMOptions \
 -XX:+UseZGC \
 -XX:G1HeapRegionSize=1m"

# Expose port
EXPOSE 8081

# Run Java directly
ENTRYPOINT ["sh", "-c", "exec java $JAVA_OPTS -jar app.jar"]

#ps aux | grep java
