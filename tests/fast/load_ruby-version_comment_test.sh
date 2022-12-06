: prepare
true TMPDIR:${TMPDIR:=/tmp}:
d=$TMPDIR/test-user
mkdir -p $d
cd $d
unset GEM_HOME GEM_PATH
PATH="$( echo $PATH | sed 's/^.*rvm[^:]*://' | sed 's/:[^:]*rvm[^:]*$//' )" # env[PATH]!=/rvm/
"$rvm_path/bin/rvm" install 3.0.1               # status=0
"$rvm_path/bin/rvm" 3.0.1 do rvm gemset create test # status=0
"$rvm_path/bin/rvm" install 3.0.5               # status=0
"$rvm_path/bin/rvm" alias delete default        # status=0
"$rvm_path/bin/rvm" alias create default 3.0.5  # status=0

echo "3.0.1" > .ruby-version
echo "test" > .ruby-gemset
source "$rvm_path/scripts/rvm"
# env[GEM_HOME]=/3.0.1@test$/
# env[PATH]=/3.0.1@test/

: teardown
rvm alias delete default 3.0.5
rm -rf $d
