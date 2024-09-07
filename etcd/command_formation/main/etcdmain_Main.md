## etcdmain

The command line arguments are passed into the function

```
func Main(args []string) {

}
```

checkSupportArch function is called

```
checkSupportArch()
```
[checkSupportArch Function execution](../sub_executions/checkSupportArch.md)

- From the architecture check the execution is returned here

```
	if len(args) > 1 {
		cmd := args[1]
		switch cmd {
		case "gateway", "grpc-proxy":
			if err := rootCmd.Execute(); err != nil {
				fmt.Fprint(os.Stderr, err)
				os.Exit(1)
			}
			return
		}
	}
```

- Check the argument is greater than 1
- Then assign the 1st argument to cmd, If the command is etcd gateway then cmd is gateway
- switch is initiated to compare with some cases
- cmd is compared with gateway and grpc-proxy , if it matches then the block is executed.

```
	if err := rootCmd.Execute(); err != nil {
		fmt.Fprint(os.Stderr, err)
		os.Exit(1)
	}
```

- rootCmd variable is part of the etcdmain package same as this main function, init function from server/etcdmain/gateway.go and server/etcdmain/grcpc_proxy.go

- [Init execution of gateway](../main/gateway.md)
- [Init execution of grcpcproxy](../main/grpc_proxy.md)
- [Execute command execution](../main/Execute.md)



- If the command is just etcd,

```
startEtcdOrProxyV2(args)
```

- [startEtcdOrProxyV2](../sub_executions/startEtcdOrProxyV2.md)

