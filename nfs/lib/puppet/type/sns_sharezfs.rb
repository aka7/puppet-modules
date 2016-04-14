Puppet::Type.newtype(:sns_sharezfs) do
  desc "Puppet type to share nfs mounts on zfs file system"

  ensurable

  newparam(:share_name, :namevar => true) do
    desc "share name"
    munge do |value|
      value.downcase
    end
    def insync?(is)
      is.downcase == should.downcase
    end
  end

  newproperty(:path) do
    desc "path to share as nfs"
  end

  newproperty(:proto) do
    desc "proto, nfs/smb"
  end
  newproperty(:security_modes) do
    desc "security modes"
  end
  newproperty(:zfspool) do
    desc "zfs pool the share is on "
  end
  newproperty(:rw_clients) do
    desc "client ip addresses to give rw access"
  end
  newproperty(:ro_clients) do
    desc "client ip addresses to give ro access"
  end
  newproperty(:root_clients) do
    desc "client ip addresses to give root access"
  end

end
