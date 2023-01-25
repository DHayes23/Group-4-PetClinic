FROM maven:3.8.4-openjdk-8 AS backbuild

WORKDIR /build

COPY . /build

RUN mvn clean package

FROM openjdk:8 AS runback

WORKDIR /runtime

COPY --from=backbuild /build/target/spring-petclinic-rest-2.6.2.jar app.jar

EXPOSE 9966

ENTRYPOINT ["java", "-jar", "app.jar"]