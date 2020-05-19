FROM corda/corda-zulu-java1.8-4.4

ADD --chown=corda:corda https://jdbc.postgresql.org/download/postgresql-42.2.12.jar /opt/corda/drivers/postgresql.jar
