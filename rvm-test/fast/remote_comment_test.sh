source "$rvm_path/scripts/rvm"

: prepare
true TMPDIR:${TMPDIR:=/tmp}:
d=$TMPDIR/test-remote
mkdir $d
pushd $d
rvm use 3.0.5 --install # status=0
rvm list
# match=/ruby-3.0.5/

: tast packaging
rvm prepare 3.0.5           # status=0
[[ -f ruby-3.0.5.tar.bz2 ]] # status=0

: remove it
rvm remove --gems 3.0.5     # status=0
rvm list
# match!=/ruby-3.0.5/

: get local ruby
rvm mount -r ruby-3.0.5.tar.bz2 # status=0
rvm list
# match=/ruby-3.0.5/
rvm use 3.0.5 # status=0; match[stderr]=/^$/

: clean
popd
rm -rf $d
