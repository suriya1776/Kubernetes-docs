### embed New Config

```
func NewConfig() *Config {

}
```

- This function returns a config

```
lpurl, _ := url.Parse(DefaultListenPeerURLs)
apurl, _ := url.Parse(DefaultInitialAdvertisePeerURLs)
lcurl, _ := url.Parse(DefaultListenClientURLs)
acurl, _ := url.Parse(DefaultAdvertiseClientURLs)
```

> DefaultListenPeerURLs = "http://localhost:2380"
DefaultInitialAdvertisePeerURLs = "http://localhost:2380"
DefaultListenClientURLs = "http://localhost:2379"
DefaultAdvertiseClientURLs =  "http://localhost:2379"


- [config variable ]()


