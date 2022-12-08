source "$rvm_path/scripts/rvm"

: prepare
true TMPDIR:${TMPDIR:=/tmp}:
d=$TMPDIR/test-rvmrc
mkdir $d
pushd $d
command rvm install 3.1.3
rvm 3.1.3 do rvm gemset reset_env
rvm use 3.0.5 --install

: .rvmrc generated
rvm rvmrc create 3.1.3
[ -f .rvmrc ]         # status=0
rvm current           # match=/3.0.5/
rvm rvmrc trust .rvmrc
rvm rvmrc load .rvmrc # env[GEM_HOME]=/3.1.3$/ ; env[PATH]=/3.1.3/
rvm current           # match=/3.1.3/

: .rvmrc with use
rvm_current_rvmrc=""
echo "rvm use 3.0.5" > .rvmrc
rvm rvmrc trust .
rvm rvmrc load .
rvm current           # match=/3.0.5/

: .rvmrc without use
rvm_current_rvmrc=""
echo "rvm 3.1.0" > .rvmrc
rvm rvmrc trust
rvm rvmrc load
rvm current           # match=/3.1.0/

rm -f .rvmrc
rvm use 3.0.5

: .versions.conf
rvm rvmrc create 3.1.0 .versions.conf
[ -f .versions.conf ] # status=0
rvm current           # match=/3.0.5/
rvm rvmrc load .
rvm current           # match=/3.1.0/

rm -f .versions.conf
rvm use 3.0.5

: .ruby-version
rvm rvmrc create 3.1.0 .ruby-version
[ -f .ruby-version ]  # status=0
rvm current           # match=/3.0.5/
rvm rvmrc load .
rvm current           # match=/3.1.0/

rm -f .ruby-version
rvm use 3.0.5

: clean
popd
rm -rf $d
