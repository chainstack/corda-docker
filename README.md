# Corda node Docker image

## Version
* Corda **4.1**

## Configuration
Node config file is generated via `config-gen`. Refs:
- https://docs.corda.net/corda-configuration-file.html
- https://docs.corda.net/docker-image.html#joining-an-existing-compatibility-zone

Required variables:
- `MY_EMAIL_ADDRESS`: The email address to use when generating the config. This must be the same as registered with the Zone.
- `MY_LEGAL_NAME`: The X500 to use when generating the config. This must be the same as registered with the Zone.
- `MY_PUBLIC_ADDRESS`: The public address to advertise the node on.
- `CORDA_KEY_STORE_PASSWORD`: Password for the key store.
- `NETWORKMAP_URL`: The address of the Zone’s network map service (this should be provided to you by the Zone).
- `NETWORK_TRUST_PASSWORD`: The password to the Zone Trust Root (this should be provided to you by the Zone).
- `CORDA_RPC_USER`: RPC username consisting only of word characters (a-z, A-Z, 0-9 and _).
- `CORDA_RPC_PASS`: RPC password.

Optional variables:
- `MY_P2P_PORT`: The port to advertise the node on (defaults to 10200).
- `MY_RPC_PORT`: The port to open for RPC connections to the node (defaults to 10201).
- `CORDA_DETECT_IP`: This flag toggles the auto IP detection behaviour. If enabled, on startup the node will attempt to discover its externally visible IP address first by looking for any public addresses on its network interfaces, and then by sending an IP discovery request to the network map service. Set to true to enable.
- `CORDA_NOTARY`: Optional configuration object which if present configures the node to run as a notary. Can be *validating* or *non-validating*.
