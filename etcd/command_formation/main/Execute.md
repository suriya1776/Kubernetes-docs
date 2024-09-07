## Execute

```
func (c *Command) Execute() error {
	_, err := c.ExecuteC()
	return err
}
```


- ExecuteC function is called from this function

### ExecuteC

- Line by line exection is explained below

```
func (c *Command) ExecuteC() (cmd *Command, err error) {

}
```
- Command struct is coming in , returns the cmd and error if any

```
if c.ctx == nil {
		c.ctx = context.Background()
	}
```

- c.ctx is null at start , In Command struct it is ctx context.Context , a new context is assigned here

```
if c.HasParent() {
		return c.Root().ExecuteC()
	}
```

- Checks if the function is called on not root command, if yes if make execute in root only


```
if preExecHookFn != nil {
		preExecHookFn(c)
}
```
- In windows some may trigger the etcd server application by double clicking the file rather then executing from cli, at that time the execution halts.


#### InitDefaultHelpCmd()

[InitDefaultHelpCmd execution](../sub_executions/InitDefaultHelpCmd.md)

- Purpose: This function initializes a default "help" command for the CLI application.

#### c.InitDefaultCompletionCmd()
- Purpose: This function initializes a default "completion" command for the CLI application.

#### c.checkCommandGroups()
- Purpose: This function ensures that all command groups are properly set up

```
	args := c.args

	// Workaround FAIL with "go test -v" or "cobra.test -test.v", see #155
	if c.args == nil && filepath.Base(os.Args[0]) != "cobra.test" {
		args = os.Args[1:]
	}
```

- args is nil, also I am skipping the function as it is for test thing.

- Skipping the steps and jumping to execute function

```
err = cmd.execute(flags)
```

#### execute 

