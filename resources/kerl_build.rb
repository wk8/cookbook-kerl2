## Compiles an erlang build with kerl

# older versions of Chef don't support require_relative...
require ::File.join(::File.dirname(__FILE__), '../libraries/shell_out')
include CookbookKerl2::ShellOut

resource_name :kerl_build

property :name, String, name_property: true, required: true
property :release, String, default: lazy { name }
# see https://github.com/kerl/kerl#build-configuration
property :build_env, Hash, default: {}

default_action :build

action :build do
  unless kerl_build_exists?
    kerl_shell_out!('update releases')
    Chef::Log.info("Building Erlang/OTP release #{release}, this is going to take a few minutes...")
    kerl_shell_out!("build #{release} #{name}", env: build_env,
                    # building an OTP release can take a little while..
                    timeout: 3600)

    new_resource.updated_by_last_action true
  end
end

def kerl_build_exists?
  kerl_shell_out!('list builds').any? { |line| line == "#{release},#{name}" }
end
