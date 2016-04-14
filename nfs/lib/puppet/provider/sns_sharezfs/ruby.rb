Puppet::Type.type(:sns_sharezfs).provide(:ruby) do
	desc "Provider for sharing mounts for nfs on zfs file system" 
	defaultfor :osfamily => :solaris, :kernelrelease => ['5.11', '5.12']
	commands :zfs => 'zfs'
	commands :share => 'share'
	commands :grep => 'grep'
	def get_current_share(name)
		begin
			line=grep([name,'/etc/dfs/sharetab'])
		rescue Puppet::ExecutionFailure => e
			 Puppet.debug("#get_current_share had an error -> #{e.inspect}")
      			return nil
    		end
                if line == ""
			return nil
		end
		return name

	end
	def get_rw_clients(name)
		begin
			line=grep([name,'/etc/dfs/sharetab'])
		rescue Puppet::ExecutionFailure => e
			 Puppet.debug("#get_rw_clients had an error -> #{e.inspect}")
      			return nil
    		end
                if line == ""
			return nil
		end
		clients=line.split()[3].split(',')
		current_rw_client=""
        	clients.each do | value |
                	if value.include? "rw="
                        	current_rw_client=value.split('rw=')[1]
                	end
                	if value.include? "ro="
               	        	current_ro_client=value.split('ro=')[1]
                	end
        	end
		return current_rw_client
	end
	def get_ro_clients(name)
		begin
			line=grep([name,'/etc/dfs/sharetab'])
		rescue Puppet::ExecutionFailure => e
			 Puppet.debug("#get_rw_clients had an error -> #{e.inspect}")
      			return nil
    		end
                if line == ""
			return nil
		end
		clients=line.split()[3].split(',')
		current_ro_client=""
        	clients.each do | value |
                	if value.include? "rw="
                        	current_rw_client=value.split('rw=')[1]
                	end
                	if value.include? "ro="
               	        	current_ro_client=value.split('ro=')[1]
                	end
        	end
		return current_ro_client 
	end
	def get_root_clients(name)
		begin
			line=grep([name,'/etc/dfs/sharetab'])
		rescue Puppet::ExecutionFailure => e
			 Puppet.debug("#get_rw_clients had an error -> #{e.inspect}")
      			return nil
    		end
                if line == ""
			return nil
		end
		clients=line.split()[3].split(',')
		current_root_client=""
        	clients.each do | value |
                	if value.include? "root="
                        	current_root_client=value.split('root=')[1]
                	end
        	end
		return current_root_client 
	end
	def get_proto(name)
		begin
			line=grep([name,'/etc/dfs/sharetab'])
		rescue Puppet::ExecutionFailure => e
			 Puppet.debug("#get_current_share had an error -> #{e.inspect}")
      			return nil
    		end
                if line == ""
			return nil
		end
		proto = line.split()[2]
		return proto
	end
	def get_path(name)
		begin
			line=grep([name,'/etc/dfs/sharetab'])
		rescue Puppet::ExecutionFailure => e
			 Puppet.debug("#get_current_project had an error -> #{e.inspect}")
      			return nil
    		end
                if line == ""
			return nil
		end
		path = line.split()[0]
		return path
	end
	def get_zfspool(name)
		begin
			line = zfs(['get','sharenfs',name])
		rescue Puppet::ExecutionFailure => e
			 Puppet.debug("#get_current_project had an error -> #{e.inspect}")
      			return nil
    		end
                if line == ""
			return nil
		end
		return name
	end
	def get_security_modes(name)
		begin
			line=grep([name,'/etc/dfs/sharetab'])
		rescue Puppet::ExecutionFailure => e
			 Puppet.debug("#get_rw_clients had an error -> #{e.inspect}")
      			return nil
    		end
                if line == ""
			return nil
		end
		options=line.split()[3].split(',')
		secmode=""
		first=nil
        	options.each do | value |
                	if value.include? "sec="
				if first.nil?
                        		secmode=value.split('sec=')[1]
					first=1
				else
                        		secmode=secmode+":"+value.split('sec=')[1]
				end
                	end
        	end
		return secmode
	end
	def get_zfs_params()
		params = "sec="+resource[:security_modes]
		if not resource[:rw_clients].empty?
			params = params+",rw="+resource[:rw_clients]
		end
		if not resource[:ro_clients].empty?
			params = params+",ro="+resource[:ro_clients]
		end
		if not resource[:root_clients].empty?
			params = params+",root="+resource[:root_clients]
		end
	        return params
	end
	def exists?
		get_current_share(resource[:share_name]) != nil
	end
        def create
		zfs_param = "share=name="+resource[:share_name]+",path="+resource[:path]+",prot="+resource[:proto]
		if not resource[:rw_clients].empty?
			zfs_param = zfs_param+",rw="+resource[:rw_clients]
		end
		if not resource[:ro_clients].empty?
			zfs_param = zfs_param+",ro="+resource[:ro_clients]
		end
		if not resource[:root_clients].empty?
			zfs_param = zfs_param+",root="+resource[:root_clients]
		end
		zfs(['set',zfs_param,resource[:zfspool]])
		zfs(['set','sharenfs=on',resource[:zfspool]+'%'+resource[:share_name]])

	end	
	def rw_clients 
		get_rw_clients(resource[:share_name])
	end
	def rw_clients=(value)
		zfs_param = get_zfs_params()
		share(['-F',resource[:proto],'-o',zfs_param,resource[:path]])
	end
	def  ro_clients
		get_ro_clients(resource[:share_name])
	end
	def ro_clients=(value)
		zfs_param = get_zfs_params()
		share(['-F',resource[:proto],'-o',zfs_param,resource[:path]])
	end
	def  root_clients
		get_root_clients(resource[:share_name])
	end
	def root_clients=(value)
		zfs_param = get_zfs_params()
		share(['-F',resource[:proto],'-o',zfs_param,resource[:path]])
	end
	def  security_modes
		get_security_modes(resource[:share_name])
	end
	def security_modes=(value)
		zfs_param = get_zfs_params()
		share(['-F',resource[:proto],'-o',zfs_param,resource[:path]])
	end
	def  path
		get_path(resource[:path])
	end
	# Do not want to change path once it's shared. removed and create
	def path=(value)
		fail ("Can not change already shared path, unshare first")
	end
	def  proto
		get_proto(resource[:path])
	end
	def proto=(value)
		zfs_param = get_zfs_params()
		share(['-F',resource[:proto],'-o',zfs_param,resource[:path]])
	end
	def  zfspool
		get_zfspool(resource[:zfspool])
	end
	# DO not want to change the zfs pool details once a its shared. removed share first. To avoid unused shares left behind
	def zfspool=(value)
		fail ("Can not change already shared path with this pool, unshare first")
	end
        def destroy 
		zfs_param = "share=path="+resource[:path]
		zfs(['set','-c',zfs_param,resource[:zfspool]])
	end	
end
