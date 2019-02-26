# Taken from:
#   https://www.terraform.io/docs/providers/template/d/cloudinit_config.html#example-usage
# Uses:
#   https://www.linode.com/stackscripts/view/392559

data "template_file" "script" {
  template = "${file("${path.module}/init.tpl")}"

  vars {
    gh_username = "${var.gh_username}"
  }
}

# Render a multi-part cloud-init config making use of the part
# above, and other source files
data "template_cloudinit_config" "config" {
  gzip          = true
  base64_encode = true

  # Main cloud-config configuration file.
  part {
    filename     = "init.cfg"
    content_type = "text/cloud-config"
    content      = "${data.template_file.script.rendered}"
  }

  part {
    content_type = "text/x-shellscript"

    content = <<EOF
#!/bin/bash
/bin/echo "Hello World" >> /tmp/testfile.txt
EOF
  }

  part {
    content_type = "text/x-shellscript"

    content = <<EOF
#!/bin/bash
/bin/echo "Hello World 2" >> /tmp/testfile2.txt
EOF
  }
}

provider "linode" {
  token = "${var.linode_token}"
}

resource "linode_stackscript" "cloudinit_stackscript" {
  script = "${chomp(file("${path.module}/stackscript.sh"))}"

  description = <<EOF
This StackScript takes a base64 encoded `userdata` variable which will be provided to `cloud-init` on boot.

Request changes at https://github.com/displague/displague-stackscripts
EOF

  rev_notes = "initial cloud-init script"

  images = ["linode/debian8",
    "linode/debian9",
    "linode/ubuntu16.04lts",
    "linode/ubuntu18.04",
    "linode/ubuntu18.10",
    "linode/ubuntu14.04lts",
  ]

  is_public = "${var.public_stackscript}"
  label     = "CloudInit"
}

# Start an AWS instance with the cloud-init config as user data
resource "linode_instance" "test" {
  image           = "linode/debian9"
  type            = "g6-nanode-1"
  stackscript_id  = "${linode_stackscript.cloudinit_stackscript.id}"
  region          = "us-east"
  authorized_keys = ["${chomp(file(var.ssh_pub_key))}"]

  stackscript_data = {
    "userdata" = "${data.template_cloudinit_config.config.rendered}"
  }
}
