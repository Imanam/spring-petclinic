# Start with a base image containing Java runtime
#FROM alpine:3.12
#RUN apk --update add openjdk13-jre
FROM openjdk:13-alpine as BUILDER

# create directory to put project
#RUN mkdir /petclinic

#change to the created directory
WORKDIR /petclinic

# Add a volume pointing to /tmp
#VOLUME /tmp/petclinic

COPY .mvn /petclinic/.mvn
COPY pom.xml /petclinic/pom.xml
COPY mvnw /petclinic/mvnw
RUN chmod +x mvnw
RUN ./mvnw dependency:go-offline
COPY src /petclinic/src
RUN ./mvnw package -DskipTests



FROM openjdk:11-jre-slim
COPY --from=BUILDER /petclinic/target/*.jar /spring-petclinic.jar

# The application's jar file
#ARG JAR_FILE=spring-petclinic*.jar

# Add the application's jar to the container
#ADD ${JAR_FILE} spring-petclinic.jar

# Make port 18080 available to the world outside this container
EXPOSE 18080

# run the deployed application
CMD java -jar /petclinic/spring-petclinic.jar


