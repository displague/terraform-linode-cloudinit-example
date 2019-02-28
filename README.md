# UserData Stackscript Example

This Terraform config for Linode Instances creates a StackScript that can be used to provision a Linode with CloudInit UserData.

CloudInit UserData used in this example was taken from:
  * <https://www.terraform.io/docs/providers/template/d/cloudinit_config.html#example-usage>

The StackScript used here was first published here:
  * <https://www.linode.com/stackscripts/view/392559>
  * <https://github.com/displague/displague-stackscripts>

## Importing the original StackScript

To import the original, public stackscript:

```sh
echo 'public_stackscript = "true"' >> public_stackscript.auto.tfvars
terraform import linode_stackscript.cloudinit_stackscript 392559
```

## More on CloudInit and UserData

- <https://packetpushers.net/cloud-init-demystified/>
- <https://cloudinit.readthedocs.io/en/latest/topics/datasources/nocloud.html>
- <https://cloudinit.readthedocs.io/en/latest/topics/datasources.html>
- <http://madorn.com/cloud-init-stages.html#.XGDTOdFOnE4>
- <https://cloudinit.readthedocs.io/en/latest/topics/examples.html>
- <https://cloudinit.readthedocs.io/en/latest/topics/debugging.html#running-single-cloud-config-modules>
- <https://github.com/delphix/cloud-init/tree/master/doc/examples>
- <https://rancher.com/docs/os/v1.x/en/installation/boot-process/cloud-init/>
- <https://cloudinit.readthedocs.io/en/latest/topics/modules.html#disk-setup>
- <https://aws.amazon.com/premiumsupport/knowledge-center/execute-user-data-ec2/>
