variable "gh_username" {
  description = "GitHub username whose user account will be created using the SSH Keys stored on GitHub"
}

variable "linode_token" {}

variable "ssh_pub_key" {
  default = "~/.ssh/id_rsa.pub"
}

variable "public_stackscript" {
  default = "false"
}
