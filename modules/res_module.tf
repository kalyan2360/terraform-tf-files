
variable fname{
	type = list(string)
	default = ["abc.txt","xyz.log"]
} 

variable cont{
	type = list(string)
	default = ["this is for vm1","this for vm2"]
}

variable len{
	type = map(any)
	default = {
		leng = 17
		spl = true
		ovr_spl = "this is for random resource vm2"
}
}

resource local_file vm1{
	filename = var.fname[0]
	content = var.cont[0]
}

resource random_string vm2{
	length = var.len[0]
	special = var.len[1]
	override_special = var.len[2]
}
