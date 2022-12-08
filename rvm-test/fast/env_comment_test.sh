source "$rvm_path/scripts/rvm"

rvm use 3.1.0 --install

rvm env 3.1.0           # match=/3.1.0/; match=/GEM_HOME=/; match=/GEM_PATH=/
rvm env 3.1.0 --path    # match=/3.1.0/; match=/environments/
rvm env 3.1.0 -- --path # match=/3.1.0/; match=/environments/
