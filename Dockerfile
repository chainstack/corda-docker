FROM corda/corda-zulu-4.0

LABEL vendor="Chainstack"

COPY --chown=corda:corda config-gen.sh /opt/corda/bin/config-gen

CMD ["run-corda"]
