#replaces line on a give list of files
class sites::replace_line($file_list){	
	create_resources('sites::file_line', $file_list)
}
