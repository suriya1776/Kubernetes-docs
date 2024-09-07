### AddCommand

```
func (c *Command) AddCommand(cmds ...*Command){

}
```

- Let's analyze the function line by line


```
	rootCmd = &cobra.Command{
		Use:        "etcd",
		Short:      "etcd server",
		SuggestFor: []string{"etcd"},
	}
```

- From rootCmd a AddCommand is called

```
rootCmd.AddCommand(newGatewayCommand())
```

```
func newGatewayCommand() *cobra.Command {
	lpc := &cobra.Command{
		Use:   "gateway <subcommand>",
		Short: "gateway related command",
	}
	lpc.AddCommand(newGatewayStartCommand())

	return lpc
}
```

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

[Execeution in newGatewayStartCommand](newGatewayStartCommand.md)

- In above link it is briefly explained how the command is formed, In a cmd instance start, in flags variable the flags available is added using cmd.Flags().StringVar and the cmd is passed as argument to AddCommand to be appended to gateway command

### AddCommand continuation
```
func (c *Command) AddCommand(cmds ...*Command) {

}
```

- The argument comming in will be Command struct with the respective flags

```
for i, x := range cmds {

}
```
- The cmds is itreated , i is the index and x is the value if the index

```
if cmds[i] == c {
	panic("Command can't be a child of itself")
}
```

- If the command name is present as the subcommand , then error is thrown

```
cmds[i].parent = c

parent *Command
```
- The command coming in is added a parent in the subcommand

```
usageLen := len(x.Use)
if usageLen > c.commandsMaxUseLen {
	c.commandsMaxUseLen = usageLen
}
```

- Length of the Use from the cmd is taken and assigned to var usageLen
- Check if the length variable commandMaxUseLen is lesser than the usageLen, which will be, so the length is assigned to commandMaxUseLen

```
commandPathLen := len(x.CommandPath())
	if commandPathLen > c.commandsMaxCommandPathLen {
			c.commandsMaxCommandPathLen = commandPathLen
    }
```
- Command path checks if it has a parent command, and the hasParent command is recusively called and return commandPath and name seperated by a space
- In short, It calculate total length of the command

```
nameLen := len(x.Name())
		if nameLen > c.commandsMaxNameLen {
			c.commandsMaxNameLen = nameLen
		}
```

- Same way the length of the name is calculated

```
if c.globNormFunc != nil {
			x.SetGlobalNormalizationFunc(c.globNormFunc)
}
```

- Skipping this if loop.

```
c.commands = append(c.commands, x)
c.commandsAreSorted = false
```

- The subcommands are added to the commands variable with value and commandAreSorted is false



