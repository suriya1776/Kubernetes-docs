### newGatewayStartCommand


```
// This variable is cmd
type Command struct{

        Use:   "start",
		Short: "start the gateway",
		Run:   startGateway,
}
```

```
cmd.Flags().StringVar(&gatewayListenAddr, "listen-addr", "127.0.0.1:23790", "listen address")
```

>Flags:
      --discovery-srv string        DNS domain used to bootstrap initial cluster
      --discovery-srv-name string   service name to query when using DNS discovery
      --endpoints strings           comma separated etcd cluster endpoints (default [127.0.0.1:2379])
  -h, --help                        help for start
      --insecure-discovery          accept insecure SRV records
      --listen-addr string          listen address (default "127.0.0.1:23790")
      --retry-delay duration        duration of delay before retrying failed endpoints (default 1m0s)
      --trusted-ca-file string      path to the client server TLS CA file for verifying the discovered endpoints when discovery


- Under ==etcd gateway start== command the above flags are added using , and the whole thing is appended to the rootcommand


- analyze the [cmd.Flags()](#cmdflags)
- [StringVar](#stringvar)

#### cmdFlags

```
func (c *Command) Flags() *flag.FlagSet {
	if c.flags == nil {
		c.flags = flag.NewFlagSet(c.displayName(), flag.ContinueOnError)
		if c.flagErrorBuf == nil {
			c.flagErrorBuf = new(bytes.Buffer)
		}
		c.flags.SetOutput(c.flagErrorBuf)
	}

	return c.flags
}
```
-  A FlagSet struct is assigned to c.flags,

- c.flags is nil at start
```
c.flags = flag.NewFlagSet(c.displayName(), flag.ContinueOnError)
```

- Argument that are passes in, c.displayName is a function and errorHandling const

- [c.displayName](#displayname) returns the name in command instance
- flag.ContinueOnError an error handling const is passed
- [flag.NewFlagSet](#newflagset)



#### displayName

```
func (c *Command) displayName() string {
	if displayName, ok := c.Annotations[CommandDisplayNameAnnotation]; ok {
		return displayName
	}
	return c.Name()
}
```

- Receving the command struct and returning a string
- c.Annotations[CommandDisplayNameAnnotation]:
This accesses the Annotations map of the c object, which is presumably an instance of a Command struct.
CommandDisplayNameAnnotation is the key being checked in the Annotations map.
- displayName, ok := c.Annotations[CommandDisplayNameAnnotation]; ok:
displayName: If the key CommandDisplayNameAnnotation exists in the map, displayName will be set to the value associated with that key.
ok: This is a boolean that will be true if the key exists in the map and false if it does not.
- if ... ; ok { return displayName }:
The if statement checks the value of ok.
If ok is true, it means the key exists, and the function returns displayName.

- No such annotations is added to struct, so it is false and ==c.Name() function is called==


#### c.Name()

- cmd instance named cmd is taken here, from file [cmd](../variables/command_struct.txt)

```
func (c *Command) Name() string {
	name := c.Use
	i := strings.Index(name, " ")
	if i >= 0 {
		name = name[:i]
	}
	return name
}
```
- This code takes the Use from the command instance and add as name and returns the name
- Below code removes the empty spaces in the name If any.
- For ex - the cmd intance is considered the ==name is start==


#### newflagset

```
func NewFlagSet(name string, errorHandling ErrorHandling) *FlagSet {
	f := &FlagSet{
		name:          name,
		errorHandling: errorHandling,
	}
	f.Usage = f.defaultUsage
	return f
}
```

- argument coming in  is name and errorHandling, returns a FlagSet

```
type FlagSet struct {
	Usage func()

	name          string
	parsed        bool
	actual        map[string]*Flag
	formal        map[string]*Flag
	args          []string // arguments after flags
	errorHandling ErrorHandling
	output        io.Writer         // nil means stderr; use Output() accessor
	undef         map[string]string // flags which didn't exist at the time of Set
}
```

#### StringVar

```
func (f *FlagSet) StringVar(p *string, name string, value string, usage string) {
	f.Var(newStringValue(value, p), name, usage)
}
```
