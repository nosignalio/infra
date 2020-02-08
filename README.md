# infra

All infra provisioned under `nosignal.io`.

This is a combination of terraform for provisioning droplets and a Kubernetes
cluster on DigitalOcean, Ansible for configuring stand-alone/mission specific
droplets and Kubernetes resources for managing the k8s cluster.

Also included are cloud-config files (in `multipass/`) that make it easy to
spin up various local development servers using Ubuntu's [multipass][1]
virtualization service (which I run on my Windows 10 desktop (Ryzen 3 based)).

With the exception of Ansible, everything is provisioned and managed via
CircleCI.

## Copyright

Copyright &copy; 2019 Paul Stevens. All rights reserved.

## License

Licensed under the MIT License. See LICENSE for details.

[1]: https://multipass.run/
