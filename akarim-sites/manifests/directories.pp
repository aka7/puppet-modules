#creates multiple directories from a given hash
class sites::directories($directory_list){	
	create_resources('sites::directory', $directory_list)
}

