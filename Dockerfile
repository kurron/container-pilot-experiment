FROM azul/zulu-openjdk:8u121

MAINTAINER Ron Kurr "kurr@jvmguy.com"

#EXPOSE 8080

#ENTRYPOINT ["java", "-server", "-Xms128m", "-Xmx128m", "-Djava.awt.headless=true",  "-jar", "/opt/echo.jar"]

#COPY build/libs/echo-0.0.0.RELEASE.jar /opt/echo.jar

CMD ["java", "-version"]
