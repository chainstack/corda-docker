FROM corda/corda-zulu-java1.8-4.6

ADD --chown=corda:corda https://jdbc.postgresql.org/download/postgresql-42.2.14.jar /opt/corda/drivers/postgresql.jar
