require 'chef/mixin/shell_out'

class CookbookKerl2
  module ShellOut
    include Chef::Mixin::ShellOut

    def kerl_shell_out!(command, **kwargs)
      kwargs[:env] = node['kerl2']['environment'].merge(kwargs.fetch(:env, {}))

      shell = shell_out!("#{node['kerl2']['bin_path']} #{command}", **kwargs)
      shell.stdout.strip.split("\n")
    end
  end
end
