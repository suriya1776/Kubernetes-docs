### etcdMainNewConfig

```
func newConfig() *config {

}
```

- function returns a config
```
	cfg := &config{
		ec:      *embed.NewConfig(),
		ignored: ignored,
	}
```

>type config struct {
	ec           embed.Config
	cf           configFlags
	configFile   string
	printVersion bool
	ignored      []string
}

- For ec embed.NewConig is a function
- [embed NewConfig execution](../sub_executions/embedNewConfig.md)
