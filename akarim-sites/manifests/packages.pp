#installs multiple packages from a given hash
class sites::packages($package_data){	
	create_resources('sites::package', $package_data)
}

