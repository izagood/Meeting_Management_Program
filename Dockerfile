FROM openjdk:17-jdk-slim As builder
COPY gradlew .
COPY gradle gradle
COPY build.gradle .
COPY settings.gradle .
COPY src src
RUN chmod +x ./gradlew
RUN ./gradlew bootJar

FROM openjdk:17-jdk-slim
COPY --from=builder build/libs/*.jar app.jar

EXPOSE 8080
#ENTRYPOINT ["java", "-Dspring.profiles.active=dev,console-log,file-log", "-jar", "/app.jar"]
ENTRYPOINT ["java", "-Dspring.profiles.active=dev", "-jar", "/app.jar"]
