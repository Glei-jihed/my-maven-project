
FROM maven:latest AS build
COPY . /usr/src/app
WORKDIR /usr/src/app
RUN mvn clean install

FROM openjdk:11-jre-slim
COPY --from=build /usr/src/app/target/my-maven-project-1.0-SNAPSHOT.jar /usr/app/app.jar

RUN apt-get update && \
    apt-get install -y nginx && \
    rm -rf /var/lib/apt/lists/*

COPY nginx.conf /etc/nginx/nginx.conf


EXPOSE 80


CMD service nginx start && java -jar /usr/app/app.jar

