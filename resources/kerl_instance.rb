## An instance of the kerl script

resource_name :kerl_instance

# can be any git reference
property :version, String, name_property: true, required: true
property :url, String, default: lazy {
  "https://raw.githubusercontent.com/kerl/kerl/#{version}/kerl" }
property :checksum, String, default: lazy {
  node['kerl2']['checksums'][version] }
property :install_path, String, default: lazy {
  "/opt/kerl/instances/kerl_#{version}" }
# whether to make it available system-wide
property :system_wide, [TrueClass, FalseClass], default: true

default_action :install

action :install do
  directory ::File.dirname(install_path) do
    recursive true
  end

  remote_file install_path do
    source url
    checksum checksum
    mode 0755
  end

  if system_wide
    file_content = [
      '#!/bin/sh',
      node['kerl2']['environment'].map { |key, value| "export #{key}='#{value}'" },
      "#{install_path} $@"
    ].flatten.join("\n")

    file node['kerl2']['bin_path'] do
      content file_content
      mode 0755
    end
  end
end
