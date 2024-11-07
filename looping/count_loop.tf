
terraform { 
  cloud { 
    
    organization = "b9kalyan" 

    workspaces { 
      name = "virtualMachine1" 
    } 
  } 
}



variable "loop1" {
  type    = list(string)
  default = ["vm1", "vm2", "vm3", "vm4"]

}

variable "cont" {
  type = list(string)

  default = ["SOUTH-EAST", "CENTRAL-WEST", "NORTH-EAST", "AUSTRELIA", "SOUTH-AMERICA"]
}

variable "map_var" {
  type = map(string)
  default = {
    vm1 = "virtual_machine1"
    vm2 = "virtual_machine2"
    vm3 = "virtual_machine3"
    vm4 = "virtual_machine4"
    vm5 = "virtual_machine5"
  }
}


locals {
  fname = [for key, value in var.map_var : upper(value)]
}
/*
resource local_file m1{
	count = length(var.loop1)

	filename = var.loop1[count.index]

#	for_each  = toset(var.cont)

#	content = local.c1val[i]
	content = "virtual machine one"

}
*/

resource "local_file" "m2" {
  for_each = toset(local.fname)

  filename = each.value
  #	filename = each.value
  content = each.value
}

