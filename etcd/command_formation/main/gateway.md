## Gateway


```
func init() {
	rootCmd.AddCommand(newGatewayCommand())
}
```

- Also let's discuss about the command formation through AddCommand from cobra package

[AddCommand Cobra](../sub_executions/AddCommand.md)

- init function calls a function from cobra package, rootCmd is variable from cobra command

```
var (
	rootCmd = &cobra.Command{
		Use:        "etcd",
		Short:      "etcd server",
		SuggestFor: []string{"etcd"},
	}
)
```


- With this base rootCmd the base command will look like

>$ ./etcd --help
>etcd server
>
>Usage:
>  etcd [flags]
>
>Flags:
>  -h, --help   help for etcd

* newGatewayCommand returns a flag, and that is passed to addCommand function in init

```
// newGatewayCommand returns the cobra command for "gateway".
func newGatewayCommand() *cobra.Command {
	lpc := &cobra.Command{
		Use:   "gateway <subcommand>",
		Short: "gateway related command",
	}
	lpc.AddCommand(newGatewayStartCommand())

	return lpc
}
```


- From intial command a subcommand is added now

> etcd gateway

- In gateway a number of subcommand is added further through newGatewayStartCommand


### newGatewayStartCommand

```

func newGatewayStartCommand() *cobra.Command {
	cmd := cobra.Command{
		Use:   "start",
		Short: "start the gateway",
		Run:   startGateway,
	}

	cmd.Flags().StringVar(&gatewayListenAddr, "listen-addr", "127.0.0.1:23790", "listen address")
	cmd.Flags().StringVar(&gatewayDNSCluster, "discovery-srv", "", "DNS domain used to bootstrap initial cluster")
	cmd.Flags().StringVar(&gatewayDNSClusterServiceName, "discovery-srv-name", "", "service name to query when using DNS discovery")
	cmd.Flags().BoolVar(&gatewayInsecureDiscovery, "insecure-discovery", false, "accept insecure SRV records")
	cmd.Flags().StringVar(&gatewayCA, "trusted-ca-file", "", "path to the client server TLS CA file for verifying the discovered endpoints when discovery-srv is provided.")

	cmd.Flags().StringSliceVar(&gatewayEndpoints, "endpoints", []string{"127.0.0.1:2379"}, "comma separated etcd cluster endpoints")

	cmd.Flags().DurationVar(&gatewayRetryDelay, "retry-delay", time.Minute, "duration of delay before retrying failed endpoints")

	return &cmd
}
```

- subcommand added to the gateway command is 

> etcd gateway start

- Further there are flags added to the gateway start command

#### --listen-addr 

>Type: string
>Default: "127.0.0.1:23790"
>Description: Specifies the address on which the gateway will listen.

#### --discovery-srv

>Type: string
>Default: "" (empty)
>Description: Specifies the DNS domain used to bootstrap the initial cluster. This is useful for service discovery

#### --discovery-srv-name

>Type: string
>Default: "" (empty)
>Description: Specifies the service name to query when using DNS discovery.

#### --insecure-discovery

>Type: bool
>Default: false
>Description: When set, it allows accepting insecure SRV records during service discovery.


#### --trusted-ca-file

>Type: string
>Default: "" (empty)
>Description: Specifies the path to the client server TLS CA file for verifying the discovered endpoints when --discovery-srv is provided.

#### --endpoints

>Type: []string (string slice)
>Default: []string{"127.0.0.1:2379"}
>Description: A comma-separated list of etcd cluster endpoints to connect to.

#### --retry-delay

>Type: time.Duration
>Default: time.Minute (1 minute)
>Description: Specifies the duration of delay before retrying failed endpoints.

