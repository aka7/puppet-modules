Puppet::Type.newtype(:sol_project) do
  desc "Puppet type that creates/modifys solaris project"

  ensurable

  newparam(:name, :namevar => true) do
    desc "project  name"
    munge do |value|
      value.downcase
    end
    def insync?(is)
      is.downcase == should.downcase
    end
  end

  newproperty(:comment) do
    desc "comments"
  end

  newproperty(:users) do
    desc "Users"
  end

  newproperty(:groups) do
    desc "groups for project"
  end
  newproperty(:id) do
    desc "project id"
  end
  newproperty(:attribs, :array_matching => :all) do
    desc "attributes"
    def insync?(is)
      is.sort == should.sort
    end
  end

end
