source "$rvm_path/scripts/rvm"

rvm use 3.0.1 --install

rvm env 3.0.1           # match=/3.0.1/; match=/GEM_HOME=/; match=/GEM_PATH=/
rvm env 3.0.1 --path    # match=/3.0.1/; match=/environments/
rvm env 3.0.1 -- --path # match=/3.0.1/; match=/environments/
