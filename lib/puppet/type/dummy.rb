require 'puppet/type'

Puppet::Type.newtype(:dummy) do
  @doc = <<-EOT
    Dummy Type
  EOT

  ensurable

  newparam(:path, :namevar => true) do
    desc "Some param"
  end

  autorequire(:notify) do
    req = ['notify1']

    puts "!!!!! Autorequire for Dummy Type called for the test below"
    req
  end
end
