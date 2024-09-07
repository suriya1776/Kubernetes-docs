### GRPC proxy

The same as the gateway , the subcommand is added to the root directory

The flags that are added to the subcommand are

#### Flags Added to the start Subcommand:
--listen-addr: Specifies the address on which the gRPC proxy will listen.
--discovery-srv: The domain name to query for SRV records describing etcd cluster endpoints.
--discovery-srv-name: The service name to query when using DNS discovery.
--metrics-addr: Address to listen for /metrics endpoint requests on an additional interface.
--insecure-discovery: Allows accepting insecure SRV records during service discovery.
--endpoints: A list of etcd cluster endpoints that the proxy will connect to.
--endpoints-auto-sync-interval: Interval for automatically syncing etcd endpoints.
--dial-keepalive-time: Keepalive time for gRPC proxy connections.
--dial-keepalive-timeout: Timeout for keepalive pings in gRPC proxy connections.
--permit-without-stream: Allows gRPC proxy clients to send keepalive pings even without active RPCs.
--advertise-client-url: The address that the gRPC proxy advertises to clients.
--resolver-prefix: Prefix used for registering the proxy (must be shared among proxy members).
--resolver-ttl: TTL for registering proxy endpoints.
--namespace: Prefix added to all keys for namespacing requests.
--enable-pprof: Enables runtime profiling data via an HTTP server at /debug/pprof/.
--data-dir: Directory for storing persistent data.
--max-send-bytes: Maximum size in bytes for sent messages.
--max-recv-bytes: Maximum size in bytes for received messages.
--grpc-keepalive-min-time: Minimum interval before a client can ping the proxy.
--grpc-keepalive-interval: Frequency of server-to-client pings.
--grpc-keepalive-timeout: Additional wait time before closing a non-responsive connection.


#### Client TLS Flags (for connecting to the server):
--cert: TLS certificate file for secure connections to etcd servers.
--key: TLS key file for secure connections to etcd servers.
--cacert: CA bundle for verifying TLS-enabled secure etcd servers.
--insecure-skip-tls-verify: Skips verification of TLS certificates (for testing only).


#### Client TLS Flags (for connecting to the proxy):
--cert-file: TLS certificate file for secure connections to the proxy.
--key-file: TLS key file for secure connections to the proxy.
--trusted-ca-file: CA bundle for verifying TLS-enabled secure proxy.
--listen-cipher-suites: Supported TLS cipher suites between client and proxy.
--auto-tls: Enables automatic generation of TLS certificates.
--client-crl-file: Proxy client certificate revocation list file.
--self-signed-cert-validity: Validity period of proxy certificates in years.


#### Experimental Flags:
--experimental-serializable-ordering: Ensures serializable reads have monotonically increasing store revisions across endpoints.
--experimental-leasing-prefix: Leasing metadata prefix for disconnected linearized reads.


#### Other Flags:
--debug: Enables debug-level logging for the gRPC proxy.
--max-concurrent-streams: Maximum concurrent streams each client can open.