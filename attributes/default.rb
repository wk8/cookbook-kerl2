# latest as of 05/26/17
default['kerl2']['version'] = '1.5.1'

# which erlangs to install; should be an array of OTP releases
# the first one is special in that it will be the one activated in the shell
# profile (if `node['kerl2']['shell_profile']['enabled']` is set to true)
default['kerl2']['erlangs'] = %w(19.3)

# see the comment on `['kerl2']['erlangs']` above
default['kerl2']['shell_profile']['enabled'] = true
default['kerl2']['shell_profile']['file'] = '/etc/profile.d/kerl.sh'

# system-wide bin
default['kerl2']['bin_path'] = '/usr/local/bin/kerl'
default['kerl2']['erlangs_path'] = '/opt/kerl/erlangs'

# see https://github.com/kerl/kerl#tuning
default['kerl2']['environment'] = {
  'KERL_BASE_DIR' => '/opt/kerl/base_dir'
}

# maps versions to the checksum
default['kerl2']['checksums'] = {
  '0.8'   => '943a94e7317b6c5d95becffd2491b86906ba20c92f24f2f1d9dcc69d6bb042d0',
  '0.9.1' => 'defb16ba081302135a45cf09eadfa05b64a4906c62edf432d2e9b8a49415a54e',
  '0.9'   => '48d8c2abec3a9567114426defbb9254e87db654ef027dd7a1c0bd58c94fb2399',
  '1.0.1' => 'c9f86413169dd2e04c64f0aaacc6fd9cfee552482e22e15dade6cbc790fca545',
  '1.0'   => '5e91fd7285cd0b4257084d40257836d2b88025e8039e0b9fa5dc8a0d5c60be70',
  '1.1.0' => 'd1f52e820225b4142eef3577911ab9294d4b3706fe475ff392dc8c3a0eb5a9a6',
  '1.1.1' => '7719c8daf24c12c676757cd4681367c1a6da86672b343b7b93f714f70ace6b58',
  '1.2.0' => 'b708e228a4e18b2f7ac6828ea192643a57647ba2b74acd5104920c95b8c7e892',
  '1.3.0' => '317cd49fa86da4be902c073742eb502ef765abe667ae3ff573230ad5c0c087e5',
  '1.3.1' => '8c99021012f50f8656e1eaaf26cee5aa522b19c1f8eb58cb572a712fa2ad5cde',
  '1.3.2' => '2209b316b15492ac81411dcbb3034de1b0e61cbb0d590966e1c908ee6c30e795',
  '1.3.3' => 'd1e66fe01ee1af0acf58c63f3efe77e5206b7957c6773dff2a8415a9c7b5a7b6',
  '1.3.4' => '9b60e9e40e63ea81f43a1e43a045c2130a3a2b129d6ec74e33229dc4d9933607',
  '1.4.0' => '6fcef15b2e54e2185beaa8a1bf200b9b13bda25af859b144a9efa5fd7a17bead',
  '1.4.1' => '5f37bac62a5443012f39c233073275309498b3da9422f9fb9525a17b263a67e2',
  '1.4.2' => '989596f66e813a69d0db3847900476cf6c0bed38cae73dac6eae1cd3f8610c54',
  '1.5.0' => '1700998235fb250099516b8839558f12a7686162d23ac2842e34746818892816',
  '1.5.1' => '76cba3108e8a6780e2a6819c3784c43357f4f88565542a2d955f7db765221b49'
}
