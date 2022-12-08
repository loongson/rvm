source "$rvm_path/scripts/rvm"

rvm use 3.1.0 --install

:
rvm gemset copy 3.1.0 3.1.0@testset # status=0; match=/Copying gemset/; match[stderr]=/^$/
rvm gemset list                     # status=0; match=/ testset$/
rvm gemset --force delete testset   # status=0; match=/Removing gemset testset/
rvm gemset list                     # status=0; match!=/ testset$/
