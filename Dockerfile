FROM maven:3.9.3-eclipse-temurin-20-alpine AS builder
WORKDIR /usr/src/app
COPY ./src ./src
COPY *.xml ./
RUN mvn package

FROM bellsoft/liberica-runtime-container:jre-17-slim-musl
WORKDIR /app
COPY --from=builder /usr/src/app/target/sber-test-devops-1.0.0.jar ./sber-test-devops.jar
EXPOSE 8080
ENTRYPOINT ["java","-jar","/app/sber-test-devops.jar"]
