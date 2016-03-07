Puppet::Type.type(:sol_project).provide(:ruby) do
	desc "Provider for project settings on Oracle Solaris"
    	defaultfor :operatingsystem => :solaris
	commands :grep => 'grep'
	commands :projmod => 'projmod'
	commands :projadd => 'projadd'
	commands :projdel => 'projdel'
	def get_current_project(name)
		begin
			line=grep([name,'/etc/project'])
		rescue Puppet::ExecutionFailure => e
			 Puppet.debug("#get_current_project had an error -> #{e.inspect}")
      			return nil
    		end
                if line == ""
			return nil
		end
		return "ok"

	end
	def get_attribs(name)
		begin
			line=grep([name,'/etc/project'])
		rescue Puppet::ExecutionFailure => e
			 Puppet.debug("#get_current_project had an error -> #{e.inspect}")
      			return nil
    		end
                if line == ""
			return nil
		end
		current_attribs = line.split(':')[5].strip
		attribs=current_attribs.split(';').sort
	end
	def get_users(name)
		begin
			line=grep([name,'/etc/project'])
		rescue Puppet::ExecutionFailure => e
			 Puppet.debug("#get_current_project had an error -> #{e.inspect}")
      			return nil
    		end
                if line == ""
			return nil
		end
		users = line.split(':')[3]
	end
	def get_groups(name)
		begin
			line=grep([name,'/etc/project'])
		rescue Puppet::ExecutionFailure => e
			 Puppet.debug("#get_current_project had an error -> #{e.inspect}")
      			return nil
    		end
                if line == ""
			return nil
		end
		groups = line.split(':')[4]
	end
	def get_id(name)
		begin
			line=grep([name,'/etc/project'])
		rescue Puppet::ExecutionFailure => e
			 Puppet.debug("#get_current_project had an error -> #{e.inspect}")
      			return nil
    		end
                if line == ""
			return nil
		end
		id = line.split(':')[1]
	end
	def get_comment(name)
		begin
			line=grep([name,'/etc/project'])
		rescue Puppet::ExecutionFailure => e
			 Puppet.debug("#get_current_project had an error -> #{e.inspect}")
      			return nil
    		end
                if line == ""
			return nil
		end
		comment = line.split(':')[2]
	end

	def exists?
		get_current_project(resource[:name]) != nil
	end
        def create
		projadd(['-p',resource[:id],'-U',resource[:users],'-c',resource[:comment],'-G',resource[:groups],resource[:name]])
		attribs=resource[:attribs]
		count=1
		attribs.each do |attrib_value|
                        if count == 1
                                projmod(['-K',attrib_value,resource[:name]])
                        else
                                projmod(['-sK',attrib_value,resource[:name]])
                        end
                        count = count + 1
                end

	end	
	def users
		get_users(resource[:name])
	end
	def users=(value)
		projmod(['-U',value,resource[:name]])
	end
	def id 
		get_id(resource[:name])
	end
	def id=(value)
		projmod(['-p',value,resource[:name]])
	end
	def groups 
		get_groups(resource[:name])
	end
	def groups=(value)
		projmod(['-G',value,resource[:name]])
	end
	def comment 
		get_comment(resource[:name])
	end
	def comment=(value)
		projmod(['-c',value,resource[:name]])
	end
	def attribs
		get_attribs(resource[:name])
	end
	def attribs=(value)
		count = 1
		value.each do |attrib_value|
			if count == 1
				projmod(['-K',attrib_value,resource[:name]])
			else
				projmod(['-sK',attrib_value,resource[:name]])
			end
			count = count + 1
		end
  	end
        def destroy 
		projdel([resource[:name]])
	end	
end
