#!/usr/bin/env bash

CORDA_DB_USER=${CORDA_DB_USER:-sa}
CORDA_DB_PASS=${CORDA_DB_PASS:-dbpass}
CORDA_DB_DRIVER=${CORDA_DB_DRIVER:-org.h2.jdbcx.JdbcDataSource}
CORDA_H2_PORT=${CORDA_H2_PORT:-9090}
CORDA_DB_URL="jdbc:h2:file:${PERSISTENCE_FOLDER};DB_CLOSE_ON_EXIT=FALSE;LOCK_TIMEOUT=10000;WRITE_DELAY=100;AUTO_SERVER_PORT=${CORDA_H2_PORT}"
CORDA_DETECT_IP=${CORDA_DETECT_IP:-false}

CORDA_P2P_ADDRESS=${CORDA_P2P_ADDRESS:-$MY_PUBLIC_ADDRESS:$MY_P2P_PORT}
CORDA_RPC_ADDRESS=${CORDA_RPC_ADDRESS:-0.0.0.0:$MY_RPC_PORT}
CORDA_RPC_ADMIN_ADDRESS=${CORDA_RPC_ADMIN_ADDRESS:-0.0.0.0:$MY_RPC_ADMIN_PORT}

cat > ${CONFIG_FOLDER}/node.conf <<EOL
emailAddress="${MY_EMAIL_ADDRESS}"
myLegalName="${MY_LEGAL_NAME}"
keyStorePassword: "${CORDA_KEY_STORE_PASSWORD}"

dataSourceProperties: {
    dataSourceClassName:"${CORDA_DB_DRIVER}"
    dataSource.url:"${CORDA_DB_URL}"
    dataSource.user:"${CORDA_DB_USER}"
    dataSource.password:"${CORDA_DB_PASS}"    
}

networkServices {
    doormanURL="${NETWORKMAP_URL}"
    networkMapURL="${NETWORKMAP_URL}"
}
trustStorePassword:"${NETWORK_TRUST_PASSWORD}"

p2pAddress="${CORDA_P2P_ADDRESS}"
detectPublicIp=${CORDA_DETECT_IP}

rpcSettings {
    address="${CORDA_RPC_ADDRESS}"
    adminAddress="${CORDA_RPC_ADMIN_ADDRESS}"
}
security {
    authService {
        dataSource {
            type=INMEMORY
            users=[
                {
                    password="${CORDA_RPC_PASS}"
                    permissions=[
                        ALL
                    ]
                    username="${CORDA_RPC_USER}"
                }
            ]
        }
    }
}

EOL

if [ ! -z "$CORDA_NOTARY" ]; then
    if [ "$CORDA_NOTARY" == "non-validating" ]; then
        NOTARY_VAL=false
    fi
    if [ "$CORDA_NOTARY" == "validating" ]; then
        NOTARY_VAL=true
    fi    

cat >> ${CONFIG_FOLDER}/node.conf <<EOL
notary {
    validating=${NOTARY_VAL}
}

EOL
fi
