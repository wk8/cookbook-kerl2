include_recipe 'build-essential'

package 'curl' do
  not_if { lazy { `which curl` ; $?.exitstatus == 0 }}
end
