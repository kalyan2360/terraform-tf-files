
variable "subscription_id" {}
variable "tenant_id" {}
variable "client_id" {}
variable "client_secret" {}




variable "rg_name" {
  default = "rgTestKalyan"
}

variable "loc" {
  default = "westus2"
}

variable "v_net_name" {
  default = "vnetKK"
}

variable "vnet_address_space_ip" {
  default = ["10.1.0.0/16"]
  type    = list(string)
}

variable "subnet_name" {
  default = "subnetKK"
}

variable "subnet_space_ip" {
  default = ["10.1.0.0/24", "10.1.10.0/24"]
  type    = list(string)
}

variable "ssh_key_name" {
  default = "sshKeykk"
}

variable "nic_kk_name" {
  default = "nicKk"
}
variable "nic_ip_name" {
  default = "nicIp"
}

variable "pub_ip_name" {
  default = "pubIpkk"
}
# variable nic_ip_name{
#        default =" nic_ip"
#  }

variable "nsg" {
  default = "nsgKK"
}

variable "vm_name_kk" {
  default = "demoTestVm"
}

variable "admin_user_name" {
  default = "kalyan2"

}

variable "size" {
  default = "Standard_B1s"
}
variable "user" {
  default = "myubuntu"
}
variable "offer" {
  default = "ubuntu-24_04-lts"
}
variable "sku" {
  default = "server"
}

variable win_location{
	default = ["UK West"]
	type = list(string)
}

