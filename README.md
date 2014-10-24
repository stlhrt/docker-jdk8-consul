stlhrt/jdk8-consul
=========================
Docker base container for using Oracle JDK8 on Ubuntu Trusty Tahr in a [_Consul_](http://www.consul.io/) cluster.
Consul runs as regular agent, configured via environment variables to connect to cluster.
User adding application layer to this image will need to add configoration for registering a service like:

```javascript
{
  "service": {
    "name": "the-site",
    "tags": ["web"],
    "port": 8080,
    "check": {
      "script": "/bin/nc -z 8080",
      "interval": "10s"
    }
  }
}
```
