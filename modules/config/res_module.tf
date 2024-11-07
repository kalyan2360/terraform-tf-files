
variable "fname" {
  type    = list(string)
  default = ["abc.txt", "xyz.log"]
}

variable "cont" {
  type    = list(string)
  default = ["this is for vm1", "this for vm2"]
}

variable "len" {
  type    = list(any)
  default = [10, true, "this the random string override special value"]
}

resource "local_file" "vm1" {
  filename = var.fname[0]
  content  = var.cont[0]
}

resource "random_string" "vm2" {
  length           = var.len[0]
  special          = var.len[1]
  override_special = var.len[2]
}
