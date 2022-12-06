rvm_reload_flag=1 source "$rvm_path/scripts/rvm"

: prepare
true TMPDIR:${TMPDIR:=/tmp}:
d=$TMPDIR/test-versions-conf
mcd(){ mkdir -p $1 ; cd $1 ; }
mcd $d
rm -f */*

: generate
mcd $d/a
rvm use 3.0.1@versions-conf-a --create --versions-conf --install
rvm current             # match=/^ruby-3.0.1@versions-conf-a$/
[[ -f .versions.conf ]] # status=0

mcd $d/b
rvm use 3.1.3@versions-conf-b --create --versions-conf --install
rvm current             # match=/^ruby-3.1.3@versions-conf-b$/
[[ -f .versions.conf ]] # status=0

: test
rvm rvmrc load $d/a
rvm current         # match=/^ruby-3.0.1@versions-conf-a$/
rvm rvmrc load $d/b
rvm current         # match=/^ruby-3.1.3@versions-conf-b$/

: test bundler without flag of doom
mcd $d/b ## on travis cd hook is disabled ?
rvm rvmrc load $d/b
gem list # match!=/haml/
printf "ruby-gem-install=bundler\nruby-bundle-install=true\n" >> .versions.conf
printf "source :rubygems\n\ngem 'haml'\n" > Gemfile
rvm_current_rvmrc=""
rvm rvmrc load . # match!=/Installing haml/
gem list # match!=/haml/; match=/bundler/

: test bundler with flag of doom
mcd $d/b ## on travis cd hook is disabled ?
rvm rvmrc load $d/b
gem list # match!=/haml/
printf "ruby-gem-install=bundler\nruby-bundle-install=true\n" >> .versions.conf
printf "source :rubygems\n\ngem 'haml'\n" > Gemfile
rvm_current_rvmrc=""
rvm_autoinstall_bundler_flag=1
rvm rvmrc load . # match=/Installing haml/
gem list # match=/haml/; match=/bundler/

: clean
rvm 3.0.1 do rvm --force gemset delete versions-conf-a
rvm 3.1.3 do rvm --force gemset delete versions-conf-b
rm -rf $d
