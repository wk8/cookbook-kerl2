Kerl cookbook
=============

A [Chef](https://www.chef.io/) cookbook to manage Erlang instances with [kerl](https://github.com/kerl/kerl).

The motivation here was that [existing kerl cookbook on the supermarket](https://supermarket.chef.io/cookbooks/kerl) doesn't provide features to manage different Erlang versions, plus it hasn't been updated since 2011.

# Usage

The easiest (and also most likely covering most use cases) way to use this cookbook simply overriding one node attribute: `node['kerl2']['erlangs']` to be the list of OTP releases you want to have around, e.g. `%w(19.1 19.0 18.3)`; then run the `default` recipe that will:
1. install dependencies
2. install `kerl`
3. install the requested releases
4. install a system-wide wrapper (by default at `/usr/local/bin/kerl`) around `kerl` so that all users can use these releases
5. render a shell profile file (`/etc/profile.d/kerl.sh` by default) to activate the _first_ of these OTP releases

Then it's business as usual with `kerl`.

Additionally, if you need to use the default `kerl`-managed erlang in a Chef-templated script, you can simply source that shell profile file in there. For example, if you have a [runit](https://github.com/chef-cookbooks/runit) service using erlang, its `run` script template could look something like:

```erb
#!/bin/bash

source <%= node['kerl2']['shell_profile']['file'] %>

exec <%= node['runit']['chpst_bin'] %> -u user:group my_erlang_service
```

For more exotic use cases, simply set `node['kerl2']['erlangs']` to an empty array, and use the resources this cookbook provides:

# Resources

## kerl_instance

An instance of the kerl script.

Available properties:

| Name | Type | Default | Explanation |
| ---- | ---- | ------- | ----------- |
| version (name property) | String | | Any git reference from the official kerl repo |
| url | String | `"https://raw.githubusercontent.com/kerl/kerl/#{version}/kerl"` | The URL to download kerl from |
| install_path | String | `"/opt/kerl/instances/kerl_#{version}"` | Where to install the script |
| system_wide | Boolean | True | If true, will create a wrapper at `node['kerl2']['bin_path']` around this instance of kerl |

## kerl_build

A kerl build (see [kerl's README](https://github.com/kerl/kerl/blob/master/README.md) for more info).

Available properties:

| Name | Type | Default | Explanation |
| ---- | ---- | ------- | ----------- |
| name (name property) | String | | |
| release | String | `name` | The name of the OTP release |
| build_env | Hash | `{}` | [Environment variables to use for the build](https://github.com/kerl/kerl#build-configuration) |

## kerl_erlang

A kerl installation (see [kerl's README](https://github.com/kerl/kerl/blob/master/README.md) for more info).

Available properties:

| Name | Type | Default | Explanation |
| ---- | ---- | ------- | ----------- |
| build_name (name property) | String | | The name of the kerl build to install - that can be the name of a `kerl_build` resource, otherwise this resource will also create a build with that name |
| basedir | String | `node['kerl2']['erlangs_path']` | The base directory where to install this erlang |
| basename | String | `build_name` | The name of the directory, inside the base directory, to which this erlang will be installed |

## Example

Example recipe using these resources to get a build with custom options:

```ruby
build_name = '19.3-with-docs-and-hipe'

kerl_build build_name do
  release '19.3'
  build_env({
    'KERL_BUILD_DOCS' => 'yes',
    'KERL_CONFIGURE_OPTIONS' => '‐‐enable‐hipe'
  })

kerl_erlang build_name
```

# Node attributes' reference

* `['kerl2']['version']`: which version of kerl to use with the `default` recipe
* `['kerl2']['erlangs']`: see [the Usage section above](https://github.com/wk8/cookbook-kerl2#usage)
* `['kerl2']['shell_profile']['file']`: see [the Usage section above](https://github.com/wk8/cookbook-kerl2#usage)
* `['kerl2']['bin_path']`: see [the section about the `kerl_instance` resource above](https://github.com/wk8/cookbook-kerl2#kerl_instance)
* `['kerl2']['erlangs_path']`: the default path where erlangs are installed (see [the section about the `kerl_erlang` resource above](https://github.com/wk8/cookbook-kerl2#kerl_erlang))
* `['kerl2']['environment']`: configuration environment variables for kerl ([see kerl's doc for more info](https://github.com/kerl/kerl#tuning)) - simply defines `KERL_BASE_DIR` by default
* `['kerl2']['checksums']`: maps each version of kerl to each SHA256 checksum
