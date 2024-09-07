## checkSupportArch

Function has no arguments passed

```
func checkSupportArch() {

}
```

A function is called in the second line of the function, logutil is from  "go.etcd.io/etcd/client/pkg/v3/logutil"

Argument passed is zap.InfoLevel , which is from "go.uber.org/zap"

[zap.InfoLevel Returns](../sub_executions/zap_InfoLevel.md)

- zap InfoLevel is a const , it returns a empty const 

[CreationDefaultZapLogger Function exection](../sub_executions/CreationDefaultZapLogger.md)

```
lg, err := logutil.CreateDefaultZapLogger(zap.InfoLevel)
```

```
	if err != nil {
		panic(err)
	}
```

- If the error is not equal to null, then a execution is stopped with a panic error

```
	if runtime.GOARCH == "amd64" ||
		runtime.GOARCH == "arm64" ||
		runtime.GOARCH == "ppc64le" ||
		runtime.GOARCH == "s390x" {
		return
	}
```

- Is the system has any of the above architecture, the function is exited immediately

```
	defer os.Unsetenv("ETCD_UNSUPPORTED_ARCH")
	if env, ok := os.LookupEnv("ETCD_UNSUPPORTED_ARCH"); ok && env == runtime.GOARCH {
		lg.Info("running etcd on unsupported architecture since ETCD_UNSUPPORTED_ARCH is set", zap.String("arch", env))
		return
	}

	lg.Error("running etcd on unsupported architecture since ETCD_UNSUPPORTED_ARCH is set", zap.String("arch", runtime.GOARCH))
	os.Exit(1)
```


- If the ETCD_UNSUPPORTED_ARCH is set based on that the logs are generated