

# fname and cont variable of type list(string) in vm1 

# len variable of list(any)  in vm2 

variable vm1fname {
	type = list(string)
	default = ["dev.log","feature.log"]
}

variable vm1cont {
	type = list(string)
	default = ["this is the value for module vm3","this is the value for module vm4"]
}

variable len2 {
	type = map(any)
	default = {
		len3 = 29
		spl3 = false
		ovr_spl3 = "this from module vm4"
}
}

module vm3{
	source = "./config"
	fname = var.vm1fname[0]
	cont = var.vm1cont[0]
	
}

module vm4{
	source = "./config"
	 len = var.len2.len3
	len  = var.len2.spl3
	len = var.len2.over_spl3
#	count = length(var.len2)
#	len = count.index
}

