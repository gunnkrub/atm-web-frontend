FROM alpine/git as clone
WORKDIR /app
RUN git clone https://github.com/gunnkrub/atm-web-frontend

FROM maven:3.5-jdk-8-alpine as build
WORKDIR /app
COPY --from=clone /app/atm-web-frontend /app
RUN mvn install

FROM openjdk:8-jre-alpine
WORKDIR /app
COPY --from=build /app/target/atm-0.0.1-SNAPSHOT.jar /app
EXPOSE 8090
CMD ["java", "-jar", "atm-0.0.1-SNAPSHOT.jar"]
