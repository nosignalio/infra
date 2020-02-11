<#
.SYNOPSIS
Spin up a multipass instance and pass in a cloud-init file
.DESCRIPTION
Wraps the multipass launch, mount and exec commands to spin up an instance with a
specific cloud-init file to configure it with.
.PARAMETER Service
The type of instance to configure
.EXAMPLE
multipass-create developer developer-cloud-config
.LINK
https://github.com/nosignalio/infra/multipass
#>
param(
  [Parameter(Mandatory=$true)][string]$Service,
  [Parameter(Mandatory=$false)][int]$Nodes
)

If ($Service -eq 'developer') {
  If ([int]$Nodes -gt 1) {
    'Too many developer nodes. Go away.'
    exit
  }
  multipass launch --name ${Service} --cloud-init E:\Code\infra\multipass\cloud-init\${Service}.yaml
  multipass mount E:\Code ${Service}:/home/ubuntu/code
  multipass transfer E:\Secrets\ssh\gitkeys ${Service}:/home/ubuntu/.ssh/gitkeys
  multipass transfer E:\Secrets\ssh\gitkeys.pub ${Service}:/home/ubuntu/.ssh/gitkeys.pub
  multipass transfer E:\Secrets\ssh\config ${Service}:/home/ubuntu/.ssh/config
  multipass exec ${Service} -- chmod 0600 /home/ubuntu/.ssh/gitkeys
  multipass exec ${Service} -- chmod 0600 /home/ubuntu/.ssh/gitkeys.pub
  multipass exec ${Service} -- chmod 0600 /home/ubuntu/.ssh/config
  multipass exec ${Service} -- git config --global user.name "Paul Stevens"
  multipass exec ${Service} -- git config --global user.email "ps@nosignal.io"
  multipass info ${Service}
} ElseIf ($Service -eq 'mysql') {
  'Not currently supported.'
} Elseif ($Service -eq 'k8s') {
  'Not currently supported.'
} Else {
  'The type provided is not supported. Kthxbye.'
}
