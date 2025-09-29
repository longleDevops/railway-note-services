#!/bin/sh
exec java \
 -Xms100m \
 -Xmx200m \
 -XX:ReservedCodeCacheSize=150m \
 -Xss512k \
 -XX:+UseG1GC \
 -XX:MaxGCPauseMillis=70 \
 -jar app.jar
