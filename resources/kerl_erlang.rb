## Compiles and installs a version of erlang with kerl

# older versions of Chef don't support require_relative...
require ::File.join(::File.dirname(__FILE__), '../libraries/shell_out')
include CookbookKerl2::ShellOut

resource_name :kerl_erlang

# if the build doesn't exist, will create it
property :build_name, String, name_property: true, required: true
property :basedir, String, default: lazy { node['kerl2']['erlangs_path'] }
property :basename, String, default: lazy { build_name }

default_action :install

action :install do
  unless kerl_erlang_exists?
    kerl_build build_name

    ruby_block "install kerl build #{build_name}" do
      block do
        Chef::Log.info("Installing kerl build #{build_name} to #{kerl_erlang_path}")
        kerl_shell_out!("install #{build_name} #{kerl_erlang_path}")
      end
    end

    new_resource.updated_by_last_action true
  end
end

def kerl_erlang_exists?
  expected_line = "#{build_name} #{kerl_erlang_path}"
  kerl_shell_out!('list installations').any? { |line| line == expected_line }
end

def kerl_erlang_path
  ::File.join(basedir, basename)
end

# the path to the activate script
def activate_path
  ::File.join(kerl_erlang_path, 'activate')
end
