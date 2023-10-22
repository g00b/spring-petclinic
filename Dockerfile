FROM   openjdk:17-oracle
LABEL maintainer="gabemartino@protonmail.com"
COPY /target/spring-petclinic-3.1.0-SNAPSHOT.jar /home/spring-petclinic-3.1.0.jar 
CMD ["java","-jar","/home/spring-petclinic-3.1.0.jar"]
