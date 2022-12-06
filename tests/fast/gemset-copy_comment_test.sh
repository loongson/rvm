source "$rvm_path/scripts/rvm"

rvm use 3.0.1 --install

:
rvm gemset copy 3.0.1 3.0.1@testset # status=0; match=/Copying gemset/; match[stderr]=/^$/
rvm gemset list                     # status=0; match=/ testset$/
rvm gemset --force delete testset   # status=0; match=/Removing gemset testset/
rvm gemset list                     # status=0; match!=/ testset$/
