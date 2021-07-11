FROM openjdk:8-jdk-alpine
#copy the build artifacts
COPY ./spring-boot-web/target/spring-boot*.jar /app.jar

# java -jar /app.jar
ENTRYPOINT /script/start.sh