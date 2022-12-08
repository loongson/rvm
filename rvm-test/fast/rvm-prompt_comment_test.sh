source "$rvm_path/scripts/rvm"

command rvm install 3.1.3
command rvm install 3.1.0
command rvm install 3.0.5

rvm 1.9.1 do rvm-prompt      # match=/Ruby (ruby-)?1.9.1(-p[[:digit:]]+)? is not installed./
rvm 3.1.0 do rvm-prompt      # match=/^ruby-3.1.0$/
rvm 3.0.5 do rvm-prompt i    # match=/^ruby$/
rvm 3.0.5 do rvm-prompt i v  # match=/^ruby-3.0.5$/
rvm 3.0.5 do rvm-prompt v    # match=/^3.0.5$/
rvm system do rvm-prompt     # match=/^$/
rvm system do rvm-prompt s v # match=/^system$/
rvm 3.1.3 do rvm-prompt s v  # match=/^3.1.3$/
