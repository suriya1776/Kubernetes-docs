## CreateDefaultZapLogger

- level is const coming in

```
func CreateDefaultZapLogger(level zapcore.Level) (*zap.Logger, error) {
	lcfg := DefaultZapLoggerConfig
	lcfg.Level = zap.NewAtomicLevelAt(level)
	c, err := lcfg.Build()
	if err != nil {
		return nil, err
	}
	return c, nil
}
```

- [DefaultZapLoggerConfig](../variables/DefaultZapLoggerConfig.txt) the configuration is assigned to lcfg

```
lcfg := DefaultZapLoggerConfig
```

- Next line of code assignes the value to lcfg.level

```
lcfg.Level = zap.NewAtomicLevelAt(level)
```

[NewAtomicLevelAt](../sub_executions/NewAtomicLevelAt.md)


- Then a log level is builded


