include_recipe 'build-essential'

package 'curl' do
  not_if { lazy { `which curl` ; $?.exitstatus == 0 }}
end

# needed for crypto
case node['platform_family']
when 'debian'
  package %w(tar libncurses5-dev openssl libssl-dev)
when 'rhel', 'fedora'
  package %w(tar ncurses-devel openssl-devel)
when 'suse'
  package %w(tar ncurses-devel libopenssl-devel)
end
