### InitDefaultHelpCmd

```
func (c *Command) InitDefaultHelpFlag() {
	c.mergePersistentFlags()
	if c.Flags().Lookup("help") == nil {
		usage := "help for "
		if c.Name() == "" {
			usage += "this command"
		} else {
			usage += c.Name()
		}
		c.Flags().BoolP("help", "h", false, usage)
		_ = c.Flags().SetAnnotation("help", FlagSetByCobraAnnotation, []string{"true"})
	}
}
```

- mergePersistentFlags function is called

#### mergePersistentFlags

```
func (c *Command) mergePersistentFlags() {
	c.updateParentsPflags()
	c.Flags().AddFlagSet(c.PersistentFlags())
	c.Flags().AddFlagSet(c.parentsPflags)
}
```

#### updateParentsPflags

```
func (c *Command) updateParentsPflags() {

}
```

- Command struct is incoming variable
```
	if c.parentsPflags == nil {
		c.parentsPflags = flag.NewFlagSet(c.Name(), flag.ContinueOnError)
		c.parentsPflags.SetOutput(c.flagErrorBuf)
		c.parentsPflags.SortFlags = false
	}
```
>// parentsPflags is all persistent flags of cmd's parents.
	parentsPflags *flag.FlagSet
- This is null, we have not set this variable before
- [NewFlagSet for parentsPflags](../variables/parentPflagsFlagSet.txt)

>func (c *Command) Name() string {
	name := c.Use
	i := strings.Index(name, " ")
	if i >= 0 {
		name = name[:i]
	}
	return name
}

- The parent flag is formed and added to the parentPflags

```
if c.globNormFunc != nil {
		c.parentsPflags.SetNormalizeFunc(c.globNormFunc)
}
```

