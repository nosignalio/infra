# multipass

Leverages cloud-init to install software and packages on the multipass instance
used for local development on my Windows 10 desktop.

## deployment

To deploy a multipass system using a cloud-init file:

```
multipass launch --name developer --cloud-init infra\multipass\developer-cloud-config.yaml
```

Easy as.
