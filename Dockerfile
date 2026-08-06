FROM gradle:8.14-jdk21 AS build

WORKDIR /app

COPY build.gradle settings.gradle ./

RUN gradle bootJar --no-daemon -x test

FROM eclipe-termurin:21-jre

WORKDIR /app

COPY --from=build /app/build/lib/*.jar app.jar

ENTRYPOINT["java", "-jar", "app.jar"]