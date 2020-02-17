# infra

All infra provisioned under `nosignal.io`.

This is a combination of terraform for provisioning droplets and a Kubernetes
cluster on DigitalOcean, Ansible for configuring stand-alone/mission specific
droplets and Kubernetes resources for managing the k8s cluster.

Also included are cloud-config files (in `multipass/`) that make it easy to
spin up various local development servers using Ubuntu's [multipass][1]
virtualisation service (which I run on my Windows 10 desktop (Ryzen 3 based)).

With the exception of Ansible, everything is provisioned and managed via
CircleCI.

## Note

All of the infra behind this has been torn down with most emphasis falling on
stuff I can spin up and manage on the grossly overspecced ex-gaming rig that
sits on my desk. Frankly, I'd rather save the money and have a weekend away
every few months, rather than bother with running infra for personal projects
that will never be seen.

## Copyright

Copyright &copy; 2019 Paul Stevens. All rights reserved.

## License

Licensed under the MIT License. See LICENSE for details.

[1]: https://multipass.run/
