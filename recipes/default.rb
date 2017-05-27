## Installs kerl, all OTP releases listed in `node['kerl2']['erlangs']`,
## and also renders the shell profile file to source where needed

# install dependencies
include_recipe "#{cookbook_name}::dependencies"

# install kerl
kerl_instance node['kerl2']['version']

# install erlangs
kerl_erlang_resources = node['kerl2']['erlangs'].map do |erlang|
  kerl_erlang erlang
end

# render the shell profile file
default_erlang = kerl_erlang_resources.first
if node['kerl2']['shell_profile']['file'] && default_erlang
  directory ::File.dirname(node['kerl2']['shell_profile']['file']) do
    recursive true
  end

  file node['kerl2']['shell_profile']['file'] do
    content "source #{default_erlang.activate_path}\n"
  end
end
