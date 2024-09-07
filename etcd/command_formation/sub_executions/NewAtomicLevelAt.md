## NewAtomicLevelAt

```
func NewAtomicLevelAt(l zapcore.Level) AtomicLevel {
	a := NewAtomicLevel()
	a.SetLevel(l)
	return a
}
```

- Function takes in a argument 
- Level value is passed , l maybe equal to InfoLevel
- NewAtomicLevel function is assigned to a
- return a will be loglevel , more probebly InfoLevel

```
func NewAtomicLevel() AtomicLevel {
	lvl := AtomicLevel{l: new(atomic.Int32)}
	lvl.l.Store(int32(InfoLevel))
	return lvl
}
```

- [AtomicLevel](#atomiclevel) is a struct
- Step 1 - This creates a new AtomicLevel struct with l pointing to a newly allocated atomic.Int32
- Step 2 - This sets the value of the atomic.Int32 pointed to by l to the integer value of InfoLevel.
- Step 3 - The function returns the lvl struct.


### AtomicLevel

```
type AtomicLevel struct {
	l *atomic.Int32
}
```
- The AtomicLevel struct contains a single field l, which is a pointer to an atomic.Int32. This is a type from Go's sync/atomic package, providing atomic operations on int32 values.